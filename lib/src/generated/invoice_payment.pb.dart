//
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'account.pbenum.dart' as $1;
import 'common.pbenum.dart' as $43;
import 'google/protobuf/timestamp.pb.dart' as $42;

/// Invoice Payment Details Message
class InvoicePaymentDetails extends $pb.GeneratedMessage {
  factory InvoicePaymentDetails({
    $43.PaymentMethodType? method,
    $core.double? amount,
    $core.String? currency,
    $core.String? cardLast4,
    $core.String? accountId,
    $core.String? reference,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? cryptoWalletAddress,
    $core.String? cryptoTransactionHash,
    $core.double? feeAmount,
    $core.String? paymentProcessor,
  }) {
    final $result = create();
    if (method != null) {
      $result.method = method;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (cardLast4 != null) {
      $result.cardLast4 = cardLast4;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (cryptoWalletAddress != null) {
      $result.cryptoWalletAddress = cryptoWalletAddress;
    }
    if (cryptoTransactionHash != null) {
      $result.cryptoTransactionHash = cryptoTransactionHash;
    }
    if (feeAmount != null) {
      $result.feeAmount = feeAmount;
    }
    if (paymentProcessor != null) {
      $result.paymentProcessor = paymentProcessor;
    }
    return $result;
  }
  InvoicePaymentDetails._() : super();
  factory InvoicePaymentDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoicePaymentDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<$43.PaymentMethodType>(1, _omitFieldNames ? '' : 'method', $pb.PbFieldType.OE, defaultOrMaker: $43.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $43.PaymentMethodType.valueOf, enumValues: $43.PaymentMethodType.values)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'cardLast4')
    ..aOS(5, _omitFieldNames ? '' : 'accountId')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..m<$core.String, $core.String>(7, _omitFieldNames ? '' : 'metadata', entryClassName: 'InvoicePaymentDetails.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(8, _omitFieldNames ? '' : 'cryptoWalletAddress')
    ..aOS(9, _omitFieldNames ? '' : 'cryptoTransactionHash')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'paymentProcessor')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentDetails clone() => InvoicePaymentDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentDetails copyWith(void Function(InvoicePaymentDetails) updates) => super.copyWith((message) => updates(message as InvoicePaymentDetails)) as InvoicePaymentDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoicePaymentDetails create() => InvoicePaymentDetails._();
  InvoicePaymentDetails createEmptyInstance() => create();
  static $pb.PbList<InvoicePaymentDetails> createRepeated() => $pb.PbList<InvoicePaymentDetails>();
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoicePaymentDetails>(create);
  static InvoicePaymentDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $43.PaymentMethodType get method => $_getN(0);
  @$pb.TagNumber(1)
  set method($43.PaymentMethodType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cardLast4 => $_getSZ(3);
  @$pb.TagNumber(4)
  set cardLast4($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCardLast4() => $_has(3);
  @$pb.TagNumber(4)
  void clearCardLast4() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(6);

  @$pb.TagNumber(8)
  $core.String get cryptoWalletAddress => $_getSZ(7);
  @$pb.TagNumber(8)
  set cryptoWalletAddress($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCryptoWalletAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearCryptoWalletAddress() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get cryptoTransactionHash => $_getSZ(8);
  @$pb.TagNumber(9)
  set cryptoTransactionHash($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCryptoTransactionHash() => $_has(8);
  @$pb.TagNumber(9)
  void clearCryptoTransactionHash() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get feeAmount => $_getN(9);
  @$pb.TagNumber(10)
  set feeAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasFeeAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearFeeAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentProcessor => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentProcessor($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentProcessor() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentProcessor() => clearField(11);
}

/// Invoice Payment Result Message
class InvoicePaymentResult extends $pb.GeneratedMessage {
  factory InvoicePaymentResult({
    $core.bool? success,
    $core.String? transactionId,
    $core.String? paymentReference,
    $core.String? errorMessage,
    $43.InvoicePaymentStatus? status,
    $42.Timestamp? processedAt,
    $core.double? amountProcessed,
    $core.double? feeAmount,
    $core.String? receiptUrl,
    $core.String? confirmationCode,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (paymentReference != null) {
      $result.paymentReference = paymentReference;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (status != null) {
      $result.status = status;
    }
    if (processedAt != null) {
      $result.processedAt = processedAt;
    }
    if (amountProcessed != null) {
      $result.amountProcessed = amountProcessed;
    }
    if (feeAmount != null) {
      $result.feeAmount = feeAmount;
    }
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    if (confirmationCode != null) {
      $result.confirmationCode = confirmationCode;
    }
    return $result;
  }
  InvoicePaymentResult._() : super();
  factory InvoicePaymentResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoicePaymentResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'paymentReference')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..e<$43.InvoicePaymentStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..aOM<$42.Timestamp>(6, _omitFieldNames ? '' : 'processedAt', subBuilder: $42.Timestamp.create)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amountProcessed', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'receiptUrl')
    ..aOS(10, _omitFieldNames ? '' : 'confirmationCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentResult clone() => InvoicePaymentResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentResult copyWith(void Function(InvoicePaymentResult) updates) => super.copyWith((message) => updates(message as InvoicePaymentResult)) as InvoicePaymentResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoicePaymentResult create() => InvoicePaymentResult._();
  InvoicePaymentResult createEmptyInstance() => create();
  static $pb.PbList<InvoicePaymentResult> createRepeated() => $pb.PbList<InvoicePaymentResult>();
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoicePaymentResult>(create);
  static InvoicePaymentResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get paymentReference => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentReference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => clearField(4);

  @$pb.TagNumber(5)
  $43.InvoicePaymentStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status($43.InvoicePaymentStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $42.Timestamp get processedAt => $_getN(5);
  @$pb.TagNumber(6)
  set processedAt($42.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasProcessedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearProcessedAt() => clearField(6);
  @$pb.TagNumber(6)
  $42.Timestamp ensureProcessedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.double get amountProcessed => $_getN(6);
  @$pb.TagNumber(7)
  set amountProcessed($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountProcessed() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountProcessed() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get feeAmount => $_getN(7);
  @$pb.TagNumber(8)
  set feeAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFeeAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearFeeAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get receiptUrl => $_getSZ(8);
  @$pb.TagNumber(9)
  set receiptUrl($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReceiptUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearReceiptUrl() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get confirmationCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set confirmationCode($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasConfirmationCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearConfirmationCode() => clearField(10);
}

/// Invoice Payment Transaction Message
class InvoicePaymentTransaction extends $pb.GeneratedMessage {
  factory InvoicePaymentTransaction({
    $core.String? transactionId,
    $core.String? invoiceId,
    $core.String? userId,
    $core.double? amount,
    $core.String? currency,
    $43.PaymentMethodType? paymentMethod,
    $43.InvoicePaymentStatus? status,
    $42.Timestamp? createdAt,
    $42.Timestamp? processedAt,
    $core.String? reference,
    $core.String? description,
    $core.double? feeAmount,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? paymentProcessorId,
    $core.String? receiptUrl,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (paymentMethod != null) {
      $result.paymentMethod = paymentMethod;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (processedAt != null) {
      $result.processedAt = processedAt;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (description != null) {
      $result.description = description;
    }
    if (feeAmount != null) {
      $result.feeAmount = feeAmount;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (paymentProcessorId != null) {
      $result.paymentProcessorId = paymentProcessorId;
    }
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    return $result;
  }
  InvoicePaymentTransaction._() : super();
  factory InvoicePaymentTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoicePaymentTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..e<$43.PaymentMethodType>(6, _omitFieldNames ? '' : 'paymentMethod', $pb.PbFieldType.OE, defaultOrMaker: $43.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $43.PaymentMethodType.valueOf, enumValues: $43.PaymentMethodType.values)
    ..e<$43.InvoicePaymentStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(9, _omitFieldNames ? '' : 'processedAt', subBuilder: $42.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'reference')
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.String>(13, _omitFieldNames ? '' : 'metadata', entryClassName: 'InvoicePaymentTransaction.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(14, _omitFieldNames ? '' : 'paymentProcessorId')
    ..aOS(15, _omitFieldNames ? '' : 'receiptUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentTransaction clone() => InvoicePaymentTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentTransaction copyWith(void Function(InvoicePaymentTransaction) updates) => super.copyWith((message) => updates(message as InvoicePaymentTransaction)) as InvoicePaymentTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoicePaymentTransaction create() => InvoicePaymentTransaction._();
  InvoicePaymentTransaction createEmptyInstance() => create();
  static $pb.PbList<InvoicePaymentTransaction> createRepeated() => $pb.PbList<InvoicePaymentTransaction>();
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoicePaymentTransaction>(create);
  static InvoicePaymentTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $43.PaymentMethodType get paymentMethod => $_getN(5);
  @$pb.TagNumber(6)
  set paymentMethod($43.PaymentMethodType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentMethod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentMethod() => clearField(6);

  @$pb.TagNumber(7)
  $43.InvoicePaymentStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($43.InvoicePaymentStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $42.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $42.Timestamp get processedAt => $_getN(8);
  @$pb.TagNumber(9)
  set processedAt($42.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasProcessedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearProcessedAt() => clearField(9);
  @$pb.TagNumber(9)
  $42.Timestamp ensureProcessedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(9);
  @$pb.TagNumber(10)
  set reference($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearReference() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get feeAmount => $_getN(11);
  @$pb.TagNumber(12)
  set feeAmount($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFeeAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearFeeAmount() => clearField(12);

  @$pb.TagNumber(13)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(12);

  @$pb.TagNumber(14)
  $core.String get paymentProcessorId => $_getSZ(13);
  @$pb.TagNumber(14)
  set paymentProcessorId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPaymentProcessorId() => $_has(13);
  @$pb.TagNumber(14)
  void clearPaymentProcessorId() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get receiptUrl => $_getSZ(14);
  @$pb.TagNumber(15)
  set receiptUrl($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReceiptUrl() => $_has(14);
  @$pb.TagNumber(15)
  void clearReceiptUrl() => clearField(15);
}

/// User Account Balance Message
class UserAccountBalance extends $pb.GeneratedMessage {
  factory UserAccountBalance({
    $core.String? userId,
    $core.String? currency,
    $core.double? availableBalance,
    $core.double? pendingBalance,
    $core.double? totalBalance,
    $1.VirtualAccountType? accountType,
    $core.String? accountNumber,
    $42.Timestamp? lastUpdated,
    $core.String? accountName,
    $core.bool? isPrimary,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (pendingBalance != null) {
      $result.pendingBalance = pendingBalance;
    }
    if (totalBalance != null) {
      $result.totalBalance = totalBalance;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    if (accountName != null) {
      $result.accountName = accountName;
    }
    if (isPrimary != null) {
      $result.isPrimary = isPrimary;
    }
    return $result;
  }
  UserAccountBalance._() : super();
  factory UserAccountBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccountBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserAccountBalance', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'pendingBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..e<$1.VirtualAccountType>(6, _omitFieldNames ? '' : 'accountType', $pb.PbFieldType.OE, defaultOrMaker: $1.VirtualAccountType.ACCOUNT_TYPE_UNSPECIFIED, valueOf: $1.VirtualAccountType.valueOf, enumValues: $1.VirtualAccountType.values)
    ..aOS(7, _omitFieldNames ? '' : 'accountNumber')
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $42.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'accountName')
    ..aOB(10, _omitFieldNames ? '' : 'isPrimary')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserAccountBalance clone() => UserAccountBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserAccountBalance copyWith(void Function(UserAccountBalance) updates) => super.copyWith((message) => updates(message as UserAccountBalance)) as UserAccountBalance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserAccountBalance create() => UserAccountBalance._();
  UserAccountBalance createEmptyInstance() => create();
  static $pb.PbList<UserAccountBalance> createRepeated() => $pb.PbList<UserAccountBalance>();
  @$core.pragma('dart2js:noInline')
  static UserAccountBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserAccountBalance>(create);
  static UserAccountBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get availableBalance => $_getN(2);
  @$pb.TagNumber(3)
  set availableBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAvailableBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvailableBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get pendingBalance => $_getN(3);
  @$pb.TagNumber(4)
  set pendingBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPendingBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearPendingBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalBalance => $_getN(4);
  @$pb.TagNumber(5)
  set totalBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalBalance() => clearField(5);

  @$pb.TagNumber(6)
  $1.VirtualAccountType get accountType => $_getN(5);
  @$pb.TagNumber(6)
  set accountType($1.VirtualAccountType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasAccountType() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountNumber() => clearField(7);

  @$pb.TagNumber(8)
  $42.Timestamp get lastUpdated => $_getN(7);
  @$pb.TagNumber(8)
  set lastUpdated($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastUpdated() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdated() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureLastUpdated() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get accountName => $_getSZ(8);
  @$pb.TagNumber(9)
  set accountName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAccountName() => $_has(8);
  @$pb.TagNumber(9)
  void clearAccountName() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPrimary => $_getBF(9);
  @$pb.TagNumber(10)
  set isPrimary($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsPrimary() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPrimary() => clearField(10);
}

/// Payment Method Message
class PaymentMethod extends $pb.GeneratedMessage {
  factory PaymentMethod({
    $core.String? methodId,
    $core.String? userId,
    $43.PaymentMethodType? type,
    $core.String? displayName,
    $core.String? last4,
    $core.String? brand,
    $core.bool? isDefault,
    $core.bool? isVerified,
    $42.Timestamp? expiresAt,
    $42.Timestamp? createdAt,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? billingAddress,
  }) {
    final $result = create();
    if (methodId != null) {
      $result.methodId = methodId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (last4 != null) {
      $result.last4 = last4;
    }
    if (brand != null) {
      $result.brand = brand;
    }
    if (isDefault != null) {
      $result.isDefault = isDefault;
    }
    if (isVerified != null) {
      $result.isVerified = isVerified;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (billingAddress != null) {
      $result.billingAddress = billingAddress;
    }
    return $result;
  }
  PaymentMethod._() : super();
  factory PaymentMethod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentMethod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentMethod', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'methodId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<$43.PaymentMethodType>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $43.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $43.PaymentMethodType.valueOf, enumValues: $43.PaymentMethodType.values)
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..aOS(5, _omitFieldNames ? '' : 'last4')
    ..aOS(6, _omitFieldNames ? '' : 'brand')
    ..aOB(7, _omitFieldNames ? '' : 'isDefault')
    ..aOB(8, _omitFieldNames ? '' : 'isVerified')
    ..aOM<$42.Timestamp>(9, _omitFieldNames ? '' : 'expiresAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..m<$core.String, $core.String>(11, _omitFieldNames ? '' : 'metadata', entryClassName: 'PaymentMethod.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(12, _omitFieldNames ? '' : 'billingAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentMethod clone() => PaymentMethod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentMethod copyWith(void Function(PaymentMethod) updates) => super.copyWith((message) => updates(message as PaymentMethod)) as PaymentMethod;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentMethod create() => PaymentMethod._();
  PaymentMethod createEmptyInstance() => create();
  static $pb.PbList<PaymentMethod> createRepeated() => $pb.PbList<PaymentMethod>();
  @$core.pragma('dart2js:noInline')
  static PaymentMethod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentMethod>(create);
  static PaymentMethod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get methodId => $_getSZ(0);
  @$pb.TagNumber(1)
  set methodId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethodId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $43.PaymentMethodType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type($43.PaymentMethodType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get last4 => $_getSZ(4);
  @$pb.TagNumber(5)
  set last4($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLast4() => $_has(4);
  @$pb.TagNumber(5)
  void clearLast4() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get brand => $_getSZ(5);
  @$pb.TagNumber(6)
  set brand($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBrand() => $_has(5);
  @$pb.TagNumber(6)
  void clearBrand() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isDefault => $_getBF(6);
  @$pb.TagNumber(7)
  set isDefault($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsDefault() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsDefault() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isVerified => $_getBF(7);
  @$pb.TagNumber(8)
  set isVerified($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsVerified() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsVerified() => clearField(8);

  @$pb.TagNumber(9)
  $42.Timestamp get expiresAt => $_getN(8);
  @$pb.TagNumber(9)
  set expiresAt($42.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasExpiresAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiresAt() => clearField(9);
  @$pb.TagNumber(9)
  $42.Timestamp ensureExpiresAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $42.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($42.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $42.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(10);

  @$pb.TagNumber(12)
  $core.String get billingAddress => $_getSZ(11);
  @$pb.TagNumber(12)
  set billingAddress($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBillingAddress() => $_has(11);
  @$pb.TagNumber(12)
  void clearBillingAddress() => clearField(12);
}

/// Crypto Wallet Message
class InvoiceCryptoWallet extends $pb.GeneratedMessage {
  factory InvoiceCryptoWallet({
    $core.String? walletId,
    $core.String? userId,
    $core.String? walletAddress,
    $core.String? currency,
    $core.double? balance,
    $core.bool? isVerified,
    $42.Timestamp? createdAt,
    $42.Timestamp? lastSync,
    $core.String? network,
    $core.String? walletType,
  }) {
    final $result = create();
    if (walletId != null) {
      $result.walletId = walletId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (walletAddress != null) {
      $result.walletAddress = walletAddress;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (isVerified != null) {
      $result.isVerified = isVerified;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (lastSync != null) {
      $result.lastSync = lastSync;
    }
    if (network != null) {
      $result.network = network;
    }
    if (walletType != null) {
      $result.walletType = walletType;
    }
    return $result;
  }
  InvoiceCryptoWallet._() : super();
  factory InvoiceCryptoWallet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceCryptoWallet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceCryptoWallet', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'walletAddress')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOB(6, _omitFieldNames ? '' : 'isVerified')
    ..aOM<$42.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'lastSync', subBuilder: $42.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'network')
    ..aOS(10, _omitFieldNames ? '' : 'walletType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceCryptoWallet clone() => InvoiceCryptoWallet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceCryptoWallet copyWith(void Function(InvoiceCryptoWallet) updates) => super.copyWith((message) => updates(message as InvoiceCryptoWallet)) as InvoiceCryptoWallet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceCryptoWallet create() => InvoiceCryptoWallet._();
  InvoiceCryptoWallet createEmptyInstance() => create();
  static $pb.PbList<InvoiceCryptoWallet> createRepeated() => $pb.PbList<InvoiceCryptoWallet>();
  @$core.pragma('dart2js:noInline')
  static InvoiceCryptoWallet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceCryptoWallet>(create);
  static InvoiceCryptoWallet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get walletAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set walletAddress($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWalletAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearWalletAddress() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get balance => $_getN(4);
  @$pb.TagNumber(5)
  set balance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isVerified => $_getBF(5);
  @$pb.TagNumber(6)
  set isVerified($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsVerified() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsVerified() => clearField(6);

  @$pb.TagNumber(7)
  $42.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($42.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $42.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $42.Timestamp get lastSync => $_getN(7);
  @$pb.TagNumber(8)
  set lastSync($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastSync() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastSync() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureLastSync() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get network => $_getSZ(8);
  @$pb.TagNumber(9)
  set network($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasNetwork() => $_has(8);
  @$pb.TagNumber(9)
  void clearNetwork() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get walletType => $_getSZ(9);
  @$pb.TagNumber(10)
  set walletType($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasWalletType() => $_has(9);
  @$pb.TagNumber(10)
  void clearWalletType() => clearField(10);
}

/// Payment Extension Request Message
class PaymentExtensionRequest extends $pb.GeneratedMessage {
  factory PaymentExtensionRequest({
    $core.String? extensionId,
    $core.String? invoiceId,
    $core.String? userId,
    $42.Timestamp? newDueDate,
    $core.String? reason,
    $core.String? status,
    $42.Timestamp? requestedAt,
    $42.Timestamp? approvedAt,
    $core.String? approvedBy,
    $core.String? rejectionReason,
  }) {
    final $result = create();
    if (extensionId != null) {
      $result.extensionId = extensionId;
    }
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (newDueDate != null) {
      $result.newDueDate = newDueDate;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (status != null) {
      $result.status = status;
    }
    if (requestedAt != null) {
      $result.requestedAt = requestedAt;
    }
    if (approvedAt != null) {
      $result.approvedAt = approvedAt;
    }
    if (approvedBy != null) {
      $result.approvedBy = approvedBy;
    }
    if (rejectionReason != null) {
      $result.rejectionReason = rejectionReason;
    }
    return $result;
  }
  PaymentExtensionRequest._() : super();
  factory PaymentExtensionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentExtensionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentExtensionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'extensionId')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOM<$42.Timestamp>(4, _omitFieldNames ? '' : 'newDueDate', subBuilder: $42.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOM<$42.Timestamp>(7, _omitFieldNames ? '' : 'requestedAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'approvedAt', subBuilder: $42.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'approvedBy')
    ..aOS(10, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentExtensionRequest clone() => PaymentExtensionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentExtensionRequest copyWith(void Function(PaymentExtensionRequest) updates) => super.copyWith((message) => updates(message as PaymentExtensionRequest)) as PaymentExtensionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentExtensionRequest create() => PaymentExtensionRequest._();
  PaymentExtensionRequest createEmptyInstance() => create();
  static $pb.PbList<PaymentExtensionRequest> createRepeated() => $pb.PbList<PaymentExtensionRequest>();
  @$core.pragma('dart2js:noInline')
  static PaymentExtensionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentExtensionRequest>(create);
  static PaymentExtensionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get extensionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set extensionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExtensionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExtensionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $42.Timestamp get newDueDate => $_getN(3);
  @$pb.TagNumber(4)
  set newDueDate($42.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewDueDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewDueDate() => clearField(4);
  @$pb.TagNumber(4)
  $42.Timestamp ensureNewDueDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $42.Timestamp get requestedAt => $_getN(6);
  @$pb.TagNumber(7)
  set requestedAt($42.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequestedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequestedAt() => clearField(7);
  @$pb.TagNumber(7)
  $42.Timestamp ensureRequestedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $42.Timestamp get approvedAt => $_getN(7);
  @$pb.TagNumber(8)
  set approvedAt($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasApprovedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearApprovedAt() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureApprovedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get approvedBy => $_getSZ(8);
  @$pb.TagNumber(9)
  set approvedBy($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasApprovedBy() => $_has(8);
  @$pb.TagNumber(9)
  void clearApprovedBy() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get rejectionReason => $_getSZ(9);
  @$pb.TagNumber(10)
  set rejectionReason($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRejectionReason() => $_has(9);
  @$pb.TagNumber(10)
  void clearRejectionReason() => clearField(10);
}

/// Payment Dispute Message
class PaymentDispute extends $pb.GeneratedMessage {
  factory PaymentDispute({
    $core.String? disputeId,
    $core.String? transactionId,
    $core.String? invoiceId,
    $core.String? userId,
    $core.String? reason,
    $core.String? description,
    $43.DisputeStatus? status,
    $core.double? amount,
    $core.String? currency,
    $42.Timestamp? createdAt,
    $42.Timestamp? resolvedAt,
    $core.String? resolution,
    $core.Iterable<$core.String>? evidenceFiles,
  }) {
    final $result = create();
    if (disputeId != null) {
      $result.disputeId = disputeId;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (description != null) {
      $result.description = description;
    }
    if (status != null) {
      $result.status = status;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (resolvedAt != null) {
      $result.resolvedAt = resolvedAt;
    }
    if (resolution != null) {
      $result.resolution = resolution;
    }
    if (evidenceFiles != null) {
      $result.evidenceFiles.addAll(evidenceFiles);
    }
    return $result;
  }
  PaymentDispute._() : super();
  factory PaymentDispute.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentDispute.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentDispute', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'disputeId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..e<$43.DisputeStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $43.DisputeStatus.DISPUTE_STATUS_PENDING, valueOf: $43.DisputeStatus.valueOf, enumValues: $43.DisputeStatus.values)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..aOM<$42.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(11, _omitFieldNames ? '' : 'resolvedAt', subBuilder: $42.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'resolution')
    ..pPS(13, _omitFieldNames ? '' : 'evidenceFiles')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentDispute clone() => PaymentDispute()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentDispute copyWith(void Function(PaymentDispute) updates) => super.copyWith((message) => updates(message as PaymentDispute)) as PaymentDispute;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentDispute create() => PaymentDispute._();
  PaymentDispute createEmptyInstance() => create();
  static $pb.PbList<PaymentDispute> createRepeated() => $pb.PbList<PaymentDispute>();
  @$core.pragma('dart2js:noInline')
  static PaymentDispute getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentDispute>(create);
  static PaymentDispute? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get disputeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set disputeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisputeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisputeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get invoiceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set invoiceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInvoiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvoiceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $43.DisputeStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($43.DisputeStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $42.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($42.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $42.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $42.Timestamp get resolvedAt => $_getN(10);
  @$pb.TagNumber(11)
  set resolvedAt($42.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasResolvedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearResolvedAt() => clearField(11);
  @$pb.TagNumber(11)
  $42.Timestamp ensureResolvedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get resolution => $_getSZ(11);
  @$pb.TagNumber(12)
  set resolution($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasResolution() => $_has(11);
  @$pb.TagNumber(12)
  void clearResolution() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.String> get evidenceFiles => $_getList(12);
}

/// Core Invoice Payment Operations
class ProcessInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory ProcessInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? paymentMethodId,
    $core.double? amount,
    $core.String? currency,
    $core.String? description,
    $core.Map<$core.String, $core.String>? metadata,
    $core.bool? savePaymentMethod,
    $core.String? billingAddress,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (paymentMethodId != null) {
      $result.paymentMethodId = paymentMethodId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (savePaymentMethod != null) {
      $result.savePaymentMethod = savePaymentMethod;
    }
    if (billingAddress != null) {
      $result.billingAddress = billingAddress;
    }
    return $result;
  }
  ProcessInvoicePaymentRequest._() : super();
  factory ProcessInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethodId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'metadata', entryClassName: 'ProcessInvoicePaymentRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(7, _omitFieldNames ? '' : 'savePaymentMethod')
    ..aOS(8, _omitFieldNames ? '' : 'billingAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentRequest clone() => ProcessInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentRequest copyWith(void Function(ProcessInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessInvoicePaymentRequest)) as ProcessInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessInvoicePaymentRequest create() => ProcessInvoicePaymentRequest._();
  ProcessInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessInvoicePaymentRequest> createRepeated() => $pb.PbList<ProcessInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessInvoicePaymentRequest>(create);
  static ProcessInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethodId => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethodId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethodId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethodId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(5);

  @$pb.TagNumber(7)
  $core.bool get savePaymentMethod => $_getBF(6);
  @$pb.TagNumber(7)
  set savePaymentMethod($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSavePaymentMethod() => $_has(6);
  @$pb.TagNumber(7)
  void clearSavePaymentMethod() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get billingAddress => $_getSZ(7);
  @$pb.TagNumber(8)
  set billingAddress($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBillingAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearBillingAddress() => clearField(8);
}

class ProcessInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory ProcessInvoicePaymentResponse({
    InvoicePaymentResult? result,
    $core.String? message,
    $core.bool? success,
    $core.String? nextAction,
    $core.Map<$core.String, $core.String>? additionalData,
  }) {
    final $result = create();
    if (result != null) {
      $result.result = result;
    }
    if (message != null) {
      $result.message = message;
    }
    if (success != null) {
      $result.success = success;
    }
    if (nextAction != null) {
      $result.nextAction = nextAction;
    }
    if (additionalData != null) {
      $result.additionalData.addAll(additionalData);
    }
    return $result;
  }
  ProcessInvoicePaymentResponse._() : super();
  factory ProcessInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvoicePaymentResult>(1, _omitFieldNames ? '' : 'result', subBuilder: InvoicePaymentResult.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'nextAction')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'additionalData', entryClassName: 'ProcessInvoicePaymentResponse.AdditionalDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentResponse clone() => ProcessInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentResponse copyWith(void Function(ProcessInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessInvoicePaymentResponse)) as ProcessInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessInvoicePaymentResponse create() => ProcessInvoicePaymentResponse._();
  ProcessInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessInvoicePaymentResponse> createRepeated() => $pb.PbList<ProcessInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessInvoicePaymentResponse>(create);
  static ProcessInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InvoicePaymentResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(InvoicePaymentResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  InvoicePaymentResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get nextAction => $_getSZ(3);
  @$pb.TagNumber(4)
  set nextAction($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNextAction() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextAction() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get additionalData => $_getMap(4);
}

class ProcessPartialInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory ProcessPartialInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? paymentMethodId,
    $core.double? partialAmount,
    $core.String? currency,
    $core.String? description,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (paymentMethodId != null) {
      $result.paymentMethodId = paymentMethodId;
    }
    if (partialAmount != null) {
      $result.partialAmount = partialAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (description != null) {
      $result.description = description;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  ProcessPartialInvoicePaymentRequest._() : super();
  factory ProcessPartialInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPartialInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessPartialInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethodId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'partialAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'metadata', entryClassName: 'ProcessPartialInvoicePaymentRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentRequest clone() => ProcessPartialInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentRequest copyWith(void Function(ProcessPartialInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessPartialInvoicePaymentRequest)) as ProcessPartialInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPartialInvoicePaymentRequest create() => ProcessPartialInvoicePaymentRequest._();
  ProcessPartialInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPartialInvoicePaymentRequest> createRepeated() => $pb.PbList<ProcessPartialInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPartialInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPartialInvoicePaymentRequest>(create);
  static ProcessPartialInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethodId => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethodId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethodId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethodId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get partialAmount => $_getN(2);
  @$pb.TagNumber(3)
  set partialAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPartialAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPartialAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(5);
}

class ProcessPartialInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory ProcessPartialInvoicePaymentResponse({
    InvoicePaymentResult? result,
    $core.double? remainingAmount,
    $core.String? message,
    $core.bool? success,
  }) {
    final $result = create();
    if (result != null) {
      $result.result = result;
    }
    if (remainingAmount != null) {
      $result.remainingAmount = remainingAmount;
    }
    if (message != null) {
      $result.message = message;
    }
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  ProcessPartialInvoicePaymentResponse._() : super();
  factory ProcessPartialInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPartialInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessPartialInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvoicePaymentResult>(1, _omitFieldNames ? '' : 'result', subBuilder: InvoicePaymentResult.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'remainingAmount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOB(4, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentResponse clone() => ProcessPartialInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentResponse copyWith(void Function(ProcessPartialInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessPartialInvoicePaymentResponse)) as ProcessPartialInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPartialInvoicePaymentResponse create() => ProcessPartialInvoicePaymentResponse._();
  ProcessPartialInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPartialInvoicePaymentResponse> createRepeated() => $pb.PbList<ProcessPartialInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPartialInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPartialInvoicePaymentResponse>(create);
  static ProcessPartialInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InvoicePaymentResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(InvoicePaymentResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  InvoicePaymentResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get remainingAmount => $_getN(1);
  @$pb.TagNumber(2)
  set remainingAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRemainingAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearRemainingAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get success => $_getBF(3);
  @$pb.TagNumber(4)
  set success($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSuccess() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccess() => clearField(4);
}

class ValidateInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory ValidateInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? paymentMethodId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (paymentMethodId != null) {
      $result.paymentMethodId = paymentMethodId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  ValidateInvoicePaymentRequest._() : super();
  factory ValidateInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethodId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentRequest clone() => ValidateInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentRequest copyWith(void Function(ValidateInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentRequest)) as ValidateInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentRequest create() => ValidateInvoicePaymentRequest._();
  ValidateInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateInvoicePaymentRequest> createRepeated() => $pb.PbList<ValidateInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInvoicePaymentRequest>(create);
  static ValidateInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethodId => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethodId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethodId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethodId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);
}

class ValidateInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory ValidateInvoicePaymentResponse({
    $core.bool? isValid,
    $core.String? validationMessage,
    $core.Iterable<$core.String>? errors,
    $core.double? availableBalance,
    $core.double? paymentFees,
  }) {
    final $result = create();
    if (isValid != null) {
      $result.isValid = isValid;
    }
    if (validationMessage != null) {
      $result.validationMessage = validationMessage;
    }
    if (errors != null) {
      $result.errors.addAll(errors);
    }
    if (availableBalance != null) {
      $result.availableBalance = availableBalance;
    }
    if (paymentFees != null) {
      $result.paymentFees = paymentFees;
    }
    return $result;
  }
  ValidateInvoicePaymentResponse._() : super();
  factory ValidateInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'validationMessage')
    ..pPS(3, _omitFieldNames ? '' : 'errors')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'paymentFees', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentResponse clone() => ValidateInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentResponse copyWith(void Function(ValidateInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentResponse)) as ValidateInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentResponse create() => ValidateInvoicePaymentResponse._();
  ValidateInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateInvoicePaymentResponse> createRepeated() => $pb.PbList<ValidateInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInvoicePaymentResponse>(create);
  static ValidateInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get validationMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set validationMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValidationMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearValidationMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get errors => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get availableBalance => $_getN(3);
  @$pb.TagNumber(4)
  set availableBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAvailableBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailableBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get paymentFees => $_getN(4);
  @$pb.TagNumber(5)
  set paymentFees($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentFees() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentFees() => clearField(5);
}

class GetInvoicePaymentStatusRequest extends $pb.GeneratedMessage {
  factory GetInvoicePaymentStatusRequest({
    $core.String? transactionId,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  GetInvoicePaymentStatusRequest._() : super();
  factory GetInvoicePaymentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusRequest clone() => GetInvoicePaymentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusRequest copyWith(void Function(GetInvoicePaymentStatusRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatusRequest)) as GetInvoicePaymentStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatusRequest create() => GetInvoicePaymentStatusRequest._();
  GetInvoicePaymentStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentStatusRequest> createRepeated() => $pb.PbList<GetInvoicePaymentStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentStatusRequest>(create);
  static GetInvoicePaymentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
}

class GetInvoicePaymentStatusResponse extends $pb.GeneratedMessage {
  factory GetInvoicePaymentStatusResponse({
    InvoicePaymentTransaction? transaction,
    $43.InvoicePaymentStatus? currentStatus,
    $core.String? statusMessage,
    $42.Timestamp? lastUpdated,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (currentStatus != null) {
      $result.currentStatus = currentStatus;
    }
    if (statusMessage != null) {
      $result.statusMessage = statusMessage;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    return $result;
  }
  GetInvoicePaymentStatusResponse._() : super();
  factory GetInvoicePaymentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvoicePaymentTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: InvoicePaymentTransaction.create)
    ..e<$43.InvoicePaymentStatus>(2, _omitFieldNames ? '' : 'currentStatus', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'statusMessage')
    ..aOM<$42.Timestamp>(4, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusResponse clone() => GetInvoicePaymentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusResponse copyWith(void Function(GetInvoicePaymentStatusResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatusResponse)) as GetInvoicePaymentStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatusResponse create() => GetInvoicePaymentStatusResponse._();
  GetInvoicePaymentStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentStatusResponse> createRepeated() => $pb.PbList<GetInvoicePaymentStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentStatusResponse>(create);
  static GetInvoicePaymentStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InvoicePaymentTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(InvoicePaymentTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  InvoicePaymentTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $43.InvoicePaymentStatus get currentStatus => $_getN(1);
  @$pb.TagNumber(2)
  set currentStatus($43.InvoicePaymentStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get statusMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set statusMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusMessage() => clearField(3);

  @$pb.TagNumber(4)
  $42.Timestamp get lastUpdated => $_getN(3);
  @$pb.TagNumber(4)
  set lastUpdated($42.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastUpdated() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastUpdated() => clearField(4);
  @$pb.TagNumber(4)
  $42.Timestamp ensureLastUpdated() => $_ensure(3);
}

class CancelInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory CancelInvoicePaymentRequest({
    $core.String? transactionId,
    $core.String? reason,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  CancelInvoicePaymentRequest._() : super();
  factory CancelInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentRequest clone() => CancelInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentRequest copyWith(void Function(CancelInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as CancelInvoicePaymentRequest)) as CancelInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInvoicePaymentRequest create() => CancelInvoicePaymentRequest._();
  CancelInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CancelInvoicePaymentRequest> createRepeated() => $pb.PbList<CancelInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInvoicePaymentRequest>(create);
  static CancelInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class CancelInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory CancelInvoicePaymentResponse({
    $core.bool? success,
    $core.String? message,
    $43.InvoicePaymentStatus? newStatus,
    $core.double? refundAmount,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (newStatus != null) {
      $result.newStatus = newStatus;
    }
    if (refundAmount != null) {
      $result.refundAmount = refundAmount;
    }
    return $result;
  }
  CancelInvoicePaymentResponse._() : super();
  factory CancelInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<$43.InvoicePaymentStatus>(3, _omitFieldNames ? '' : 'newStatus', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'refundAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentResponse clone() => CancelInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentResponse copyWith(void Function(CancelInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as CancelInvoicePaymentResponse)) as CancelInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInvoicePaymentResponse create() => CancelInvoicePaymentResponse._();
  CancelInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CancelInvoicePaymentResponse> createRepeated() => $pb.PbList<CancelInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInvoicePaymentResponse>(create);
  static CancelInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $43.InvoicePaymentStatus get newStatus => $_getN(2);
  @$pb.TagNumber(3)
  set newStatus($43.InvoicePaymentStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get refundAmount => $_getN(3);
  @$pb.TagNumber(4)
  set refundAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRefundAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefundAmount() => clearField(4);
}

/// Payment Methods Management
class GetUserInvoicePaymentMethodsRequest extends $pb.GeneratedMessage {
  factory GetUserInvoicePaymentMethodsRequest({
    $43.PaymentMethodType? typeFilter,
  }) {
    final $result = create();
    if (typeFilter != null) {
      $result.typeFilter = typeFilter;
    }
    return $result;
  }
  GetUserInvoicePaymentMethodsRequest._() : super();
  factory GetUserInvoicePaymentMethodsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInvoicePaymentMethodsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserInvoicePaymentMethodsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<$43.PaymentMethodType>(1, _omitFieldNames ? '' : 'typeFilter', $pb.PbFieldType.OE, defaultOrMaker: $43.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $43.PaymentMethodType.valueOf, enumValues: $43.PaymentMethodType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsRequest clone() => GetUserInvoicePaymentMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsRequest copyWith(void Function(GetUserInvoicePaymentMethodsRequest) updates) => super.copyWith((message) => updates(message as GetUserInvoicePaymentMethodsRequest)) as GetUserInvoicePaymentMethodsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInvoicePaymentMethodsRequest create() => GetUserInvoicePaymentMethodsRequest._();
  GetUserInvoicePaymentMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInvoicePaymentMethodsRequest> createRepeated() => $pb.PbList<GetUserInvoicePaymentMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInvoicePaymentMethodsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInvoicePaymentMethodsRequest>(create);
  static GetUserInvoicePaymentMethodsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $43.PaymentMethodType get typeFilter => $_getN(0);
  @$pb.TagNumber(1)
  set typeFilter($43.PaymentMethodType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTypeFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeFilter() => clearField(1);
}

class GetUserInvoicePaymentMethodsResponse extends $pb.GeneratedMessage {
  factory GetUserInvoicePaymentMethodsResponse({
    $core.Iterable<PaymentMethod>? paymentMethods,
    PaymentMethod? defaultMethod,
  }) {
    final $result = create();
    if (paymentMethods != null) {
      $result.paymentMethods.addAll(paymentMethods);
    }
    if (defaultMethod != null) {
      $result.defaultMethod = defaultMethod;
    }
    return $result;
  }
  GetUserInvoicePaymentMethodsResponse._() : super();
  factory GetUserInvoicePaymentMethodsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInvoicePaymentMethodsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserInvoicePaymentMethodsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PaymentMethod>(1, _omitFieldNames ? '' : 'paymentMethods', $pb.PbFieldType.PM, subBuilder: PaymentMethod.create)
    ..aOM<PaymentMethod>(2, _omitFieldNames ? '' : 'defaultMethod', subBuilder: PaymentMethod.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsResponse clone() => GetUserInvoicePaymentMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsResponse copyWith(void Function(GetUserInvoicePaymentMethodsResponse) updates) => super.copyWith((message) => updates(message as GetUserInvoicePaymentMethodsResponse)) as GetUserInvoicePaymentMethodsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInvoicePaymentMethodsResponse create() => GetUserInvoicePaymentMethodsResponse._();
  GetUserInvoicePaymentMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInvoicePaymentMethodsResponse> createRepeated() => $pb.PbList<GetUserInvoicePaymentMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInvoicePaymentMethodsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInvoicePaymentMethodsResponse>(create);
  static GetUserInvoicePaymentMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PaymentMethod> get paymentMethods => $_getList(0);

  @$pb.TagNumber(2)
  PaymentMethod get defaultMethod => $_getN(1);
  @$pb.TagNumber(2)
  set defaultMethod(PaymentMethod v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDefaultMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearDefaultMethod() => clearField(2);
  @$pb.TagNumber(2)
  PaymentMethod ensureDefaultMethod() => $_ensure(1);
}

class AddInvoicePaymentMethodRequest extends $pb.GeneratedMessage {
  factory AddInvoicePaymentMethodRequest({
    $43.PaymentMethodType? type,
    $core.String? displayName,
    $core.Map<$core.String, $core.String>? paymentDetails,
    $core.bool? setAsDefault,
    $core.String? billingAddress,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (paymentDetails != null) {
      $result.paymentDetails.addAll(paymentDetails);
    }
    if (setAsDefault != null) {
      $result.setAsDefault = setAsDefault;
    }
    if (billingAddress != null) {
      $result.billingAddress = billingAddress;
    }
    return $result;
  }
  AddInvoicePaymentMethodRequest._() : super();
  factory AddInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddInvoicePaymentMethodRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<$43.PaymentMethodType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $43.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $43.PaymentMethodType.valueOf, enumValues: $43.PaymentMethodType.values)
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'paymentDetails', entryClassName: 'AddInvoicePaymentMethodRequest.PaymentDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(4, _omitFieldNames ? '' : 'setAsDefault')
    ..aOS(5, _omitFieldNames ? '' : 'billingAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodRequest clone() => AddInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodRequest copyWith(void Function(AddInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as AddInvoicePaymentMethodRequest)) as AddInvoicePaymentMethodRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddInvoicePaymentMethodRequest create() => AddInvoicePaymentMethodRequest._();
  AddInvoicePaymentMethodRequest createEmptyInstance() => create();
  static $pb.PbList<AddInvoicePaymentMethodRequest> createRepeated() => $pb.PbList<AddInvoicePaymentMethodRequest>();
  @$core.pragma('dart2js:noInline')
  static AddInvoicePaymentMethodRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddInvoicePaymentMethodRequest>(create);
  static AddInvoicePaymentMethodRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $43.PaymentMethodType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type($43.PaymentMethodType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get paymentDetails => $_getMap(2);

  @$pb.TagNumber(4)
  $core.bool get setAsDefault => $_getBF(3);
  @$pb.TagNumber(4)
  set setAsDefault($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSetAsDefault() => $_has(3);
  @$pb.TagNumber(4)
  void clearSetAsDefault() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get billingAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set billingAddress($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBillingAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearBillingAddress() => clearField(5);
}

class AddInvoicePaymentMethodResponse extends $pb.GeneratedMessage {
  factory AddInvoicePaymentMethodResponse({
    PaymentMethod? paymentMethod,
    $core.bool? success,
    $core.String? message,
    $core.String? verificationUrl,
  }) {
    final $result = create();
    if (paymentMethod != null) {
      $result.paymentMethod = paymentMethod;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (verificationUrl != null) {
      $result.verificationUrl = verificationUrl;
    }
    return $result;
  }
  AddInvoicePaymentMethodResponse._() : super();
  factory AddInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddInvoicePaymentMethodResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentMethod>(1, _omitFieldNames ? '' : 'paymentMethod', subBuilder: PaymentMethod.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'verificationUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodResponse clone() => AddInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodResponse copyWith(void Function(AddInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as AddInvoicePaymentMethodResponse)) as AddInvoicePaymentMethodResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddInvoicePaymentMethodResponse create() => AddInvoicePaymentMethodResponse._();
  AddInvoicePaymentMethodResponse createEmptyInstance() => create();
  static $pb.PbList<AddInvoicePaymentMethodResponse> createRepeated() => $pb.PbList<AddInvoicePaymentMethodResponse>();
  @$core.pragma('dart2js:noInline')
  static AddInvoicePaymentMethodResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddInvoicePaymentMethodResponse>(create);
  static AddInvoicePaymentMethodResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentMethod get paymentMethod => $_getN(0);
  @$pb.TagNumber(1)
  set paymentMethod(PaymentMethod v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentMethod() => clearField(1);
  @$pb.TagNumber(1)
  PaymentMethod ensurePaymentMethod() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVerificationUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationUrl() => clearField(4);
}

class RemoveInvoicePaymentMethodRequest extends $pb.GeneratedMessage {
  factory RemoveInvoicePaymentMethodRequest({
    $core.String? methodId,
  }) {
    final $result = create();
    if (methodId != null) {
      $result.methodId = methodId;
    }
    return $result;
  }
  RemoveInvoicePaymentMethodRequest._() : super();
  factory RemoveInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveInvoicePaymentMethodRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'methodId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodRequest clone() => RemoveInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodRequest copyWith(void Function(RemoveInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as RemoveInvoicePaymentMethodRequest)) as RemoveInvoicePaymentMethodRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveInvoicePaymentMethodRequest create() => RemoveInvoicePaymentMethodRequest._();
  RemoveInvoicePaymentMethodRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveInvoicePaymentMethodRequest> createRepeated() => $pb.PbList<RemoveInvoicePaymentMethodRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveInvoicePaymentMethodRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveInvoicePaymentMethodRequest>(create);
  static RemoveInvoicePaymentMethodRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get methodId => $_getSZ(0);
  @$pb.TagNumber(1)
  set methodId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethodId() => clearField(1);
}

class RemoveInvoicePaymentMethodResponse extends $pb.GeneratedMessage {
  factory RemoveInvoicePaymentMethodResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RemoveInvoicePaymentMethodResponse._() : super();
  factory RemoveInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveInvoicePaymentMethodResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodResponse clone() => RemoveInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodResponse copyWith(void Function(RemoveInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as RemoveInvoicePaymentMethodResponse)) as RemoveInvoicePaymentMethodResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveInvoicePaymentMethodResponse create() => RemoveInvoicePaymentMethodResponse._();
  RemoveInvoicePaymentMethodResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveInvoicePaymentMethodResponse> createRepeated() => $pb.PbList<RemoveInvoicePaymentMethodResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveInvoicePaymentMethodResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveInvoicePaymentMethodResponse>(create);
  static RemoveInvoicePaymentMethodResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class ValidateInvoicePaymentMethodRequest extends $pb.GeneratedMessage {
  factory ValidateInvoicePaymentMethodRequest({
    $core.String? methodId,
    $core.double? testAmount,
  }) {
    final $result = create();
    if (methodId != null) {
      $result.methodId = methodId;
    }
    if (testAmount != null) {
      $result.testAmount = testAmount;
    }
    return $result;
  }
  ValidateInvoicePaymentMethodRequest._() : super();
  factory ValidateInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateInvoicePaymentMethodRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'methodId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'testAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodRequest clone() => ValidateInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodRequest copyWith(void Function(ValidateInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentMethodRequest)) as ValidateInvoicePaymentMethodRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentMethodRequest create() => ValidateInvoicePaymentMethodRequest._();
  ValidateInvoicePaymentMethodRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateInvoicePaymentMethodRequest> createRepeated() => $pb.PbList<ValidateInvoicePaymentMethodRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentMethodRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInvoicePaymentMethodRequest>(create);
  static ValidateInvoicePaymentMethodRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get methodId => $_getSZ(0);
  @$pb.TagNumber(1)
  set methodId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethodId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get testAmount => $_getN(1);
  @$pb.TagNumber(2)
  set testAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTestAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTestAmount() => clearField(2);
}

class ValidateInvoicePaymentMethodResponse extends $pb.GeneratedMessage {
  factory ValidateInvoicePaymentMethodResponse({
    $core.bool? isValid,
    $core.String? validationMessage,
    $42.Timestamp? validatedAt,
  }) {
    final $result = create();
    if (isValid != null) {
      $result.isValid = isValid;
    }
    if (validationMessage != null) {
      $result.validationMessage = validationMessage;
    }
    if (validatedAt != null) {
      $result.validatedAt = validatedAt;
    }
    return $result;
  }
  ValidateInvoicePaymentMethodResponse._() : super();
  factory ValidateInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateInvoicePaymentMethodResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'validationMessage')
    ..aOM<$42.Timestamp>(3, _omitFieldNames ? '' : 'validatedAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodResponse clone() => ValidateInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodResponse copyWith(void Function(ValidateInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentMethodResponse)) as ValidateInvoicePaymentMethodResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentMethodResponse create() => ValidateInvoicePaymentMethodResponse._();
  ValidateInvoicePaymentMethodResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateInvoicePaymentMethodResponse> createRepeated() => $pb.PbList<ValidateInvoicePaymentMethodResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateInvoicePaymentMethodResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInvoicePaymentMethodResponse>(create);
  static ValidateInvoicePaymentMethodResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get validationMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set validationMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValidationMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearValidationMessage() => clearField(2);

  @$pb.TagNumber(3)
  $42.Timestamp get validatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set validatedAt($42.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $42.Timestamp ensureValidatedAt() => $_ensure(2);
}

class UpdateInvoicePaymentMethodRequest extends $pb.GeneratedMessage {
  factory UpdateInvoicePaymentMethodRequest({
    $core.String? methodId,
    $core.String? displayName,
    $core.bool? isDefault,
    $core.String? billingAddress,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final $result = create();
    if (methodId != null) {
      $result.methodId = methodId;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (isDefault != null) {
      $result.isDefault = isDefault;
    }
    if (billingAddress != null) {
      $result.billingAddress = billingAddress;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    return $result;
  }
  UpdateInvoicePaymentMethodRequest._() : super();
  factory UpdateInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInvoicePaymentMethodRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'methodId')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOB(3, _omitFieldNames ? '' : 'isDefault')
    ..aOS(4, _omitFieldNames ? '' : 'billingAddress')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata', entryClassName: 'UpdateInvoicePaymentMethodRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodRequest clone() => UpdateInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodRequest copyWith(void Function(UpdateInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as UpdateInvoicePaymentMethodRequest)) as UpdateInvoicePaymentMethodRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInvoicePaymentMethodRequest create() => UpdateInvoicePaymentMethodRequest._();
  UpdateInvoicePaymentMethodRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInvoicePaymentMethodRequest> createRepeated() => $pb.PbList<UpdateInvoicePaymentMethodRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInvoicePaymentMethodRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInvoicePaymentMethodRequest>(create);
  static UpdateInvoicePaymentMethodRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get methodId => $_getSZ(0);
  @$pb.TagNumber(1)
  set methodId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethodId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isDefault => $_getBF(2);
  @$pb.TagNumber(3)
  set isDefault($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsDefault() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsDefault() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get billingAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set billingAddress($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBillingAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearBillingAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);
}

class UpdateInvoicePaymentMethodResponse extends $pb.GeneratedMessage {
  factory UpdateInvoicePaymentMethodResponse({
    PaymentMethod? paymentMethod,
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (paymentMethod != null) {
      $result.paymentMethod = paymentMethod;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateInvoicePaymentMethodResponse._() : super();
  factory UpdateInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInvoicePaymentMethodResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentMethod>(1, _omitFieldNames ? '' : 'paymentMethod', subBuilder: PaymentMethod.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodResponse clone() => UpdateInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodResponse copyWith(void Function(UpdateInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as UpdateInvoicePaymentMethodResponse)) as UpdateInvoicePaymentMethodResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInvoicePaymentMethodResponse create() => UpdateInvoicePaymentMethodResponse._();
  UpdateInvoicePaymentMethodResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInvoicePaymentMethodResponse> createRepeated() => $pb.PbList<UpdateInvoicePaymentMethodResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInvoicePaymentMethodResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInvoicePaymentMethodResponse>(create);
  static UpdateInvoicePaymentMethodResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentMethod get paymentMethod => $_getN(0);
  @$pb.TagNumber(1)
  set paymentMethod(PaymentMethod v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentMethod() => clearField(1);
  @$pb.TagNumber(1)
  PaymentMethod ensurePaymentMethod() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

/// Account Balance Operations
class GetUserAccountBalanceRequest extends $pb.GeneratedMessage {
  factory GetUserAccountBalanceRequest({
    $core.String? currency,
    $1.VirtualAccountType? accountType,
  }) {
    final $result = create();
    if (currency != null) {
      $result.currency = currency;
    }
    if (accountType != null) {
      $result.accountType = accountType;
    }
    return $result;
  }
  GetUserAccountBalanceRequest._() : super();
  factory GetUserAccountBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAccountBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..e<$1.VirtualAccountType>(2, _omitFieldNames ? '' : 'accountType', $pb.PbFieldType.OE, defaultOrMaker: $1.VirtualAccountType.ACCOUNT_TYPE_UNSPECIFIED, valueOf: $1.VirtualAccountType.valueOf, enumValues: $1.VirtualAccountType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceRequest clone() => GetUserAccountBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceRequest copyWith(void Function(GetUserAccountBalanceRequest) updates) => super.copyWith((message) => updates(message as GetUserAccountBalanceRequest)) as GetUserAccountBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAccountBalanceRequest create() => GetUserAccountBalanceRequest._();
  GetUserAccountBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserAccountBalanceRequest> createRepeated() => $pb.PbList<GetUserAccountBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserAccountBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserAccountBalanceRequest>(create);
  static GetUserAccountBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $1.VirtualAccountType get accountType => $_getN(1);
  @$pb.TagNumber(2)
  set accountType($1.VirtualAccountType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => clearField(2);
}

class GetUserAccountBalanceResponse extends $pb.GeneratedMessage {
  factory GetUserAccountBalanceResponse({
    $core.Iterable<UserAccountBalance>? accounts,
    $core.double? totalBalance,
    $core.String? primaryCurrency,
  }) {
    final $result = create();
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (totalBalance != null) {
      $result.totalBalance = totalBalance;
    }
    if (primaryCurrency != null) {
      $result.primaryCurrency = primaryCurrency;
    }
    return $result;
  }
  GetUserAccountBalanceResponse._() : super();
  factory GetUserAccountBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAccountBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<UserAccountBalance>(1, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: UserAccountBalance.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'primaryCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceResponse clone() => GetUserAccountBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceResponse copyWith(void Function(GetUserAccountBalanceResponse) updates) => super.copyWith((message) => updates(message as GetUserAccountBalanceResponse)) as GetUserAccountBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAccountBalanceResponse create() => GetUserAccountBalanceResponse._();
  GetUserAccountBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserAccountBalanceResponse> createRepeated() => $pb.PbList<GetUserAccountBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserAccountBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserAccountBalanceResponse>(create);
  static GetUserAccountBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserAccountBalance> get accounts => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalBalance => $_getN(1);
  @$pb.TagNumber(2)
  set totalBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get primaryCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set primaryCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrimaryCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrimaryCurrency() => clearField(3);
}

class GetAccountBalanceHistoryRequest extends $pb.GeneratedMessage {
  factory GetAccountBalanceHistoryRequest({
    $core.String? accountId,
    $42.Timestamp? startDate,
    $42.Timestamp? endDate,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  GetAccountBalanceHistoryRequest._() : super();
  factory GetAccountBalanceHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountBalanceHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountBalanceHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'startDate', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(3, _omitFieldNames ? '' : 'endDate', subBuilder: $42.Timestamp.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryRequest clone() => GetAccountBalanceHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryRequest copyWith(void Function(GetAccountBalanceHistoryRequest) updates) => super.copyWith((message) => updates(message as GetAccountBalanceHistoryRequest)) as GetAccountBalanceHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceHistoryRequest create() => GetAccountBalanceHistoryRequest._();
  GetAccountBalanceHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountBalanceHistoryRequest> createRepeated() => $pb.PbList<GetAccountBalanceHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountBalanceHistoryRequest>(create);
  static GetAccountBalanceHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $42.Timestamp get startDate => $_getN(1);
  @$pb.TagNumber(2)
  set startDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureStartDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $42.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($42.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);
  @$pb.TagNumber(3)
  $42.Timestamp ensureEndDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get pageToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set pageToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPageToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageToken() => clearField(5);
}

class GetAccountBalanceHistoryResponse extends $pb.GeneratedMessage {
  factory GetAccountBalanceHistoryResponse({
    $core.Iterable<BalanceHistoryEntry>? entries,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  GetAccountBalanceHistoryResponse._() : super();
  factory GetAccountBalanceHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountBalanceHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountBalanceHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BalanceHistoryEntry>(1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: BalanceHistoryEntry.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryResponse clone() => GetAccountBalanceHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryResponse copyWith(void Function(GetAccountBalanceHistoryResponse) updates) => super.copyWith((message) => updates(message as GetAccountBalanceHistoryResponse)) as GetAccountBalanceHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceHistoryResponse create() => GetAccountBalanceHistoryResponse._();
  GetAccountBalanceHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountBalanceHistoryResponse> createRepeated() => $pb.PbList<GetAccountBalanceHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountBalanceHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountBalanceHistoryResponse>(create);
  static GetAccountBalanceHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BalanceHistoryEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

class BalanceHistoryEntry extends $pb.GeneratedMessage {
  factory BalanceHistoryEntry({
    $42.Timestamp? timestamp,
    $core.double? balance,
    $core.double? changeAmount,
    $core.String? transactionType,
    $core.String? description,
    $core.String? reference,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (changeAmount != null) {
      $result.changeAmount = changeAmount;
    }
    if (transactionType != null) {
      $result.transactionType = transactionType;
    }
    if (description != null) {
      $result.description = description;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    return $result;
  }
  BalanceHistoryEntry._() : super();
  factory BalanceHistoryEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BalanceHistoryEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BalanceHistoryEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$42.Timestamp>(1, _omitFieldNames ? '' : 'timestamp', subBuilder: $42.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'changeAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'transactionType')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BalanceHistoryEntry clone() => BalanceHistoryEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BalanceHistoryEntry copyWith(void Function(BalanceHistoryEntry) updates) => super.copyWith((message) => updates(message as BalanceHistoryEntry)) as BalanceHistoryEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BalanceHistoryEntry create() => BalanceHistoryEntry._();
  BalanceHistoryEntry createEmptyInstance() => create();
  static $pb.PbList<BalanceHistoryEntry> createRepeated() => $pb.PbList<BalanceHistoryEntry>();
  @$core.pragma('dart2js:noInline')
  static BalanceHistoryEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceHistoryEntry>(create);
  static BalanceHistoryEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $42.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($42.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $42.Timestamp ensureTimestamp() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get balance => $_getN(1);
  @$pb.TagNumber(2)
  set balance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get changeAmount => $_getN(2);
  @$pb.TagNumber(3)
  set changeAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChangeAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearChangeAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionType => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);
}

class TransferFundsForInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory TransferFundsForInvoicePaymentRequest({
    $core.String? fromAccountId,
    $core.String? toAccountId,
    $core.double? amount,
    $core.String? currency,
    $core.String? invoiceId,
    $core.String? description,
  }) {
    final $result = create();
    if (fromAccountId != null) {
      $result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      $result.toAccountId = toAccountId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  TransferFundsForInvoicePaymentRequest._() : super();
  factory TransferFundsForInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferFundsForInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferFundsForInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromAccountId')
    ..aOS(2, _omitFieldNames ? '' : 'toAccountId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentRequest clone() => TransferFundsForInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentRequest copyWith(void Function(TransferFundsForInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as TransferFundsForInvoicePaymentRequest)) as TransferFundsForInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferFundsForInvoicePaymentRequest create() => TransferFundsForInvoicePaymentRequest._();
  TransferFundsForInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<TransferFundsForInvoicePaymentRequest> createRepeated() => $pb.PbList<TransferFundsForInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferFundsForInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferFundsForInvoicePaymentRequest>(create);
  static TransferFundsForInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set toAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get invoiceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set invoiceId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInvoiceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearInvoiceId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);
}

class TransferFundsForInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory TransferFundsForInvoicePaymentResponse({
    $core.bool? success,
    $core.String? transactionId,
    $core.String? message,
    $core.double? newBalance,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (message != null) {
      $result.message = message;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    return $result;
  }
  TransferFundsForInvoicePaymentResponse._() : super();
  factory TransferFundsForInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferFundsForInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferFundsForInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentResponse clone() => TransferFundsForInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentResponse copyWith(void Function(TransferFundsForInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as TransferFundsForInvoicePaymentResponse)) as TransferFundsForInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferFundsForInvoicePaymentResponse create() => TransferFundsForInvoicePaymentResponse._();
  TransferFundsForInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<TransferFundsForInvoicePaymentResponse> createRepeated() => $pb.PbList<TransferFundsForInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferFundsForInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferFundsForInvoicePaymentResponse>(create);
  static TransferFundsForInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);
}

/// Cryptocurrency Operations
class ProcessCryptoInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory ProcessCryptoInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? walletAddress,
    $core.String? currency,
    $core.double? amount,
    $core.String? transactionHash,
    $core.String? network,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (walletAddress != null) {
      $result.walletAddress = walletAddress;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (transactionHash != null) {
      $result.transactionHash = transactionHash;
    }
    if (network != null) {
      $result.network = network;
    }
    return $result;
  }
  ProcessCryptoInvoicePaymentRequest._() : super();
  factory ProcessCryptoInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessCryptoInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessCryptoInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'walletAddress')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'transactionHash')
    ..aOS(6, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentRequest clone() => ProcessCryptoInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentRequest copyWith(void Function(ProcessCryptoInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessCryptoInvoicePaymentRequest)) as ProcessCryptoInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessCryptoInvoicePaymentRequest create() => ProcessCryptoInvoicePaymentRequest._();
  ProcessCryptoInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessCryptoInvoicePaymentRequest> createRepeated() => $pb.PbList<ProcessCryptoInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessCryptoInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessCryptoInvoicePaymentRequest>(create);
  static ProcessCryptoInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get walletAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletAddress($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWalletAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionHash() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get network => $_getSZ(5);
  @$pb.TagNumber(6)
  set network($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNetwork() => $_has(5);
  @$pb.TagNumber(6)
  void clearNetwork() => clearField(6);
}

class ProcessCryptoInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory ProcessCryptoInvoicePaymentResponse({
    $core.bool? success,
    $core.String? transactionId,
    $core.String? confirmationStatus,
    $core.int? confirmationsRequired,
    $core.int? currentConfirmations,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (confirmationStatus != null) {
      $result.confirmationStatus = confirmationStatus;
    }
    if (confirmationsRequired != null) {
      $result.confirmationsRequired = confirmationsRequired;
    }
    if (currentConfirmations != null) {
      $result.currentConfirmations = currentConfirmations;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ProcessCryptoInvoicePaymentResponse._() : super();
  factory ProcessCryptoInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessCryptoInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessCryptoInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'confirmationStatus')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'confirmationsRequired', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'currentConfirmations', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentResponse clone() => ProcessCryptoInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentResponse copyWith(void Function(ProcessCryptoInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessCryptoInvoicePaymentResponse)) as ProcessCryptoInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessCryptoInvoicePaymentResponse create() => ProcessCryptoInvoicePaymentResponse._();
  ProcessCryptoInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessCryptoInvoicePaymentResponse> createRepeated() => $pb.PbList<ProcessCryptoInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessCryptoInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessCryptoInvoicePaymentResponse>(create);
  static ProcessCryptoInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get confirmationStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set confirmationStatus($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfirmationStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfirmationStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get confirmationsRequired => $_getIZ(3);
  @$pb.TagNumber(4)
  set confirmationsRequired($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfirmationsRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfirmationsRequired() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get currentConfirmations => $_getIZ(4);
  @$pb.TagNumber(5)
  set currentConfirmations($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentConfirmations() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentConfirmations() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

class GetInvoiceCryptoWalletBalanceRequest extends $pb.GeneratedMessage {
  factory GetInvoiceCryptoWalletBalanceRequest({
    $core.String? walletAddress,
    $core.String? currency,
    $core.String? network,
  }) {
    final $result = create();
    if (walletAddress != null) {
      $result.walletAddress = walletAddress;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (network != null) {
      $result.network = network;
    }
    return $result;
  }
  GetInvoiceCryptoWalletBalanceRequest._() : super();
  factory GetInvoiceCryptoWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceCryptoWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceCryptoWalletBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletAddress')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceCryptoWalletBalanceRequest clone() => GetInvoiceCryptoWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceCryptoWalletBalanceRequest copyWith(void Function(GetInvoiceCryptoWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetInvoiceCryptoWalletBalanceRequest)) as GetInvoiceCryptoWalletBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceCryptoWalletBalanceRequest create() => GetInvoiceCryptoWalletBalanceRequest._();
  GetInvoiceCryptoWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceCryptoWalletBalanceRequest> createRepeated() => $pb.PbList<GetInvoiceCryptoWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceCryptoWalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceCryptoWalletBalanceRequest>(create);
  static GetInvoiceCryptoWalletBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletAddress($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get network => $_getSZ(2);
  @$pb.TagNumber(3)
  set network($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearNetwork() => clearField(3);
}

class GetInvoiceCryptoWalletBalanceResponse extends $pb.GeneratedMessage {
  factory GetInvoiceCryptoWalletBalanceResponse({
    $core.double? balance,
    $core.String? currency,
    $42.Timestamp? lastUpdated,
    $core.String? network,
  }) {
    final $result = create();
    if (balance != null) {
      $result.balance = balance;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    if (network != null) {
      $result.network = network;
    }
    return $result;
  }
  GetInvoiceCryptoWalletBalanceResponse._() : super();
  factory GetInvoiceCryptoWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceCryptoWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceCryptoWalletBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOM<$42.Timestamp>(3, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $42.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceCryptoWalletBalanceResponse clone() => GetInvoiceCryptoWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceCryptoWalletBalanceResponse copyWith(void Function(GetInvoiceCryptoWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetInvoiceCryptoWalletBalanceResponse)) as GetInvoiceCryptoWalletBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceCryptoWalletBalanceResponse create() => GetInvoiceCryptoWalletBalanceResponse._();
  GetInvoiceCryptoWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceCryptoWalletBalanceResponse> createRepeated() => $pb.PbList<GetInvoiceCryptoWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceCryptoWalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceCryptoWalletBalanceResponse>(create);
  static GetInvoiceCryptoWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $42.Timestamp get lastUpdated => $_getN(2);
  @$pb.TagNumber(3)
  set lastUpdated($42.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastUpdated() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastUpdated() => clearField(3);
  @$pb.TagNumber(3)
  $42.Timestamp ensureLastUpdated() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get network => $_getSZ(3);
  @$pb.TagNumber(4)
  set network($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNetwork() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetwork() => clearField(4);
}

class ValidateInvoiceCryptoWalletRequest extends $pb.GeneratedMessage {
  factory ValidateInvoiceCryptoWalletRequest({
    $core.String? walletAddress,
    $core.String? currency,
    $core.String? network,
  }) {
    final $result = create();
    if (walletAddress != null) {
      $result.walletAddress = walletAddress;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (network != null) {
      $result.network = network;
    }
    return $result;
  }
  ValidateInvoiceCryptoWalletRequest._() : super();
  factory ValidateInvoiceCryptoWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoiceCryptoWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateInvoiceCryptoWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletAddress')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoiceCryptoWalletRequest clone() => ValidateInvoiceCryptoWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoiceCryptoWalletRequest copyWith(void Function(ValidateInvoiceCryptoWalletRequest) updates) => super.copyWith((message) => updates(message as ValidateInvoiceCryptoWalletRequest)) as ValidateInvoiceCryptoWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInvoiceCryptoWalletRequest create() => ValidateInvoiceCryptoWalletRequest._();
  ValidateInvoiceCryptoWalletRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateInvoiceCryptoWalletRequest> createRepeated() => $pb.PbList<ValidateInvoiceCryptoWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateInvoiceCryptoWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInvoiceCryptoWalletRequest>(create);
  static ValidateInvoiceCryptoWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletAddress($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get network => $_getSZ(2);
  @$pb.TagNumber(3)
  set network($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearNetwork() => clearField(3);
}

class ValidateInvoiceCryptoWalletResponse extends $pb.GeneratedMessage {
  factory ValidateInvoiceCryptoWalletResponse({
    $core.bool? isValid,
    $core.String? validationMessage,
    $core.bool? isContract,
    $core.String? walletType,
  }) {
    final $result = create();
    if (isValid != null) {
      $result.isValid = isValid;
    }
    if (validationMessage != null) {
      $result.validationMessage = validationMessage;
    }
    if (isContract != null) {
      $result.isContract = isContract;
    }
    if (walletType != null) {
      $result.walletType = walletType;
    }
    return $result;
  }
  ValidateInvoiceCryptoWalletResponse._() : super();
  factory ValidateInvoiceCryptoWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoiceCryptoWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateInvoiceCryptoWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'validationMessage')
    ..aOB(3, _omitFieldNames ? '' : 'isContract')
    ..aOS(4, _omitFieldNames ? '' : 'walletType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoiceCryptoWalletResponse clone() => ValidateInvoiceCryptoWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoiceCryptoWalletResponse copyWith(void Function(ValidateInvoiceCryptoWalletResponse) updates) => super.copyWith((message) => updates(message as ValidateInvoiceCryptoWalletResponse)) as ValidateInvoiceCryptoWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInvoiceCryptoWalletResponse create() => ValidateInvoiceCryptoWalletResponse._();
  ValidateInvoiceCryptoWalletResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateInvoiceCryptoWalletResponse> createRepeated() => $pb.PbList<ValidateInvoiceCryptoWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateInvoiceCryptoWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInvoiceCryptoWalletResponse>(create);
  static ValidateInvoiceCryptoWalletResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get validationMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set validationMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValidationMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearValidationMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isContract => $_getBF(2);
  @$pb.TagNumber(3)
  set isContract($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsContract() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsContract() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get walletType => $_getSZ(3);
  @$pb.TagNumber(4)
  set walletType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWalletType() => $_has(3);
  @$pb.TagNumber(4)
  void clearWalletType() => clearField(4);
}

class GetCryptoInvoicePaymentStatusRequest extends $pb.GeneratedMessage {
  factory GetCryptoInvoicePaymentStatusRequest({
    $core.String? transactionHash,
    $core.String? network,
  }) {
    final $result = create();
    if (transactionHash != null) {
      $result.transactionHash = transactionHash;
    }
    if (network != null) {
      $result.network = network;
    }
    return $result;
  }
  GetCryptoInvoicePaymentStatusRequest._() : super();
  factory GetCryptoInvoicePaymentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoInvoicePaymentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoInvoicePaymentStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionHash')
    ..aOS(2, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusRequest clone() => GetCryptoInvoicePaymentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusRequest copyWith(void Function(GetCryptoInvoicePaymentStatusRequest) updates) => super.copyWith((message) => updates(message as GetCryptoInvoicePaymentStatusRequest)) as GetCryptoInvoicePaymentStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoInvoicePaymentStatusRequest create() => GetCryptoInvoicePaymentStatusRequest._();
  GetCryptoInvoicePaymentStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoInvoicePaymentStatusRequest> createRepeated() => $pb.PbList<GetCryptoInvoicePaymentStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoInvoicePaymentStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoInvoicePaymentStatusRequest>(create);
  static GetCryptoInvoicePaymentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get network => $_getSZ(1);
  @$pb.TagNumber(2)
  set network($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNetwork() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetwork() => clearField(2);
}

class GetCryptoInvoicePaymentStatusResponse extends $pb.GeneratedMessage {
  factory GetCryptoInvoicePaymentStatusResponse({
    $core.String? status,
    $core.int? confirmations,
    $core.int? requiredConfirmations,
    $core.double? amount,
    $core.String? currency,
    $42.Timestamp? timestamp,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (confirmations != null) {
      $result.confirmations = confirmations;
    }
    if (requiredConfirmations != null) {
      $result.requiredConfirmations = requiredConfirmations;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  GetCryptoInvoicePaymentStatusResponse._() : super();
  factory GetCryptoInvoicePaymentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoInvoicePaymentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoInvoicePaymentStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'confirmations', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'requiredConfirmations', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOM<$42.Timestamp>(6, _omitFieldNames ? '' : 'timestamp', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusResponse clone() => GetCryptoInvoicePaymentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusResponse copyWith(void Function(GetCryptoInvoicePaymentStatusResponse) updates) => super.copyWith((message) => updates(message as GetCryptoInvoicePaymentStatusResponse)) as GetCryptoInvoicePaymentStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoInvoicePaymentStatusResponse create() => GetCryptoInvoicePaymentStatusResponse._();
  GetCryptoInvoicePaymentStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoInvoicePaymentStatusResponse> createRepeated() => $pb.PbList<GetCryptoInvoicePaymentStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoInvoicePaymentStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoInvoicePaymentStatusResponse>(create);
  static GetCryptoInvoicePaymentStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get confirmations => $_getIZ(1);
  @$pb.TagNumber(2)
  set confirmations($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConfirmations() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfirmations() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get requiredConfirmations => $_getIZ(2);
  @$pb.TagNumber(3)
  set requiredConfirmations($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequiredConfirmations() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequiredConfirmations() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $42.Timestamp get timestamp => $_getN(5);
  @$pb.TagNumber(6)
  set timestamp($42.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => clearField(6);
  @$pb.TagNumber(6)
  $42.Timestamp ensureTimestamp() => $_ensure(5);
}

/// Payment Extensions and Disputes
class RequestInvoicePaymentExtensionRequest extends $pb.GeneratedMessage {
  factory RequestInvoicePaymentExtensionRequest({
    $core.String? invoiceId,
    $42.Timestamp? newDueDate,
    $core.String? reason,
    $core.String? justification,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (newDueDate != null) {
      $result.newDueDate = newDueDate;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (justification != null) {
      $result.justification = justification;
    }
    return $result;
  }
  RequestInvoicePaymentExtensionRequest._() : super();
  factory RequestInvoicePaymentExtensionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInvoicePaymentExtensionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestInvoicePaymentExtensionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'newDueDate', subBuilder: $42.Timestamp.create)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'justification')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionRequest clone() => RequestInvoicePaymentExtensionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionRequest copyWith(void Function(RequestInvoicePaymentExtensionRequest) updates) => super.copyWith((message) => updates(message as RequestInvoicePaymentExtensionRequest)) as RequestInvoicePaymentExtensionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInvoicePaymentExtensionRequest create() => RequestInvoicePaymentExtensionRequest._();
  RequestInvoicePaymentExtensionRequest createEmptyInstance() => create();
  static $pb.PbList<RequestInvoicePaymentExtensionRequest> createRepeated() => $pb.PbList<RequestInvoicePaymentExtensionRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestInvoicePaymentExtensionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInvoicePaymentExtensionRequest>(create);
  static RequestInvoicePaymentExtensionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $42.Timestamp get newDueDate => $_getN(1);
  @$pb.TagNumber(2)
  set newDueDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewDueDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewDueDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureNewDueDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get justification => $_getSZ(3);
  @$pb.TagNumber(4)
  set justification($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasJustification() => $_has(3);
  @$pb.TagNumber(4)
  void clearJustification() => clearField(4);
}

class RequestInvoicePaymentExtensionResponse extends $pb.GeneratedMessage {
  factory RequestInvoicePaymentExtensionResponse({
    PaymentExtensionRequest? extensionRequest,
    $core.bool? success,
    $core.String? message,
    $core.String? requestId,
  }) {
    final $result = create();
    if (extensionRequest != null) {
      $result.extensionRequest = extensionRequest;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (requestId != null) {
      $result.requestId = requestId;
    }
    return $result;
  }
  RequestInvoicePaymentExtensionResponse._() : super();
  factory RequestInvoicePaymentExtensionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInvoicePaymentExtensionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestInvoicePaymentExtensionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentExtensionRequest>(1, _omitFieldNames ? '' : 'extensionRequest', subBuilder: PaymentExtensionRequest.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'requestId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionResponse clone() => RequestInvoicePaymentExtensionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionResponse copyWith(void Function(RequestInvoicePaymentExtensionResponse) updates) => super.copyWith((message) => updates(message as RequestInvoicePaymentExtensionResponse)) as RequestInvoicePaymentExtensionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInvoicePaymentExtensionResponse create() => RequestInvoicePaymentExtensionResponse._();
  RequestInvoicePaymentExtensionResponse createEmptyInstance() => create();
  static $pb.PbList<RequestInvoicePaymentExtensionResponse> createRepeated() => $pb.PbList<RequestInvoicePaymentExtensionResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestInvoicePaymentExtensionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInvoicePaymentExtensionResponse>(create);
  static RequestInvoicePaymentExtensionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentExtensionRequest get extensionRequest => $_getN(0);
  @$pb.TagNumber(1)
  set extensionRequest(PaymentExtensionRequest v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExtensionRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearExtensionRequest() => clearField(1);
  @$pb.TagNumber(1)
  PaymentExtensionRequest ensureExtensionRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get requestId => $_getSZ(3);
  @$pb.TagNumber(4)
  set requestId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequestId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequestId() => clearField(4);
}

class ApproveInvoicePaymentExtensionRequest extends $pb.GeneratedMessage {
  factory ApproveInvoicePaymentExtensionRequest({
    $core.String? requestId,
    $core.bool? approved,
    $core.String? approvalReason,
    $42.Timestamp? approvedDate,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (approved != null) {
      $result.approved = approved;
    }
    if (approvalReason != null) {
      $result.approvalReason = approvalReason;
    }
    if (approvedDate != null) {
      $result.approvedDate = approvedDate;
    }
    return $result;
  }
  ApproveInvoicePaymentExtensionRequest._() : super();
  factory ApproveInvoicePaymentExtensionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApproveInvoicePaymentExtensionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ApproveInvoicePaymentExtensionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..aOB(2, _omitFieldNames ? '' : 'approved')
    ..aOS(3, _omitFieldNames ? '' : 'approvalReason')
    ..aOM<$42.Timestamp>(4, _omitFieldNames ? '' : 'approvedDate', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionRequest clone() => ApproveInvoicePaymentExtensionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionRequest copyWith(void Function(ApproveInvoicePaymentExtensionRequest) updates) => super.copyWith((message) => updates(message as ApproveInvoicePaymentExtensionRequest)) as ApproveInvoicePaymentExtensionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApproveInvoicePaymentExtensionRequest create() => ApproveInvoicePaymentExtensionRequest._();
  ApproveInvoicePaymentExtensionRequest createEmptyInstance() => create();
  static $pb.PbList<ApproveInvoicePaymentExtensionRequest> createRepeated() => $pb.PbList<ApproveInvoicePaymentExtensionRequest>();
  @$core.pragma('dart2js:noInline')
  static ApproveInvoicePaymentExtensionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApproveInvoicePaymentExtensionRequest>(create);
  static ApproveInvoicePaymentExtensionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get approved => $_getBF(1);
  @$pb.TagNumber(2)
  set approved($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasApproved() => $_has(1);
  @$pb.TagNumber(2)
  void clearApproved() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get approvalReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set approvalReason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasApprovalReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearApprovalReason() => clearField(3);

  @$pb.TagNumber(4)
  $42.Timestamp get approvedDate => $_getN(3);
  @$pb.TagNumber(4)
  set approvedDate($42.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasApprovedDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearApprovedDate() => clearField(4);
  @$pb.TagNumber(4)
  $42.Timestamp ensureApprovedDate() => $_ensure(3);
}

class ApproveInvoicePaymentExtensionResponse extends $pb.GeneratedMessage {
  factory ApproveInvoicePaymentExtensionResponse({
    $core.bool? success,
    $core.String? message,
    PaymentExtensionRequest? updatedRequest,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (updatedRequest != null) {
      $result.updatedRequest = updatedRequest;
    }
    return $result;
  }
  ApproveInvoicePaymentExtensionResponse._() : super();
  factory ApproveInvoicePaymentExtensionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApproveInvoicePaymentExtensionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ApproveInvoicePaymentExtensionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PaymentExtensionRequest>(3, _omitFieldNames ? '' : 'updatedRequest', subBuilder: PaymentExtensionRequest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionResponse clone() => ApproveInvoicePaymentExtensionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionResponse copyWith(void Function(ApproveInvoicePaymentExtensionResponse) updates) => super.copyWith((message) => updates(message as ApproveInvoicePaymentExtensionResponse)) as ApproveInvoicePaymentExtensionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApproveInvoicePaymentExtensionResponse create() => ApproveInvoicePaymentExtensionResponse._();
  ApproveInvoicePaymentExtensionResponse createEmptyInstance() => create();
  static $pb.PbList<ApproveInvoicePaymentExtensionResponse> createRepeated() => $pb.PbList<ApproveInvoicePaymentExtensionResponse>();
  @$core.pragma('dart2js:noInline')
  static ApproveInvoicePaymentExtensionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApproveInvoicePaymentExtensionResponse>(create);
  static ApproveInvoicePaymentExtensionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PaymentExtensionRequest get updatedRequest => $_getN(2);
  @$pb.TagNumber(3)
  set updatedRequest(PaymentExtensionRequest v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedRequest() => clearField(3);
  @$pb.TagNumber(3)
  PaymentExtensionRequest ensureUpdatedRequest() => $_ensure(2);
}

class DisputeInvoicePaymentRequest extends $pb.GeneratedMessage {
  factory DisputeInvoicePaymentRequest({
    $core.String? transactionId,
    $core.String? reason,
    $core.String? description,
    $core.Iterable<$core.String>? evidenceFiles,
    $core.double? disputedAmount,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (description != null) {
      $result.description = description;
    }
    if (evidenceFiles != null) {
      $result.evidenceFiles.addAll(evidenceFiles);
    }
    if (disputedAmount != null) {
      $result.disputedAmount = disputedAmount;
    }
    return $result;
  }
  DisputeInvoicePaymentRequest._() : super();
  factory DisputeInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisputeInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisputeInvoicePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPS(4, _omitFieldNames ? '' : 'evidenceFiles')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'disputedAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentRequest clone() => DisputeInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentRequest copyWith(void Function(DisputeInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as DisputeInvoicePaymentRequest)) as DisputeInvoicePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisputeInvoicePaymentRequest create() => DisputeInvoicePaymentRequest._();
  DisputeInvoicePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<DisputeInvoicePaymentRequest> createRepeated() => $pb.PbList<DisputeInvoicePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static DisputeInvoicePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisputeInvoicePaymentRequest>(create);
  static DisputeInvoicePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get evidenceFiles => $_getList(3);

  @$pb.TagNumber(5)
  $core.double get disputedAmount => $_getN(4);
  @$pb.TagNumber(5)
  set disputedAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDisputedAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisputedAmount() => clearField(5);
}

class DisputeInvoicePaymentResponse extends $pb.GeneratedMessage {
  factory DisputeInvoicePaymentResponse({
    PaymentDispute? dispute,
    $core.bool? success,
    $core.String? message,
    $core.String? disputeId,
  }) {
    final $result = create();
    if (dispute != null) {
      $result.dispute = dispute;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (disputeId != null) {
      $result.disputeId = disputeId;
    }
    return $result;
  }
  DisputeInvoicePaymentResponse._() : super();
  factory DisputeInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisputeInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisputeInvoicePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentDispute>(1, _omitFieldNames ? '' : 'dispute', subBuilder: PaymentDispute.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'disputeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentResponse clone() => DisputeInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentResponse copyWith(void Function(DisputeInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as DisputeInvoicePaymentResponse)) as DisputeInvoicePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisputeInvoicePaymentResponse create() => DisputeInvoicePaymentResponse._();
  DisputeInvoicePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<DisputeInvoicePaymentResponse> createRepeated() => $pb.PbList<DisputeInvoicePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static DisputeInvoicePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisputeInvoicePaymentResponse>(create);
  static DisputeInvoicePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentDispute get dispute => $_getN(0);
  @$pb.TagNumber(1)
  set dispute(PaymentDispute v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDispute() => $_has(0);
  @$pb.TagNumber(1)
  void clearDispute() => clearField(1);
  @$pb.TagNumber(1)
  PaymentDispute ensureDispute() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get disputeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set disputeId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisputeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisputeId() => clearField(4);
}

class ResolveInvoicePaymentDisputeRequest extends $pb.GeneratedMessage {
  factory ResolveInvoicePaymentDisputeRequest({
    $core.String? disputeId,
    $core.String? resolution,
    $core.double? refundAmount,
    $core.String? resolutionNotes,
  }) {
    final $result = create();
    if (disputeId != null) {
      $result.disputeId = disputeId;
    }
    if (resolution != null) {
      $result.resolution = resolution;
    }
    if (refundAmount != null) {
      $result.refundAmount = refundAmount;
    }
    if (resolutionNotes != null) {
      $result.resolutionNotes = resolutionNotes;
    }
    return $result;
  }
  ResolveInvoicePaymentDisputeRequest._() : super();
  factory ResolveInvoicePaymentDisputeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveInvoicePaymentDisputeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolveInvoicePaymentDisputeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'disputeId')
    ..aOS(2, _omitFieldNames ? '' : 'resolution')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'refundAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'resolutionNotes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeRequest clone() => ResolveInvoicePaymentDisputeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeRequest copyWith(void Function(ResolveInvoicePaymentDisputeRequest) updates) => super.copyWith((message) => updates(message as ResolveInvoicePaymentDisputeRequest)) as ResolveInvoicePaymentDisputeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveInvoicePaymentDisputeRequest create() => ResolveInvoicePaymentDisputeRequest._();
  ResolveInvoicePaymentDisputeRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveInvoicePaymentDisputeRequest> createRepeated() => $pb.PbList<ResolveInvoicePaymentDisputeRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveInvoicePaymentDisputeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveInvoicePaymentDisputeRequest>(create);
  static ResolveInvoicePaymentDisputeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get disputeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set disputeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisputeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisputeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolution => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolution($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResolution() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolution() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get refundAmount => $_getN(2);
  @$pb.TagNumber(3)
  set refundAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefundAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefundAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get resolutionNotes => $_getSZ(3);
  @$pb.TagNumber(4)
  set resolutionNotes($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResolutionNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearResolutionNotes() => clearField(4);
}

class ResolveInvoicePaymentDisputeResponse extends $pb.GeneratedMessage {
  factory ResolveInvoicePaymentDisputeResponse({
    $core.bool? success,
    $core.String? message,
    PaymentDispute? updatedDispute,
    $core.String? refundTransactionId,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (updatedDispute != null) {
      $result.updatedDispute = updatedDispute;
    }
    if (refundTransactionId != null) {
      $result.refundTransactionId = refundTransactionId;
    }
    return $result;
  }
  ResolveInvoicePaymentDisputeResponse._() : super();
  factory ResolveInvoicePaymentDisputeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveInvoicePaymentDisputeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolveInvoicePaymentDisputeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PaymentDispute>(3, _omitFieldNames ? '' : 'updatedDispute', subBuilder: PaymentDispute.create)
    ..aOS(4, _omitFieldNames ? '' : 'refundTransactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeResponse clone() => ResolveInvoicePaymentDisputeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeResponse copyWith(void Function(ResolveInvoicePaymentDisputeResponse) updates) => super.copyWith((message) => updates(message as ResolveInvoicePaymentDisputeResponse)) as ResolveInvoicePaymentDisputeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveInvoicePaymentDisputeResponse create() => ResolveInvoicePaymentDisputeResponse._();
  ResolveInvoicePaymentDisputeResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveInvoicePaymentDisputeResponse> createRepeated() => $pb.PbList<ResolveInvoicePaymentDisputeResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveInvoicePaymentDisputeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveInvoicePaymentDisputeResponse>(create);
  static ResolveInvoicePaymentDisputeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PaymentDispute get updatedDispute => $_getN(2);
  @$pb.TagNumber(3)
  set updatedDispute(PaymentDispute v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedDispute() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedDispute() => clearField(3);
  @$pb.TagNumber(3)
  PaymentDispute ensureUpdatedDispute() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get refundTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set refundTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRefundTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefundTransactionId() => clearField(4);
}

/// Payment History and Analytics
class GetInvoicePaymentHistoryRequest extends $pb.GeneratedMessage {
  factory GetInvoicePaymentHistoryRequest({
    $42.Timestamp? startDate,
    $42.Timestamp? endDate,
    $core.int? pageSize,
    $core.String? pageToken,
    $43.InvoicePaymentStatus? statusFilter,
  }) {
    final $result = create();
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (statusFilter != null) {
      $result.statusFilter = statusFilter;
    }
    return $result;
  }
  GetInvoicePaymentHistoryRequest._() : super();
  factory GetInvoicePaymentHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$42.Timestamp>(1, _omitFieldNames ? '' : 'startDate', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'endDate', subBuilder: $42.Timestamp.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..e<$43.InvoicePaymentStatus>(5, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryRequest clone() => GetInvoicePaymentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryRequest copyWith(void Function(GetInvoicePaymentHistoryRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentHistoryRequest)) as GetInvoicePaymentHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentHistoryRequest create() => GetInvoicePaymentHistoryRequest._();
  GetInvoicePaymentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentHistoryRequest> createRepeated() => $pb.PbList<GetInvoicePaymentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentHistoryRequest>(create);
  static GetInvoicePaymentHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $42.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($42.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $42.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $42.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => clearField(4);

  @$pb.TagNumber(5)
  $43.InvoicePaymentStatus get statusFilter => $_getN(4);
  @$pb.TagNumber(5)
  set statusFilter($43.InvoicePaymentStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatusFilter() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatusFilter() => clearField(5);
}

class GetInvoicePaymentHistoryResponse extends $pb.GeneratedMessage {
  factory GetInvoicePaymentHistoryResponse({
    $core.Iterable<InvoicePaymentTransaction>? transactions,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetInvoicePaymentHistoryResponse._() : super();
  factory GetInvoicePaymentHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvoicePaymentTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: InvoicePaymentTransaction.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryResponse clone() => GetInvoicePaymentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryResponse copyWith(void Function(GetInvoicePaymentHistoryResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentHistoryResponse)) as GetInvoicePaymentHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentHistoryResponse create() => GetInvoicePaymentHistoryResponse._();
  GetInvoicePaymentHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentHistoryResponse> createRepeated() => $pb.PbList<GetInvoicePaymentHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentHistoryResponse>(create);
  static GetInvoicePaymentHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InvoicePaymentTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class GetInvoicePaymentStatisticsRequest extends $pb.GeneratedMessage {
  factory GetInvoicePaymentStatisticsRequest({
    $42.Timestamp? startDate,
    $42.Timestamp? endDate,
  }) {
    final $result = create();
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    return $result;
  }
  GetInvoicePaymentStatisticsRequest._() : super();
  factory GetInvoicePaymentStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$42.Timestamp>(1, _omitFieldNames ? '' : 'startDate', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'endDate', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsRequest clone() => GetInvoicePaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsRequest copyWith(void Function(GetInvoicePaymentStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatisticsRequest)) as GetInvoicePaymentStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatisticsRequest create() => GetInvoicePaymentStatisticsRequest._();
  GetInvoicePaymentStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentStatisticsRequest> createRepeated() => $pb.PbList<GetInvoicePaymentStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentStatisticsRequest>(create);
  static GetInvoicePaymentStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $42.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($42.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $42.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $42.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureEndDate() => $_ensure(1);
}

class GetInvoicePaymentStatisticsResponse extends $pb.GeneratedMessage {
  factory GetInvoicePaymentStatisticsResponse({
    $fixnum.Int64? totalPayments,
    $fixnum.Int64? successfulPayments,
    $fixnum.Int64? failedPayments,
    $core.double? totalAmount,
    $core.double? totalFees,
    $core.double? averagePaymentAmount,
    $core.Map<$core.String, $fixnum.Int64>? paymentMethodUsage,
    $core.double? successRate,
  }) {
    final $result = create();
    if (totalPayments != null) {
      $result.totalPayments = totalPayments;
    }
    if (successfulPayments != null) {
      $result.successfulPayments = successfulPayments;
    }
    if (failedPayments != null) {
      $result.failedPayments = failedPayments;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (totalFees != null) {
      $result.totalFees = totalFees;
    }
    if (averagePaymentAmount != null) {
      $result.averagePaymentAmount = averagePaymentAmount;
    }
    if (paymentMethodUsage != null) {
      $result.paymentMethodUsage.addAll(paymentMethodUsage);
    }
    if (successRate != null) {
      $result.successRate = successRate;
    }
    return $result;
  }
  GetInvoicePaymentStatisticsResponse._() : super();
  factory GetInvoicePaymentStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'successfulPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'failedPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalFees', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'averagePaymentAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $fixnum.Int64>(7, _omitFieldNames ? '' : 'paymentMethodUsage', entryClassName: 'GetInvoicePaymentStatisticsResponse.PaymentMethodUsageEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OU6, packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(8, _omitFieldNames ? '' : 'successRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsResponse clone() => GetInvoicePaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsResponse copyWith(void Function(GetInvoicePaymentStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatisticsResponse)) as GetInvoicePaymentStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatisticsResponse create() => GetInvoicePaymentStatisticsResponse._();
  GetInvoicePaymentStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentStatisticsResponse> createRepeated() => $pb.PbList<GetInvoicePaymentStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentStatisticsResponse>(create);
  static GetInvoicePaymentStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalPayments => $_getI64(0);
  @$pb.TagNumber(1)
  set totalPayments($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get successfulPayments => $_getI64(1);
  @$pb.TagNumber(2)
  set successfulPayments($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessfulPayments() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessfulPayments() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get failedPayments => $_getI64(2);
  @$pb.TagNumber(3)
  set failedPayments($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFailedPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearFailedPayments() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalFees => $_getN(4);
  @$pb.TagNumber(5)
  set totalFees($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalFees() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalFees() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get averagePaymentAmount => $_getN(5);
  @$pb.TagNumber(6)
  set averagePaymentAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAveragePaymentAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAveragePaymentAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $fixnum.Int64> get paymentMethodUsage => $_getMap(6);

  @$pb.TagNumber(8)
  $core.double get successRate => $_getN(7);
  @$pb.TagNumber(8)
  set successRate($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSuccessRate() => $_has(7);
  @$pb.TagNumber(8)
  void clearSuccessRate() => clearField(8);
}

class GetRecentInvoicePaymentTransactionsRequest extends $pb.GeneratedMessage {
  factory GetRecentInvoicePaymentTransactionsRequest({
    $core.int? limit,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetRecentInvoicePaymentTransactionsRequest._() : super();
  factory GetRecentInvoicePaymentTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentInvoicePaymentTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecentInvoicePaymentTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsRequest clone() => GetRecentInvoicePaymentTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsRequest copyWith(void Function(GetRecentInvoicePaymentTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetRecentInvoicePaymentTransactionsRequest)) as GetRecentInvoicePaymentTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentInvoicePaymentTransactionsRequest create() => GetRecentInvoicePaymentTransactionsRequest._();
  GetRecentInvoicePaymentTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecentInvoicePaymentTransactionsRequest> createRepeated() => $pb.PbList<GetRecentInvoicePaymentTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecentInvoicePaymentTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentInvoicePaymentTransactionsRequest>(create);
  static GetRecentInvoicePaymentTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);
}

class GetRecentInvoicePaymentTransactionsResponse extends $pb.GeneratedMessage {
  factory GetRecentInvoicePaymentTransactionsResponse({
    $core.Iterable<InvoicePaymentTransaction>? transactions,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    return $result;
  }
  GetRecentInvoicePaymentTransactionsResponse._() : super();
  factory GetRecentInvoicePaymentTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentInvoicePaymentTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecentInvoicePaymentTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvoicePaymentTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: InvoicePaymentTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsResponse clone() => GetRecentInvoicePaymentTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsResponse copyWith(void Function(GetRecentInvoicePaymentTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetRecentInvoicePaymentTransactionsResponse)) as GetRecentInvoicePaymentTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentInvoicePaymentTransactionsResponse create() => GetRecentInvoicePaymentTransactionsResponse._();
  GetRecentInvoicePaymentTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecentInvoicePaymentTransactionsResponse> createRepeated() => $pb.PbList<GetRecentInvoicePaymentTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecentInvoicePaymentTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentInvoicePaymentTransactionsResponse>(create);
  static GetRecentInvoicePaymentTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InvoicePaymentTransaction> get transactions => $_getList(0);
}

/// Receipt Operations
class GenerateInvoicePaymentReceiptRequest extends $pb.GeneratedMessage {
  factory GenerateInvoicePaymentReceiptRequest({
    $core.String? transactionId,
    $core.String? templateId,
    $core.bool? includeInvoiceDetails,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (templateId != null) {
      $result.templateId = templateId;
    }
    if (includeInvoiceDetails != null) {
      $result.includeInvoiceDetails = includeInvoiceDetails;
    }
    return $result;
  }
  GenerateInvoicePaymentReceiptRequest._() : super();
  factory GenerateInvoicePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateInvoicePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateInvoicePaymentReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'templateId')
    ..aOB(3, _omitFieldNames ? '' : 'includeInvoiceDetails')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptRequest clone() => GenerateInvoicePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptRequest copyWith(void Function(GenerateInvoicePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GenerateInvoicePaymentReceiptRequest)) as GenerateInvoicePaymentReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateInvoicePaymentReceiptRequest create() => GenerateInvoicePaymentReceiptRequest._();
  GenerateInvoicePaymentReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateInvoicePaymentReceiptRequest> createRepeated() => $pb.PbList<GenerateInvoicePaymentReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateInvoicePaymentReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateInvoicePaymentReceiptRequest>(create);
  static GenerateInvoicePaymentReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get templateId => $_getSZ(1);
  @$pb.TagNumber(2)
  set templateId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTemplateId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTemplateId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeInvoiceDetails => $_getBF(2);
  @$pb.TagNumber(3)
  set includeInvoiceDetails($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncludeInvoiceDetails() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeInvoiceDetails() => clearField(3);
}

class GenerateInvoicePaymentReceiptResponse extends $pb.GeneratedMessage {
  factory GenerateInvoicePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.List<$core.int>? receiptData,
    $core.String? message,
    $core.bool? success,
  }) {
    final $result = create();
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    if (receiptData != null) {
      $result.receiptData = receiptData;
    }
    if (message != null) {
      $result.message = message;
    }
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  GenerateInvoicePaymentReceiptResponse._() : super();
  factory GenerateInvoicePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateInvoicePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateInvoicePaymentReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptUrl')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'receiptData', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOB(4, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptResponse clone() => GenerateInvoicePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptResponse copyWith(void Function(GenerateInvoicePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GenerateInvoicePaymentReceiptResponse)) as GenerateInvoicePaymentReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateInvoicePaymentReceiptResponse create() => GenerateInvoicePaymentReceiptResponse._();
  GenerateInvoicePaymentReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateInvoicePaymentReceiptResponse> createRepeated() => $pb.PbList<GenerateInvoicePaymentReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateInvoicePaymentReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateInvoicePaymentReceiptResponse>(create);
  static GenerateInvoicePaymentReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiptUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get receiptData => $_getN(1);
  @$pb.TagNumber(2)
  set receiptData($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiptData() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptData() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get success => $_getBF(3);
  @$pb.TagNumber(4)
  set success($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSuccess() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccess() => clearField(4);
}

class EmailInvoicePaymentReceiptRequest extends $pb.GeneratedMessage {
  factory EmailInvoicePaymentReceiptRequest({
    $core.String? transactionId,
    $core.String? recipientEmail,
    $core.String? customMessage,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (customMessage != null) {
      $result.customMessage = customMessage;
    }
    return $result;
  }
  EmailInvoicePaymentReceiptRequest._() : super();
  factory EmailInvoicePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailInvoicePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailInvoicePaymentReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(3, _omitFieldNames ? '' : 'customMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptRequest clone() => EmailInvoicePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptRequest copyWith(void Function(EmailInvoicePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as EmailInvoicePaymentReceiptRequest)) as EmailInvoicePaymentReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailInvoicePaymentReceiptRequest create() => EmailInvoicePaymentReceiptRequest._();
  EmailInvoicePaymentReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<EmailInvoicePaymentReceiptRequest> createRepeated() => $pb.PbList<EmailInvoicePaymentReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static EmailInvoicePaymentReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailInvoicePaymentReceiptRequest>(create);
  static EmailInvoicePaymentReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientEmail => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientEmail($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipientEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get customMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set customMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomMessage() => clearField(3);
}

class EmailInvoicePaymentReceiptResponse extends $pb.GeneratedMessage {
  factory EmailInvoicePaymentReceiptResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? trackingId,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (trackingId != null) {
      $result.trackingId = trackingId;
    }
    return $result;
  }
  EmailInvoicePaymentReceiptResponse._() : super();
  factory EmailInvoicePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailInvoicePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailInvoicePaymentReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'trackingId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptResponse clone() => EmailInvoicePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptResponse copyWith(void Function(EmailInvoicePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as EmailInvoicePaymentReceiptResponse)) as EmailInvoicePaymentReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailInvoicePaymentReceiptResponse create() => EmailInvoicePaymentReceiptResponse._();
  EmailInvoicePaymentReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<EmailInvoicePaymentReceiptResponse> createRepeated() => $pb.PbList<EmailInvoicePaymentReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static EmailInvoicePaymentReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailInvoicePaymentReceiptResponse>(create);
  static EmailInvoicePaymentReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get trackingId => $_getSZ(2);
  @$pb.TagNumber(3)
  set trackingId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTrackingId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrackingId() => clearField(3);
}

class GetInvoicePaymentReceiptRequest extends $pb.GeneratedMessage {
  factory GetInvoicePaymentReceiptRequest({
    $core.String? transactionId,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  GetInvoicePaymentReceiptRequest._() : super();
  factory GetInvoicePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptRequest clone() => GetInvoicePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptRequest copyWith(void Function(GetInvoicePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentReceiptRequest)) as GetInvoicePaymentReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentReceiptRequest create() => GetInvoicePaymentReceiptRequest._();
  GetInvoicePaymentReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentReceiptRequest> createRepeated() => $pb.PbList<GetInvoicePaymentReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentReceiptRequest>(create);
  static GetInvoicePaymentReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
}

class GetInvoicePaymentReceiptResponse extends $pb.GeneratedMessage {
  factory GetInvoicePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.List<$core.int>? receiptData,
    $42.Timestamp? generatedAt,
  }) {
    final $result = create();
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    if (receiptData != null) {
      $result.receiptData = receiptData;
    }
    if (generatedAt != null) {
      $result.generatedAt = generatedAt;
    }
    return $result;
  }
  GetInvoicePaymentReceiptResponse._() : super();
  factory GetInvoicePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptUrl')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'receiptData', $pb.PbFieldType.OY)
    ..aOM<$42.Timestamp>(3, _omitFieldNames ? '' : 'generatedAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptResponse clone() => GetInvoicePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptResponse copyWith(void Function(GetInvoicePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentReceiptResponse)) as GetInvoicePaymentReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentReceiptResponse create() => GetInvoicePaymentReceiptResponse._();
  GetInvoicePaymentReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentReceiptResponse> createRepeated() => $pb.PbList<GetInvoicePaymentReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentReceiptResponse>(create);
  static GetInvoicePaymentReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiptUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get receiptData => $_getN(1);
  @$pb.TagNumber(2)
  set receiptData($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiptData() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptData() => clearField(2);

  @$pb.TagNumber(3)
  $42.Timestamp get generatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAt($42.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAt() => clearField(3);
  @$pb.TagNumber(3)
  $42.Timestamp ensureGeneratedAt() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
