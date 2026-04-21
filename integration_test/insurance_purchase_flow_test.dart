// Insurance Purchase Integration Test
//
// End-to-end happy-path purchase against the REAL local backend.
// Mirrors the order of calls the Flutter app makes via CreatePolicyCubit:
//
//   signup → getUserAccounts → CreditBalance (sandbox fund)
//     → CreateTransactionPin → GetInsuranceProducts → GetInsuranceQuote
//     → VerifyTransactionPin → PurchaseMarketplaceInsurance
//
// Each run creates a fresh user, so no manual fixture management is required.
//
// Required services (start_all_local_no_docker.sh):
//   - core-gateway grpc        :50070   (auth, accounts proxy, transaction-pin proxy)
//   - products-gateway grpc    :50078   (insurance + financial-products)
//   - accounts-service grpc    :50052   (CreditBalance — internal, not exposed via gateway)
//   - financial-products-svc   :50056   (gRPC dependency of products-gateway)
//
// Run:
//   cd lazervaultapp
//   dart run integration_test/insurance_purchase_flow_test.dart

import 'dart:convert';
import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pb.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/accounts.pb.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart';
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/insurance.pb.dart';
import 'package:lazervault/src/generated/insurance.pbgrpc.dart' as insurance_pb;
import 'package:lazervault/src/generated/financial-products.pb.dart' as fppb;
import 'package:lazervault/src/generated/financial-products.pbgrpc.dart'
    as fp_pb;

// ─── Configuration ────────────────────────────────────────────────────────────
const String grpcHost = 'localhost';
const int coreGatewayPort = 50070;        // auth, accounts, transaction-pin
const int productsGatewayPort = 50078;    // insurance + financial-products
const int accountsServiceDirectPort = 50052; // CreditBalance (internal RPC)

const String testPin = '1234';
const int fundAmountKobo = 50000 * 100;   // ₦50,000 — covers most sandbox premiums
const String testLocale = 'NG';

// ─── Entry point ──────────────────────────────────────────────────────────────
void main() async {
  print('============================================================');
  print('  INSURANCE PURCHASE INTEGRATION TEST (real backend)');
  print('============================================================');

  final coreChannel = _channel(coreGatewayPort);
  final productsChannel = _channel(productsGatewayPort);
  final accountsDirectChannel = _channel(accountsServiceDirectPort);

  int exitCode = 0;
  try {
    final authClient = auth_pb.AuthServiceClient(coreChannel);
    final accountsClient = accounts_pb.AccountsServiceClient(coreChannel);
    final accountsDirectClient =
        accounts_pb.AccountsServiceClient(accountsDirectChannel);
    final pinClient = pin_pb.TransactionPinServiceClient(coreChannel);
    final insuranceClient = insurance_pb.InsuranceServiceClient(productsChannel);
    final fpClient = fp_pb.FinancialProductsServiceClient(productsChannel);

    // ── Step 1: Sign up a fresh user ─────────────────────────────────────────
    final ts = DateTime.now().millisecondsSinceEpoch;
    final email = 'ins-e2e-$ts@lazervault.test';
    final phone = '+23480${(10000000 + (ts % 90000000)).toString()}';
    final password = r'Password1$';
    final deviceId = 'insurance-e2e-$ts';

    print('\n[1] Signing up fresh user $email …');
    final signupResp = await authClient.signup(
      SignupRequest(
        email: email,
        password: password,
        firstName: 'Ins',
        lastName: 'Tester',
        phone: phone,
        deviceId: deviceId,
        deviceName: 'Insurance E2E',
        locale: 'en-NG',
        dateOfBirth: '1995-01-01',
      ),
    );

    String accessToken = signupResp.accessToken;
    String userId = signupResp.userId;
    if (userId.isEmpty && signupResp.hasUser()) userId = signupResp.user.id;

    if (accessToken.isEmpty) {
      print('    ↳ signup returned no token, falling back to login');
      final loginResp = await authClient.login(LoginRequest(
        email: email,
        password: password,
        deviceId: deviceId,
        deviceName: 'Insurance E2E',
      ));
      accessToken = loginResp.hasData() &&
              loginResp.data.session.accessToken.isNotEmpty
          ? loginResp.data.session.accessToken
          : loginResp.accessToken;
      if (userId.isEmpty && loginResp.hasData()) {
        userId = loginResp.data.session.userId.isNotEmpty
            ? loginResp.data.session.userId
            : loginResp.data.user.id;
      }
    }

    if (accessToken.isEmpty) _fail('Could not obtain access token');
    if (userId.isEmpty) userId = _userIdFromJwt(accessToken);
    if (userId.isEmpty) _fail('Could not derive user_id');
    print('    ✓ user_id=$userId');

    await _runFlow(
      accessToken: accessToken,
      userId: userId,
      email: email,
      accountsClient: accountsClient,
      accountsDirectClient: accountsDirectClient,
      pinClient: pinClient,
      insuranceClient: insuranceClient,
      fpClient: fpClient,
    );
  } catch (e, st) {
    print('\n✗ TEST FAILED: $e');
    print(st);
    exitCode = 1;
  } finally {
    await coreChannel.shutdown();
    await productsChannel.shutdown();
    await accountsDirectChannel.shutdown();
  }

  print('\n============================================================');
  print(exitCode == 0 ? '  ✓ INSURANCE PURCHASE TEST PASSED' : '  ✗ FAILED');
  print('============================================================');
  exit(exitCode);
}

// ─── Main flow ───────────────────────────────────────────────────────────────
Future<void> _runFlow({
  required String accessToken,
  required String userId,
  required String email,
  required accounts_pb.AccountsServiceClient accountsClient,
  required accounts_pb.AccountsServiceClient accountsDirectClient,
  required pin_pb.TransactionPinServiceClient pinClient,
  required insurance_pb.InsuranceServiceClient insuranceClient,
  required fp_pb.FinancialProductsServiceClient fpClient,
}) async {
  final auth = _authCallOptions(accessToken);

  // ── Step 2: Get (or create) the user's NGN account ────────────────────────
  // The insurance marketplace (MyCover.ai) only quotes in NGN, so the funded
  // account must be NGN — signup may have auto-provisioned only a USD wallet.
  print('\n[2] Locating an NGN account …');
  var accountsResp = await accountsClient.getUserAccounts(
    GetUserAccountsRequest(),
    options: auth,
  );

  print('    ↳ existing wallets: '
      '${accountsResp.accounts.map((a) => "${a.currency}:${a.uuid}").join(", ")}');

  AccountSummary? ngn = _findNgn(accountsResp.accounts);
  if (ngn == null) {
    print('    ↳ no NGN account, creating one');
    final createResp = await accountsClient.createAccount(
      CreateAccountRequest(
        accountName: 'E2E NGN Wallet',
        accountType: 'personal',
        currency: 'NGN',
        locale: 'en-NG',
        isPrimary: false,
      ),
      options: auth,
    );
    print('    ↳ createAccount → message="${createResp.message}" '
        'currency=${createResp.account.currency} '
        'id=${createResp.account.id}');
    accountsResp = await accountsClient.getUserAccounts(
      GetUserAccountsRequest(),
      options: auth,
    );
    print('    ↳ wallets after create: '
        '${accountsResp.accounts.map((a) => "${a.currency}:${a.uuid}").join(", ")}');
    ngn = _findNgn(accountsResp.accounts);
  }
  if (ngn == null) _fail('No NGN account after CreateAccount');

  final account = ngn;
  final accountId = account.uuid.isNotEmpty ? account.uuid : account.id.toString();
  final initialBalanceKobo = account.balance.toInt();
  print('    ✓ account=$accountId currency=${account.currency} '
      'balance=₦${initialBalanceKobo / 100}');

  // ── Step 3: Fund the wallet (sandbox) ─────────────────────────────────────
  print('\n[3] Crediting account ₦${fundAmountKobo / 100} (direct gRPC :50052)');
  final creditResp = await accountsDirectClient.creditBalance(
    CreditBalanceRequest(
      accountId: accountId,
      userId: userId,
      amount: Int64(fundAmountKobo),
      currency: 'NGN',
      reference: 'E2E-FUND-${DateTime.now().microsecondsSinceEpoch}',
      type: 'deposit',
      description: 'E2E insurance test funding',
      serviceName: 'e2e-test',
      idempotencyKey: 'E2E-FUND-IDEM-${DateTime.now().microsecondsSinceEpoch}',
    ),
  );
  if (!creditResp.success) {
    _fail('CreditBalance failed: ${creditResp.errorCode} ${creditResp.errorMessage}');
  }
  print('    ✓ new_balance=₦${creditResp.newBalance.toInt() / 100} '
      '(available=₦${creditResp.newAvailableBalance.toInt() / 100})');

  // ── Step 4: Create transaction PIN ────────────────────────────────────────
  print('\n[4] Creating transaction PIN …');
  final createPinResp = await pinClient.createTransactionPin(
    CreateTransactionPinRequest(
      userId: userId,
      pin: testPin,
      confirmPin: testPin,
      deviceId: 'insurance-e2e',
      deviceName: 'Insurance E2E',
      channelType: PinChannelType.PIN_CHANNEL_APP,
    ),
    options: auth,
  );
  if (!createPinResp.success) {
    _fail('CreateTransactionPin failed: ${createPinResp.message}');
  }
  print('    ✓ PIN created');

  // ── Step 5: List marketplace products and pick a cheap one ────────────────
  print('\n[5] Fetching insurance marketplace products …');
  final productsResp = await insuranceClient.getInsuranceProducts(
    GetInsuranceProductsRequest()
      ..locale = testLocale
      ..page = 1
      ..limit = 50,
    options: auth,
  );
  if (!productsResp.success || productsResp.products.isEmpty) {
    _fail('GetInsuranceProducts returned empty: ${productsResp.msg}');
  }
  print('    ✓ ${productsResp.products.length} products available');
  // Diagnostic: list categories so we know what's actually being returned.
  final byCategory = <String, int>{};
  for (final p in productsResp.products) {
    byCategory[p.category] = (byCategory[p.category] ?? 0) + 1;
  }
  print('    ↳ categories: $byCategory');
  for (final p in productsResp.products.take(15)) {
    print('       - [${p.category}] ${p.name} '
        '(min=₦${p.minPremium} active=${p.isActive})');
  }

  // Categories whose form_fields metadata is well-defined and whose MyCover
  // backend won't ask for hidden gadget/credit-life fields. Bias selection to
  // these — fall back to anything if none are found.
  const preferredCategories = {'travel', 'health', 'auto', 'motor', 'home'};
  // Product name keywords that historically demand undocumented device fields.
  const skipNamePatterns = ['credplus', 'cred plus', 'device', 'gadget', 'phone'];

  // Note: every product currently has isActive=false in the sandbox catalog,
  // but the backend still routes them to MyCover. Don't filter on isActive.
  //
  // We DO need to skip products whose form_fields require values that the
  // test can't synthesise (real vehicle/engine/chassis numbers, real device
  // serials, valid Nigerian state options pulled from an auxiliary endpoint
  // that returns no inline options, etc.). Reject any product whose schema
  // mentions one of these field-name fragments OR has a select with no
  // declared options.
  const complexFieldFragments = [
    'vehicle', 'engine', 'chassis', 'registration_number', 'plate',
    'device_make', 'device_model', 'serial', 'imei', 'repayment',
    'building', 'property', 'sum_insured', 'sum_assured',
    'beneficiary_bvn', 'bvn', 'nin',
  ];

  bool isSkipped(InsuranceProduct p) {
    final name = p.name.toLowerCase();
    if (skipNamePatterns.any(name.contains)) return true;
    if (p.category.toLowerCase() == 'life') return true;
    for (final f in p.formFields) {
      final fname = f.name.toLowerCase();
      if (complexFieldFragments.any(fname.contains)) return true;
      // A required select with no inline options means the value comes from
      // an auxiliary lookup we can't satisfy.
      if (f.required &&
          f.type.toLowerCase() == 'select' &&
          f.options.isEmpty) {
        return true;
      }
    }
    return false;
  }

  // Sort candidates: preferred categories first, then by premium ascending.
  final candidates = productsResp.products.where((p) => !isSkipped(p)).toList()
    ..sort((a, b) {
      final ap = preferredCategories.contains(a.category.toLowerCase()) ? 0 : 1;
      final bp = preferredCategories.contains(b.category.toLowerCase()) ? 0 : 1;
      if (ap != bp) return ap - bp;
      final apr = a.minPremium > 0 ? a.minPremium : a.basePrice;
      final bpr = b.minPremium > 0 ? b.minPremium : b.basePrice;
      return apr.compareTo(bpr);
    });

  if (candidates.isEmpty) _fail('No candidate insurance products after filtering');

  // Print top candidates so the user can see what's being tried.
  print('    ↳ ${candidates.length} candidates after filtering. Top 8:');
  for (final p in candidates.take(8)) {
    print('       - [${p.category}] ${p.name} '
        '(min=₦${p.minPremium}, ${p.formFields.length} fields)');
  }

  // Quote each candidate first; only those whose quote succeeds AND whose
  // premium fits the wallet are eligible for the purchase loop below.
  final quoted = <_QuotedCandidate>[];
  for (final p in candidates.take(8)) {
    final premium = p.minPremium > 0 ? p.minPremium : p.basePrice;
    if (premium > 0 && premium * 100 > fundAmountKobo) continue;
    final fd = _buildFormData(p, email: email);
    try {
      final qr = await insuranceClient.getInsuranceQuote(
        (GetInsuranceQuoteRequest()
          ..productId = p.id
          ..locale = testLocale)
          ..formData.addAll(fd),
        options: auth,
      );
      if (qr.success && qr.quote.quoteId.isNotEmpty &&
          qr.quote.premium * 100 <= fundAmountKobo) {
        quoted.add(_QuotedCandidate(p, qr.quote, fd));
      }
    } catch (_) {/* skip */}
  }
  if (quoted.isEmpty) _fail('No candidate produced a usable quote');
  print('    ✓ ${quoted.length} candidates have quotes within budget');

  // ── Steps 7+8: try PIN-verify + purchase against each quoted candidate. ──
  // Stop on the first success. MyCover sometimes hard-fails specific products
  // with "Could not obtain policy number" — moving to the next candidate is
  // the only way to find one that the sandbox actually issues policies for.
  InsuranceProduct? chosen;
  InsuranceQuote? quote;
  Map<String, String>? formData;
  fppb.PurchaseMarketplaceInsuranceResponse? purchaseResp;
  String? successTxnId;

  for (final c in quoted) {
    print('\n— attempting purchase: ${c.product.name} '
        '(₦${c.quote.premium}) —');
    final txnId = 'INS-E2E-${DateTime.now().microsecondsSinceEpoch}';
    final pinResp = await pinClient.verifyTransactionPin(
      VerifyTransactionPinRequest(
        userId: userId,
        pin: testPin,
        transactionId: txnId,
        transactionType: 'insurance_purchase',
        amount: c.quote.premium,
        currency: c.quote.currency.isNotEmpty ? c.quote.currency : 'NGN',
        deviceId: 'insurance-e2e',
        channelType: PinChannelType.PIN_CHANNEL_APP,
      ),
      options: auth,
    );
    if (!pinResp.success || pinResp.verificationToken.isEmpty) {
      print('   ✗ PIN verify failed: ${pinResp.message}');
      continue;
    }

    final idem = 'INS-E2E-IDEM-${DateTime.now().microsecondsSinceEpoch}';
    final pReq = fppb.PurchaseMarketplaceInsuranceRequest()
      ..quoteId = c.quote.quoteId
      ..productId = c.product.id
      ..accountId = accountId
      ..transactionPinToken = pinResp.verificationToken
      ..idempotencyKey = idem
      ..locale = testLocale
      ..pinTransactionId = txnId;
    pReq.formData.addAll(c.formData);

    try {
      final resp = await fpClient.purchaseMarketplaceInsurance(pReq, options: auth);
      print('   ↳ message="${resp.message}" hasResult=${resp.hasResult()}');
      if (resp.hasResult()) {
        print('   ↳ policy_id=${resp.result.policyId} '
            'policy_number=${resp.result.policyNumber} '
            'status=${resp.result.status}');
      }
      final ok = (resp.hasResult() && resp.result.policyId.isNotEmpty) ||
          resp.message.toLowerCase().contains('success');
      if (ok) {
        chosen = c.product;
        quote = c.quote;
        formData = c.formData;
        purchaseResp = resp;
        successTxnId = txnId;
        break;
      }
    } catch (e) {
      print('   ✗ purchase failed: $e');
    }
  }

  if (chosen == null || quote == null || purchaseResp == null) {
    _fail('Every quoted candidate failed at the purchase step '
        '(MyCover sandbox is rejecting all of them)');
  }

  print('\n✓ purchase succeeded with ${chosen.name} '
      '(quote ${quote.quoteId}, txn $successTxnId)');
  print('   form_data sent: $formData');

  // ── Step 9: Verify wallet was debited ────────────────────────────────────
  print('\n[9] Re-fetching account to confirm debit …');
  final post = await accountsClient.getUserAccounts(
    GetUserAccountsRequest(),
    options: auth,
  );
  final after = post.accounts.firstWhere(
    (a) => (a.uuid.isNotEmpty ? a.uuid : a.id.toString()) == accountId,
    orElse: () => account,
  );
  final afterKobo = after.balance.toInt();
  final premiumKobo = (quote.premium * 100).round();
  print('    ✓ balance ₦${afterKobo / 100} '
      '(expected debit ≈ ₦${premiumKobo / 100})');
  if (afterKobo > initialBalanceKobo + fundAmountKobo - premiumKobo + 1) {
    _fail('Account was not debited (before=$initialBalanceKobo, after=$afterKobo)');
  }

  print('\n✓✓✓ INSURANCE PURCHASE FLOW SUCCEEDED ✓✓✓');
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

ClientChannel _channel(int port) => ClientChannel(
      grpcHost,
      port: port,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        connectionTimeout: const Duration(seconds: 30),
      ),
    );

CallOptions _authCallOptions(String token) => CallOptions(
      metadata: <String, String>{
        'authorization': 'Bearer $token',
        // accounts-service uses x-locale to choose default account currency.
        // Without this, GetOrCreateDefaultAccounts seeds USD wallets.
        'x-locale': 'en-NG',
      },
      timeout: const Duration(seconds: 60),
    );

class _QuotedCandidate {
  final InsuranceProduct product;
  final InsuranceQuote quote;
  final Map<String, String> formData;
  _QuotedCandidate(this.product, this.quote, this.formData);
}

AccountSummary? _findNgn(Iterable<AccountSummary> accounts) {
  for (final a in accounts) {
    if (a.currency.toUpperCase() == 'NGN') return a;
  }
  return null;
}

Never _fail(String msg) {
  print('    ✗ $msg');
  throw StateError(msg);
}

String _userIdFromJwt(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return '';
    var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
    payload += '=' * ((4 - payload.length % 4) % 4);
    final decoded = utf8.decode(base64.decode(payload));
    final m = RegExp(r'"sub"\s*:\s*"([^"]+)"').firstMatch(decoded);
    return m?.group(1) ?? '';
  } catch (_) {
    return '';
  }
}

/// Build form data dynamically from the product's declared form_fields,
/// falling back to a sensible default set. Honours field type, required flag,
/// and `options` (selects) so that the backend's strict validation passes.
Map<String, String> _buildFormData(
  InsuranceProduct product, {
  required String email,
}) {
  final defaults = <String, String>{
    'first_name': 'Ins',
    'last_name': 'Tester',
    'full_name': 'Ins Tester',
    'email': email,
    'phone': '+2348012345678',
    'phone_number': '+2348012345678',
    'date_of_birth': '1995-01-01',
    'dob': '1995-01-01',
    'age': '30',
    'address': '1 Test Avenue, Lagos',
    'state': 'Lagos',
    'city': 'Lagos',
    'country': 'NG',
    'occupation': 'Software Engineer',
    'next_of_kin': 'Test Kin',
    'next_of_kin_name': 'Test Kin',
    'next_of_kin_phone': '+2348087654321',
    'next_of_kin_relationship': 'sibling',
    // MyCover quirk: some products surface as "life" but their backend
    // actually requires device_*/value fields. The form_fields metadata
    // returned by GetInsuranceProducts does NOT advertise these, but the
    // /v2/products/buy endpoint will reject the payload without them.
    'device_make': 'Apple',
    'device_model': 'iPhone 13',
    'value': '100000',
    'device_value': '100000',
    'sum_assured': '100000',
    'cover_amount': '100000',
    'amount': '100000',
    // MyCover validates payment_plan as numeric (`/payment_plan must be number`).
    // 1 has worked across health/microinsurance products in their sandbox.
    'payment_plan': '1',
    'plan': '1',
    'duration': '1',
    // Some products require an image_url (selfie / proof) at purchase time
    // even though their form_fields don't advertise it.
    'image_url': 'https://placehold.co/200x200.jpg',
    'photo_url': 'https://placehold.co/200x200.jpg',
    'selfie_url': 'https://placehold.co/200x200.jpg',
  };

  final out = <String, String>{};

  // Some MyCover products require fields that GetInsuranceProducts doesn't
  // declare in form_fields (device_make / device_model / value, etc.). Always
  // include them so /v2/products/buy doesn't reject the payload — they're
  // ignored by products that don't read them.
  const alwaysInclude = <String>[
    'device_make',
    'device_model',
    'value',
    'sum_assured',
    'payment_plan',
    'image_url',
  ];
  for (final k in alwaysInclude) {
    if (defaults.containsKey(k)) out[k] = defaults[k]!;
  }

  if (product.formFields.isEmpty) {
    out.addAll(defaults);
    return out;
  }

  for (final f in product.formFields) {
    final key = f.name;
    final type = f.type.toLowerCase();

    // Selects always use one of the declared options (case matters).
    if (f.options.isNotEmpty) {
      // Prefer a default value that matches an option (case-insensitive).
      if (defaults.containsKey(key)) {
        final wanted = defaults[key]!.toLowerCase();
        final match = f.options.firstWhere(
          (o) => o.toLowerCase() == wanted,
          orElse: () => f.options.first,
        );
        out[key] = match;
      } else {
        out[key] = f.options.first;
      }
      continue;
    }

    if (defaults.containsKey(key)) {
      out[key] = defaults[key]!;
      continue;
    }
    if (f.defaultValue.isNotEmpty) {
      out[key] = f.defaultValue;
      continue;
    }

    // Type-aware fallbacks for fields the defaults map doesn't cover.
    switch (type) {
      case 'boolean':
      case 'bool':
      case 'checkbox':
        out[key] = 'true';
        break;
      case 'number':
      case 'integer':
        out[key] = '1';
        break;
      case 'date':
        out[key] = '1995-01-01';
        break;
      case 'email':
        out[key] = email;
        break;
      case 'phone':
        out[key] = '+2348012345678';
        break;
      default:
        // Heuristics for common name patterns the defaults map missed.
        if (key.contains('name')) {
          out[key] = 'Test ${key.replaceAll('_', ' ')}';
        } else if (key.contains('phone')) {
          out[key] = '+2348012345678';
        } else if (key.contains('email')) {
          out[key] = email;
        } else if (key.contains('address')) {
          out[key] = '1 Test Avenue, Lagos';
        } else {
          out[key] = 'Test';
        }
    }
  }
  return out;
}

