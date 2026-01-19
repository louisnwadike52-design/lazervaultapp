///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $36;

import 'common.pbenum.dart' as $37;

class InvoicePaymentDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoicePaymentDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<$37.PaymentMethodType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method', $pb.PbFieldType.OE, defaultOrMaker: $37.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $37.PaymentMethodType.valueOf, enumValues: $37.PaymentMethodType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardLast4')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..m<$core.String, $core.String>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'InvoicePaymentDetails.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoWalletAddress')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoTransactionHash')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentProcessor')
    ..hasRequiredFields = false
  ;

  InvoicePaymentDetails._() : super();
  factory InvoicePaymentDetails({
    $37.PaymentMethodType? method,
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
    final _result = create();
    if (method != null) {
      _result.method = method;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (cardLast4 != null) {
      _result.cardLast4 = cardLast4;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (cryptoWalletAddress != null) {
      _result.cryptoWalletAddress = cryptoWalletAddress;
    }
    if (cryptoTransactionHash != null) {
      _result.cryptoTransactionHash = cryptoTransactionHash;
    }
    if (feeAmount != null) {
      _result.feeAmount = feeAmount;
    }
    if (paymentProcessor != null) {
      _result.paymentProcessor = paymentProcessor;
    }
    return _result;
  }
  factory InvoicePaymentDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentDetails clone() => InvoicePaymentDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentDetails copyWith(void Function(InvoicePaymentDetails) updates) => super.copyWith((message) => updates(message as InvoicePaymentDetails)) as InvoicePaymentDetails; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentDetails create() => InvoicePaymentDetails._();
  InvoicePaymentDetails createEmptyInstance() => create();
  static $pb.PbList<InvoicePaymentDetails> createRepeated() => $pb.PbList<InvoicePaymentDetails>();
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoicePaymentDetails>(create);
  static InvoicePaymentDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $37.PaymentMethodType get method => $_getN(0);
  @$pb.TagNumber(1)
  set method($37.PaymentMethodType v) { setField(1, v); }
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

class InvoicePaymentResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoicePaymentResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..e<$37.InvoicePaymentStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $37.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $37.InvoicePaymentStatus.valueOf, enumValues: $37.InvoicePaymentStatus.values)
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processedAt', subBuilder: $36.Timestamp.create)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountProcessed', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationCode')
    ..hasRequiredFields = false
  ;

  InvoicePaymentResult._() : super();
  factory InvoicePaymentResult({
    $core.bool? success,
    $core.String? transactionId,
    $core.String? paymentReference,
    $core.String? errorMessage,
    $37.InvoicePaymentStatus? status,
    $36.Timestamp? processedAt,
    $core.double? amountProcessed,
    $core.double? feeAmount,
    $core.String? receiptUrl,
    $core.String? confirmationCode,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (status != null) {
      _result.status = status;
    }
    if (processedAt != null) {
      _result.processedAt = processedAt;
    }
    if (amountProcessed != null) {
      _result.amountProcessed = amountProcessed;
    }
    if (feeAmount != null) {
      _result.feeAmount = feeAmount;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (confirmationCode != null) {
      _result.confirmationCode = confirmationCode;
    }
    return _result;
  }
  factory InvoicePaymentResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentResult clone() => InvoicePaymentResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentResult copyWith(void Function(InvoicePaymentResult) updates) => super.copyWith((message) => updates(message as InvoicePaymentResult)) as InvoicePaymentResult; // ignore: deprecated_member_use
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
  $37.InvoicePaymentStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status($37.InvoicePaymentStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $36.Timestamp get processedAt => $_getN(5);
  @$pb.TagNumber(6)
  set processedAt($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasProcessedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearProcessedAt() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureProcessedAt() => $_ensure(5);

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

class InvoicePaymentTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoicePaymentTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<$37.PaymentMethodType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', $pb.PbFieldType.OE, defaultOrMaker: $37.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $37.PaymentMethodType.valueOf, enumValues: $37.PaymentMethodType.values)
    ..e<$37.InvoicePaymentStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $37.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $37.InvoicePaymentStatus.valueOf, enumValues: $37.InvoicePaymentStatus.values)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processedAt', subBuilder: $36.Timestamp.create)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.String>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'InvoicePaymentTransaction.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentProcessorId')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..hasRequiredFields = false
  ;

  InvoicePaymentTransaction._() : super();
  factory InvoicePaymentTransaction({
    $core.String? transactionId,
    $core.String? invoiceId,
    $core.String? userId,
    $core.double? amount,
    $core.String? currency,
    $37.PaymentMethodType? paymentMethod,
    $37.InvoicePaymentStatus? status,
    $36.Timestamp? createdAt,
    $36.Timestamp? processedAt,
    $core.String? reference,
    $core.String? description,
    $core.double? feeAmount,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? paymentProcessorId,
    $core.String? receiptUrl,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (processedAt != null) {
      _result.processedAt = processedAt;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (description != null) {
      _result.description = description;
    }
    if (feeAmount != null) {
      _result.feeAmount = feeAmount;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (paymentProcessorId != null) {
      _result.paymentProcessorId = paymentProcessorId;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    return _result;
  }
  factory InvoicePaymentTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentTransaction clone() => InvoicePaymentTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentTransaction copyWith(void Function(InvoicePaymentTransaction) updates) => super.copyWith((message) => updates(message as InvoicePaymentTransaction)) as InvoicePaymentTransaction; // ignore: deprecated_member_use
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
  $37.PaymentMethodType get paymentMethod => $_getN(5);
  @$pb.TagNumber(6)
  set paymentMethod($37.PaymentMethodType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentMethod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentMethod() => clearField(6);

  @$pb.TagNumber(7)
  $37.InvoicePaymentStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($37.InvoicePaymentStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $36.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $36.Timestamp get processedAt => $_getN(8);
  @$pb.TagNumber(9)
  set processedAt($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasProcessedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearProcessedAt() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureProcessedAt() => $_ensure(8);

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

class UserAccountBalance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserAccountBalance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..e<$37.AccountType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType', $pb.PbFieldType.OE, defaultOrMaker: $37.AccountType.ACCOUNT_TYPE_PERSONAL, valueOf: $37.AccountType.valueOf, enumValues: $37.AccountType.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $36.Timestamp.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPrimary')
    ..hasRequiredFields = false
  ;

  UserAccountBalance._() : super();
  factory UserAccountBalance({
    $core.String? userId,
    $core.String? currency,
    $core.double? availableBalance,
    $core.double? pendingBalance,
    $core.double? totalBalance,
    $37.AccountType? accountType,
    $core.String? accountNumber,
    $36.Timestamp? lastUpdated,
    $core.String? accountName,
    $core.bool? isPrimary,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (availableBalance != null) {
      _result.availableBalance = availableBalance;
    }
    if (pendingBalance != null) {
      _result.pendingBalance = pendingBalance;
    }
    if (totalBalance != null) {
      _result.totalBalance = totalBalance;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (isPrimary != null) {
      _result.isPrimary = isPrimary;
    }
    return _result;
  }
  factory UserAccountBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccountBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserAccountBalance clone() => UserAccountBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserAccountBalance copyWith(void Function(UserAccountBalance) updates) => super.copyWith((message) => updates(message as UserAccountBalance)) as UserAccountBalance; // ignore: deprecated_member_use
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
  $37.AccountType get accountType => $_getN(5);
  @$pb.TagNumber(6)
  set accountType($37.AccountType v) { setField(6, v); }
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
  $36.Timestamp get lastUpdated => $_getN(7);
  @$pb.TagNumber(8)
  set lastUpdated($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastUpdated() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdated() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureLastUpdated() => $_ensure(7);

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

class PaymentMethod extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaymentMethod', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<$37.PaymentMethodType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $37.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $37.PaymentMethodType.valueOf, enumValues: $37.PaymentMethodType.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'last4')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brand')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDefault')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isVerified')
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..m<$core.String, $core.String>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'PaymentMethod.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billingAddress')
    ..hasRequiredFields = false
  ;

  PaymentMethod._() : super();
  factory PaymentMethod({
    $core.String? methodId,
    $core.String? userId,
    $37.PaymentMethodType? type,
    $core.String? displayName,
    $core.String? last4,
    $core.String? brand,
    $core.bool? isDefault,
    $core.bool? isVerified,
    $36.Timestamp? expiresAt,
    $36.Timestamp? createdAt,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? billingAddress,
  }) {
    final _result = create();
    if (methodId != null) {
      _result.methodId = methodId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (type != null) {
      _result.type = type;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (last4 != null) {
      _result.last4 = last4;
    }
    if (brand != null) {
      _result.brand = brand;
    }
    if (isDefault != null) {
      _result.isDefault = isDefault;
    }
    if (isVerified != null) {
      _result.isVerified = isVerified;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (billingAddress != null) {
      _result.billingAddress = billingAddress;
    }
    return _result;
  }
  factory PaymentMethod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentMethod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentMethod clone() => PaymentMethod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentMethod copyWith(void Function(PaymentMethod) updates) => super.copyWith((message) => updates(message as PaymentMethod)) as PaymentMethod; // ignore: deprecated_member_use
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
  $37.PaymentMethodType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type($37.PaymentMethodType v) { setField(3, v); }
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
  $36.Timestamp get expiresAt => $_getN(8);
  @$pb.TagNumber(9)
  set expiresAt($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasExpiresAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiresAt() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureExpiresAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $36.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureCreatedAt() => $_ensure(9);

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

class CryptoWallet extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoWallet', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletAddress')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isVerified')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastSync', subBuilder: $36.Timestamp.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletType')
    ..hasRequiredFields = false
  ;

  CryptoWallet._() : super();
  factory CryptoWallet({
    $core.String? walletId,
    $core.String? userId,
    $core.String? walletAddress,
    $core.String? currency,
    $core.double? balance,
    $core.bool? isVerified,
    $36.Timestamp? createdAt,
    $36.Timestamp? lastSync,
    $core.String? network,
    $core.String? walletType,
  }) {
    final _result = create();
    if (walletId != null) {
      _result.walletId = walletId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (walletAddress != null) {
      _result.walletAddress = walletAddress;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (isVerified != null) {
      _result.isVerified = isVerified;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (lastSync != null) {
      _result.lastSync = lastSync;
    }
    if (network != null) {
      _result.network = network;
    }
    if (walletType != null) {
      _result.walletType = walletType;
    }
    return _result;
  }
  factory CryptoWallet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoWallet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoWallet clone() => CryptoWallet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoWallet copyWith(void Function(CryptoWallet) updates) => super.copyWith((message) => updates(message as CryptoWallet)) as CryptoWallet; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CryptoWallet create() => CryptoWallet._();
  CryptoWallet createEmptyInstance() => create();
  static $pb.PbList<CryptoWallet> createRepeated() => $pb.PbList<CryptoWallet>();
  @$core.pragma('dart2js:noInline')
  static CryptoWallet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoWallet>(create);
  static CryptoWallet? _defaultInstance;

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
  $36.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $36.Timestamp get lastSync => $_getN(7);
  @$pb.TagNumber(8)
  set lastSync($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastSync() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastSync() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureLastSync() => $_ensure(7);

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

class PaymentExtensionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaymentExtensionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extensionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDueDate', subBuilder: $36.Timestamp.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$36.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestedAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedAt', subBuilder: $36.Timestamp.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedBy')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  PaymentExtensionRequest._() : super();
  factory PaymentExtensionRequest({
    $core.String? extensionId,
    $core.String? invoiceId,
    $core.String? userId,
    $36.Timestamp? newDueDate,
    $core.String? reason,
    $core.String? status,
    $36.Timestamp? requestedAt,
    $36.Timestamp? approvedAt,
    $core.String? approvedBy,
    $core.String? rejectionReason,
  }) {
    final _result = create();
    if (extensionId != null) {
      _result.extensionId = extensionId;
    }
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (newDueDate != null) {
      _result.newDueDate = newDueDate;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (status != null) {
      _result.status = status;
    }
    if (requestedAt != null) {
      _result.requestedAt = requestedAt;
    }
    if (approvedAt != null) {
      _result.approvedAt = approvedAt;
    }
    if (approvedBy != null) {
      _result.approvedBy = approvedBy;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    return _result;
  }
  factory PaymentExtensionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentExtensionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentExtensionRequest clone() => PaymentExtensionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentExtensionRequest copyWith(void Function(PaymentExtensionRequest) updates) => super.copyWith((message) => updates(message as PaymentExtensionRequest)) as PaymentExtensionRequest; // ignore: deprecated_member_use
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
  $36.Timestamp get newDueDate => $_getN(3);
  @$pb.TagNumber(4)
  set newDueDate($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewDueDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewDueDate() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureNewDueDate() => $_ensure(3);

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
  $36.Timestamp get requestedAt => $_getN(6);
  @$pb.TagNumber(7)
  set requestedAt($36.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequestedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequestedAt() => clearField(7);
  @$pb.TagNumber(7)
  $36.Timestamp ensureRequestedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $36.Timestamp get approvedAt => $_getN(7);
  @$pb.TagNumber(8)
  set approvedAt($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasApprovedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearApprovedAt() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureApprovedAt() => $_ensure(7);

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

class PaymentDispute extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaymentDispute', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disputeId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<$37.DisputeStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $37.DisputeStatus.DISPUTE_STATUS_PENDING, valueOf: $37.DisputeStatus.valueOf, enumValues: $37.DisputeStatus.values)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolvedAt', subBuilder: $36.Timestamp.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolution')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evidenceFiles')
    ..hasRequiredFields = false
  ;

  PaymentDispute._() : super();
  factory PaymentDispute({
    $core.String? disputeId,
    $core.String? transactionId,
    $core.String? invoiceId,
    $core.String? userId,
    $core.String? reason,
    $core.String? description,
    $37.DisputeStatus? status,
    $core.double? amount,
    $core.String? currency,
    $36.Timestamp? createdAt,
    $36.Timestamp? resolvedAt,
    $core.String? resolution,
    $core.Iterable<$core.String>? evidenceFiles,
  }) {
    final _result = create();
    if (disputeId != null) {
      _result.disputeId = disputeId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (description != null) {
      _result.description = description;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (resolvedAt != null) {
      _result.resolvedAt = resolvedAt;
    }
    if (resolution != null) {
      _result.resolution = resolution;
    }
    if (evidenceFiles != null) {
      _result.evidenceFiles.addAll(evidenceFiles);
    }
    return _result;
  }
  factory PaymentDispute.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentDispute.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentDispute clone() => PaymentDispute()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentDispute copyWith(void Function(PaymentDispute) updates) => super.copyWith((message) => updates(message as PaymentDispute)) as PaymentDispute; // ignore: deprecated_member_use
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
  $37.DisputeStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($37.DisputeStatus v) { setField(7, v); }
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
  $36.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $36.Timestamp get resolvedAt => $_getN(10);
  @$pb.TagNumber(11)
  set resolvedAt($36.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasResolvedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearResolvedAt() => clearField(11);
  @$pb.TagNumber(11)
  $36.Timestamp ensureResolvedAt() => $_ensure(10);

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

class ProcessInvoicePaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethodId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'ProcessInvoicePaymentRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savePaymentMethod')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billingAddress')
    ..hasRequiredFields = false
  ;

  ProcessInvoicePaymentRequest._() : super();
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
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (paymentMethodId != null) {
      _result.paymentMethodId = paymentMethodId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (savePaymentMethod != null) {
      _result.savePaymentMethod = savePaymentMethod;
    }
    if (billingAddress != null) {
      _result.billingAddress = billingAddress;
    }
    return _result;
  }
  factory ProcessInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentRequest clone() => ProcessInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentRequest copyWith(void Function(ProcessInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessInvoicePaymentRequest)) as ProcessInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvoicePaymentResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: InvoicePaymentResult.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextAction')
    ..m<$core.String, $core.String>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalData', entryClassName: 'ProcessInvoicePaymentResponse.AdditionalDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  ProcessInvoicePaymentResponse._() : super();
  factory ProcessInvoicePaymentResponse({
    InvoicePaymentResult? result,
    $core.String? message,
    $core.bool? success,
    $core.String? nextAction,
    $core.Map<$core.String, $core.String>? additionalData,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (message != null) {
      _result.message = message;
    }
    if (success != null) {
      _result.success = success;
    }
    if (nextAction != null) {
      _result.nextAction = nextAction;
    }
    if (additionalData != null) {
      _result.additionalData.addAll(additionalData);
    }
    return _result;
  }
  factory ProcessInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentResponse clone() => ProcessInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessInvoicePaymentResponse copyWith(void Function(ProcessInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessInvoicePaymentResponse)) as ProcessInvoicePaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPartialInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethodId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'partialAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'ProcessPartialInvoicePaymentRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  ProcessPartialInvoicePaymentRequest._() : super();
  factory ProcessPartialInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? paymentMethodId,
    $core.double? partialAmount,
    $core.String? currency,
    $core.String? description,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (paymentMethodId != null) {
      _result.paymentMethodId = paymentMethodId;
    }
    if (partialAmount != null) {
      _result.partialAmount = partialAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (description != null) {
      _result.description = description;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory ProcessPartialInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPartialInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentRequest clone() => ProcessPartialInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentRequest copyWith(void Function(ProcessPartialInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessPartialInvoicePaymentRequest)) as ProcessPartialInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPartialInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvoicePaymentResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: InvoicePaymentResult.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAmount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  ProcessPartialInvoicePaymentResponse._() : super();
  factory ProcessPartialInvoicePaymentResponse({
    InvoicePaymentResult? result,
    $core.double? remainingAmount,
    $core.String? message,
    $core.bool? success,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (remainingAmount != null) {
      _result.remainingAmount = remainingAmount;
    }
    if (message != null) {
      _result.message = message;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory ProcessPartialInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPartialInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentResponse clone() => ProcessPartialInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPartialInvoicePaymentResponse copyWith(void Function(ProcessPartialInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessPartialInvoicePaymentResponse)) as ProcessPartialInvoicePaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethodId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  ValidateInvoicePaymentRequest._() : super();
  factory ValidateInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? paymentMethodId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (paymentMethodId != null) {
      _result.paymentMethodId = paymentMethodId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory ValidateInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentRequest clone() => ValidateInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentRequest copyWith(void Function(ValidateInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentRequest)) as ValidateInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationMessage')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentFees', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ValidateInvoicePaymentResponse._() : super();
  factory ValidateInvoicePaymentResponse({
    $core.bool? isValid,
    $core.String? validationMessage,
    $core.Iterable<$core.String>? errors,
    $core.double? availableBalance,
    $core.double? paymentFees,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (validationMessage != null) {
      _result.validationMessage = validationMessage;
    }
    if (errors != null) {
      _result.errors.addAll(errors);
    }
    if (availableBalance != null) {
      _result.availableBalance = availableBalance;
    }
    if (paymentFees != null) {
      _result.paymentFees = paymentFees;
    }
    return _result;
  }
  factory ValidateInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentResponse clone() => ValidateInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentResponse copyWith(void Function(ValidateInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentResponse)) as ValidateInvoicePaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentStatusRequest._() : super();
  factory GetInvoicePaymentStatusRequest({
    $core.String? transactionId,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory GetInvoicePaymentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusRequest clone() => GetInvoicePaymentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusRequest copyWith(void Function(GetInvoicePaymentStatusRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatusRequest)) as GetInvoicePaymentStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InvoicePaymentTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: InvoicePaymentTransaction.create)
    ..e<$37.InvoicePaymentStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentStatus', $pb.PbFieldType.OE, defaultOrMaker: $37.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $37.InvoicePaymentStatus.valueOf, enumValues: $37.InvoicePaymentStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusMessage')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentStatusResponse._() : super();
  factory GetInvoicePaymentStatusResponse({
    InvoicePaymentTransaction? transaction,
    $37.InvoicePaymentStatus? currentStatus,
    $core.String? statusMessage,
    $36.Timestamp? lastUpdated,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (currentStatus != null) {
      _result.currentStatus = currentStatus;
    }
    if (statusMessage != null) {
      _result.statusMessage = statusMessage;
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    return _result;
  }
  factory GetInvoicePaymentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusResponse clone() => GetInvoicePaymentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatusResponse copyWith(void Function(GetInvoicePaymentStatusResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatusResponse)) as GetInvoicePaymentStatusResponse; // ignore: deprecated_member_use
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
  $37.InvoicePaymentStatus get currentStatus => $_getN(1);
  @$pb.TagNumber(2)
  set currentStatus($37.InvoicePaymentStatus v) { setField(2, v); }
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
  $36.Timestamp get lastUpdated => $_getN(3);
  @$pb.TagNumber(4)
  set lastUpdated($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastUpdated() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastUpdated() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureLastUpdated() => $_ensure(3);
}

class CancelInvoicePaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  CancelInvoicePaymentRequest._() : super();
  factory CancelInvoicePaymentRequest({
    $core.String? transactionId,
    $core.String? reason,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory CancelInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentRequest clone() => CancelInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentRequest copyWith(void Function(CancelInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as CancelInvoicePaymentRequest)) as CancelInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..e<$37.InvoicePaymentStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newStatus', $pb.PbFieldType.OE, defaultOrMaker: $37.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $37.InvoicePaymentStatus.valueOf, enumValues: $37.InvoicePaymentStatus.values)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CancelInvoicePaymentResponse._() : super();
  factory CancelInvoicePaymentResponse({
    $core.bool? success,
    $core.String? message,
    $37.InvoicePaymentStatus? newStatus,
    $core.double? refundAmount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (newStatus != null) {
      _result.newStatus = newStatus;
    }
    if (refundAmount != null) {
      _result.refundAmount = refundAmount;
    }
    return _result;
  }
  factory CancelInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentResponse clone() => CancelInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoicePaymentResponse copyWith(void Function(CancelInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as CancelInvoicePaymentResponse)) as CancelInvoicePaymentResponse; // ignore: deprecated_member_use
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
  $37.InvoicePaymentStatus get newStatus => $_getN(2);
  @$pb.TagNumber(3)
  set newStatus($37.InvoicePaymentStatus v) { setField(3, v); }
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

class GetUserInvoicePaymentMethodsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInvoicePaymentMethodsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<$37.PaymentMethodType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'typeFilter', $pb.PbFieldType.OE, defaultOrMaker: $37.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $37.PaymentMethodType.valueOf, enumValues: $37.PaymentMethodType.values)
    ..hasRequiredFields = false
  ;

  GetUserInvoicePaymentMethodsRequest._() : super();
  factory GetUserInvoicePaymentMethodsRequest({
    $37.PaymentMethodType? typeFilter,
  }) {
    final _result = create();
    if (typeFilter != null) {
      _result.typeFilter = typeFilter;
    }
    return _result;
  }
  factory GetUserInvoicePaymentMethodsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInvoicePaymentMethodsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsRequest clone() => GetUserInvoicePaymentMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsRequest copyWith(void Function(GetUserInvoicePaymentMethodsRequest) updates) => super.copyWith((message) => updates(message as GetUserInvoicePaymentMethodsRequest)) as GetUserInvoicePaymentMethodsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserInvoicePaymentMethodsRequest create() => GetUserInvoicePaymentMethodsRequest._();
  GetUserInvoicePaymentMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInvoicePaymentMethodsRequest> createRepeated() => $pb.PbList<GetUserInvoicePaymentMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInvoicePaymentMethodsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInvoicePaymentMethodsRequest>(create);
  static GetUserInvoicePaymentMethodsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $37.PaymentMethodType get typeFilter => $_getN(0);
  @$pb.TagNumber(1)
  set typeFilter($37.PaymentMethodType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTypeFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeFilter() => clearField(1);
}

class GetUserInvoicePaymentMethodsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInvoicePaymentMethodsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PaymentMethod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethods', $pb.PbFieldType.PM, subBuilder: PaymentMethod.create)
    ..aOM<PaymentMethod>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultMethod', subBuilder: PaymentMethod.create)
    ..hasRequiredFields = false
  ;

  GetUserInvoicePaymentMethodsResponse._() : super();
  factory GetUserInvoicePaymentMethodsResponse({
    $core.Iterable<PaymentMethod>? paymentMethods,
    PaymentMethod? defaultMethod,
  }) {
    final _result = create();
    if (paymentMethods != null) {
      _result.paymentMethods.addAll(paymentMethods);
    }
    if (defaultMethod != null) {
      _result.defaultMethod = defaultMethod;
    }
    return _result;
  }
  factory GetUserInvoicePaymentMethodsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInvoicePaymentMethodsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsResponse clone() => GetUserInvoicePaymentMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInvoicePaymentMethodsResponse copyWith(void Function(GetUserInvoicePaymentMethodsResponse) updates) => super.copyWith((message) => updates(message as GetUserInvoicePaymentMethodsResponse)) as GetUserInvoicePaymentMethodsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddInvoicePaymentMethodRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<$37.PaymentMethodType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $37.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE, valueOf: $37.PaymentMethodType.valueOf, enumValues: $37.PaymentMethodType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..m<$core.String, $core.String>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentDetails', entryClassName: 'AddInvoicePaymentMethodRequest.PaymentDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'setAsDefault')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billingAddress')
    ..hasRequiredFields = false
  ;

  AddInvoicePaymentMethodRequest._() : super();
  factory AddInvoicePaymentMethodRequest({
    $37.PaymentMethodType? type,
    $core.String? displayName,
    $core.Map<$core.String, $core.String>? paymentDetails,
    $core.bool? setAsDefault,
    $core.String? billingAddress,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (paymentDetails != null) {
      _result.paymentDetails.addAll(paymentDetails);
    }
    if (setAsDefault != null) {
      _result.setAsDefault = setAsDefault;
    }
    if (billingAddress != null) {
      _result.billingAddress = billingAddress;
    }
    return _result;
  }
  factory AddInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodRequest clone() => AddInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodRequest copyWith(void Function(AddInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as AddInvoicePaymentMethodRequest)) as AddInvoicePaymentMethodRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddInvoicePaymentMethodRequest create() => AddInvoicePaymentMethodRequest._();
  AddInvoicePaymentMethodRequest createEmptyInstance() => create();
  static $pb.PbList<AddInvoicePaymentMethodRequest> createRepeated() => $pb.PbList<AddInvoicePaymentMethodRequest>();
  @$core.pragma('dart2js:noInline')
  static AddInvoicePaymentMethodRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddInvoicePaymentMethodRequest>(create);
  static AddInvoicePaymentMethodRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $37.PaymentMethodType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type($37.PaymentMethodType v) { setField(1, v); }
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddInvoicePaymentMethodResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentMethod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', subBuilder: PaymentMethod.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationUrl')
    ..hasRequiredFields = false
  ;

  AddInvoicePaymentMethodResponse._() : super();
  factory AddInvoicePaymentMethodResponse({
    PaymentMethod? paymentMethod,
    $core.bool? success,
    $core.String? message,
    $core.String? verificationUrl,
  }) {
    final _result = create();
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (verificationUrl != null) {
      _result.verificationUrl = verificationUrl;
    }
    return _result;
  }
  factory AddInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodResponse clone() => AddInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddInvoicePaymentMethodResponse copyWith(void Function(AddInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as AddInvoicePaymentMethodResponse)) as AddInvoicePaymentMethodResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveInvoicePaymentMethodRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodId')
    ..hasRequiredFields = false
  ;

  RemoveInvoicePaymentMethodRequest._() : super();
  factory RemoveInvoicePaymentMethodRequest({
    $core.String? methodId,
  }) {
    final _result = create();
    if (methodId != null) {
      _result.methodId = methodId;
    }
    return _result;
  }
  factory RemoveInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodRequest clone() => RemoveInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodRequest copyWith(void Function(RemoveInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as RemoveInvoicePaymentMethodRequest)) as RemoveInvoicePaymentMethodRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveInvoicePaymentMethodResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RemoveInvoicePaymentMethodResponse._() : super();
  factory RemoveInvoicePaymentMethodResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RemoveInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodResponse clone() => RemoveInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveInvoicePaymentMethodResponse copyWith(void Function(RemoveInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as RemoveInvoicePaymentMethodResponse)) as RemoveInvoicePaymentMethodResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateInvoicePaymentMethodRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'testAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ValidateInvoicePaymentMethodRequest._() : super();
  factory ValidateInvoicePaymentMethodRequest({
    $core.String? methodId,
    $core.double? testAmount,
  }) {
    final _result = create();
    if (methodId != null) {
      _result.methodId = methodId;
    }
    if (testAmount != null) {
      _result.testAmount = testAmount;
    }
    return _result;
  }
  factory ValidateInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodRequest clone() => ValidateInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodRequest copyWith(void Function(ValidateInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentMethodRequest)) as ValidateInvoicePaymentMethodRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateInvoicePaymentMethodResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationMessage')
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ValidateInvoicePaymentMethodResponse._() : super();
  factory ValidateInvoicePaymentMethodResponse({
    $core.bool? isValid,
    $core.String? validationMessage,
    $36.Timestamp? validatedAt,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (validationMessage != null) {
      _result.validationMessage = validationMessage;
    }
    if (validatedAt != null) {
      _result.validatedAt = validatedAt;
    }
    return _result;
  }
  factory ValidateInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodResponse clone() => ValidateInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInvoicePaymentMethodResponse copyWith(void Function(ValidateInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as ValidateInvoicePaymentMethodResponse)) as ValidateInvoicePaymentMethodResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get validatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set validatedAt($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureValidatedAt() => $_ensure(2);
}

class UpdateInvoicePaymentMethodRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInvoicePaymentMethodRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDefault')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billingAddress')
    ..m<$core.String, $core.String>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'UpdateInvoicePaymentMethodRequest.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  UpdateInvoicePaymentMethodRequest._() : super();
  factory UpdateInvoicePaymentMethodRequest({
    $core.String? methodId,
    $core.String? displayName,
    $core.bool? isDefault,
    $core.String? billingAddress,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (methodId != null) {
      _result.methodId = methodId;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (isDefault != null) {
      _result.isDefault = isDefault;
    }
    if (billingAddress != null) {
      _result.billingAddress = billingAddress;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory UpdateInvoicePaymentMethodRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoicePaymentMethodRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodRequest clone() => UpdateInvoicePaymentMethodRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodRequest copyWith(void Function(UpdateInvoicePaymentMethodRequest) updates) => super.copyWith((message) => updates(message as UpdateInvoicePaymentMethodRequest)) as UpdateInvoicePaymentMethodRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInvoicePaymentMethodResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentMethod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', subBuilder: PaymentMethod.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateInvoicePaymentMethodResponse._() : super();
  factory UpdateInvoicePaymentMethodResponse({
    PaymentMethod? paymentMethod,
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateInvoicePaymentMethodResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoicePaymentMethodResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodResponse clone() => UpdateInvoicePaymentMethodResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoicePaymentMethodResponse copyWith(void Function(UpdateInvoicePaymentMethodResponse) updates) => super.copyWith((message) => updates(message as UpdateInvoicePaymentMethodResponse)) as UpdateInvoicePaymentMethodResponse; // ignore: deprecated_member_use
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

class GetUserAccountBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserAccountBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<$37.AccountType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType', $pb.PbFieldType.OE, defaultOrMaker: $37.AccountType.ACCOUNT_TYPE_PERSONAL, valueOf: $37.AccountType.valueOf, enumValues: $37.AccountType.values)
    ..hasRequiredFields = false
  ;

  GetUserAccountBalanceRequest._() : super();
  factory GetUserAccountBalanceRequest({
    $core.String? currency,
    $37.AccountType? accountType,
  }) {
    final _result = create();
    if (currency != null) {
      _result.currency = currency;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    return _result;
  }
  factory GetUserAccountBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceRequest clone() => GetUserAccountBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceRequest copyWith(void Function(GetUserAccountBalanceRequest) updates) => super.copyWith((message) => updates(message as GetUserAccountBalanceRequest)) as GetUserAccountBalanceRequest; // ignore: deprecated_member_use
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
  $37.AccountType get accountType => $_getN(1);
  @$pb.TagNumber(2)
  set accountType($37.AccountType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountType() => clearField(2);
}

class GetUserAccountBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserAccountBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<UserAccountBalance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: UserAccountBalance.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'primaryCurrency')
    ..hasRequiredFields = false
  ;

  GetUserAccountBalanceResponse._() : super();
  factory GetUserAccountBalanceResponse({
    $core.Iterable<UserAccountBalance>? accounts,
    $core.double? totalBalance,
    $core.String? primaryCurrency,
  }) {
    final _result = create();
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    if (totalBalance != null) {
      _result.totalBalance = totalBalance;
    }
    if (primaryCurrency != null) {
      _result.primaryCurrency = primaryCurrency;
    }
    return _result;
  }
  factory GetUserAccountBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAccountBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceResponse clone() => GetUserAccountBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAccountBalanceResponse copyWith(void Function(GetUserAccountBalanceResponse) updates) => super.copyWith((message) => updates(message as GetUserAccountBalanceResponse)) as GetUserAccountBalanceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountBalanceHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  GetAccountBalanceHistoryRequest._() : super();
  factory GetAccountBalanceHistoryRequest({
    $core.String? accountId,
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (pageToken != null) {
      _result.pageToken = pageToken;
    }
    return _result;
  }
  factory GetAccountBalanceHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountBalanceHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryRequest clone() => GetAccountBalanceHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryRequest copyWith(void Function(GetAccountBalanceHistoryRequest) updates) => super.copyWith((message) => updates(message as GetAccountBalanceHistoryRequest)) as GetAccountBalanceHistoryRequest; // ignore: deprecated_member_use
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
  $36.Timestamp get startDate => $_getN(1);
  @$pb.TagNumber(2)
  set startDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureStartDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $36.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureEndDate() => $_ensure(2);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountBalanceHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BalanceHistoryEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: BalanceHistoryEntry.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  GetAccountBalanceHistoryResponse._() : super();
  factory GetAccountBalanceHistoryResponse({
    $core.Iterable<BalanceHistoryEntry>? entries,
    $core.String? nextPageToken,
  }) {
    final _result = create();
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (nextPageToken != null) {
      _result.nextPageToken = nextPageToken;
    }
    return _result;
  }
  factory GetAccountBalanceHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountBalanceHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryResponse clone() => GetAccountBalanceHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountBalanceHistoryResponse copyWith(void Function(GetAccountBalanceHistoryResponse) updates) => super.copyWith((message) => updates(message as GetAccountBalanceHistoryResponse)) as GetAccountBalanceHistoryResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BalanceHistoryEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $36.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'changeAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  BalanceHistoryEntry._() : super();
  factory BalanceHistoryEntry({
    $36.Timestamp? timestamp,
    $core.double? balance,
    $core.double? changeAmount,
    $core.String? transactionType,
    $core.String? description,
    $core.String? reference,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (changeAmount != null) {
      _result.changeAmount = changeAmount;
    }
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (description != null) {
      _result.description = description;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    return _result;
  }
  factory BalanceHistoryEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BalanceHistoryEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BalanceHistoryEntry clone() => BalanceHistoryEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BalanceHistoryEntry copyWith(void Function(BalanceHistoryEntry) updates) => super.copyWith((message) => updates(message as BalanceHistoryEntry)) as BalanceHistoryEntry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BalanceHistoryEntry create() => BalanceHistoryEntry._();
  BalanceHistoryEntry createEmptyInstance() => create();
  static $pb.PbList<BalanceHistoryEntry> createRepeated() => $pb.PbList<BalanceHistoryEntry>();
  @$core.pragma('dart2js:noInline')
  static BalanceHistoryEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceHistoryEntry>(create);
  static BalanceHistoryEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureTimestamp() => $_ensure(0);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferFundsForInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromAccountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toAccountId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  TransferFundsForInvoicePaymentRequest._() : super();
  factory TransferFundsForInvoicePaymentRequest({
    $core.String? fromAccountId,
    $core.String? toAccountId,
    $core.double? amount,
    $core.String? currency,
    $core.String? invoiceId,
    $core.String? description,
  }) {
    final _result = create();
    if (fromAccountId != null) {
      _result.fromAccountId = fromAccountId;
    }
    if (toAccountId != null) {
      _result.toAccountId = toAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory TransferFundsForInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferFundsForInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentRequest clone() => TransferFundsForInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentRequest copyWith(void Function(TransferFundsForInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as TransferFundsForInvoicePaymentRequest)) as TransferFundsForInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferFundsForInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TransferFundsForInvoicePaymentResponse._() : super();
  factory TransferFundsForInvoicePaymentResponse({
    $core.bool? success,
    $core.String? transactionId,
    $core.String? message,
    $core.double? newBalance,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (message != null) {
      _result.message = message;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    return _result;
  }
  factory TransferFundsForInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferFundsForInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentResponse clone() => TransferFundsForInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferFundsForInvoicePaymentResponse copyWith(void Function(TransferFundsForInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as TransferFundsForInvoicePaymentResponse)) as TransferFundsForInvoicePaymentResponse; // ignore: deprecated_member_use
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

class ProcessCryptoInvoicePaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessCryptoInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletAddress')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionHash')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  ProcessCryptoInvoicePaymentRequest._() : super();
  factory ProcessCryptoInvoicePaymentRequest({
    $core.String? invoiceId,
    $core.String? walletAddress,
    $core.String? currency,
    $core.double? amount,
    $core.String? transactionHash,
    $core.String? network,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (walletAddress != null) {
      _result.walletAddress = walletAddress;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionHash != null) {
      _result.transactionHash = transactionHash;
    }
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory ProcessCryptoInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessCryptoInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentRequest clone() => ProcessCryptoInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentRequest copyWith(void Function(ProcessCryptoInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessCryptoInvoicePaymentRequest)) as ProcessCryptoInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessCryptoInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationStatus')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationsRequired', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentConfirmations', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ProcessCryptoInvoicePaymentResponse._() : super();
  factory ProcessCryptoInvoicePaymentResponse({
    $core.bool? success,
    $core.String? transactionId,
    $core.String? confirmationStatus,
    $core.int? confirmationsRequired,
    $core.int? currentConfirmations,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (confirmationStatus != null) {
      _result.confirmationStatus = confirmationStatus;
    }
    if (confirmationsRequired != null) {
      _result.confirmationsRequired = confirmationsRequired;
    }
    if (currentConfirmations != null) {
      _result.currentConfirmations = currentConfirmations;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ProcessCryptoInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessCryptoInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentResponse clone() => ProcessCryptoInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessCryptoInvoicePaymentResponse copyWith(void Function(ProcessCryptoInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessCryptoInvoicePaymentResponse)) as ProcessCryptoInvoicePaymentResponse; // ignore: deprecated_member_use
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

class GetCryptoWalletBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoWalletBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletAddress')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  GetCryptoWalletBalanceRequest._() : super();
  factory GetCryptoWalletBalanceRequest({
    $core.String? walletAddress,
    $core.String? currency,
    $core.String? network,
  }) {
    final _result = create();
    if (walletAddress != null) {
      _result.walletAddress = walletAddress;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory GetCryptoWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoWalletBalanceRequest clone() => GetCryptoWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoWalletBalanceRequest copyWith(void Function(GetCryptoWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetCryptoWalletBalanceRequest)) as GetCryptoWalletBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCryptoWalletBalanceRequest create() => GetCryptoWalletBalanceRequest._();
  GetCryptoWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoWalletBalanceRequest> createRepeated() => $pb.PbList<GetCryptoWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoWalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoWalletBalanceRequest>(create);
  static GetCryptoWalletBalanceRequest? _defaultInstance;

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

class GetCryptoWalletBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoWalletBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $36.Timestamp.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  GetCryptoWalletBalanceResponse._() : super();
  factory GetCryptoWalletBalanceResponse({
    $core.double? balance,
    $core.String? currency,
    $36.Timestamp? lastUpdated,
    $core.String? network,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory GetCryptoWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoWalletBalanceResponse clone() => GetCryptoWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoWalletBalanceResponse copyWith(void Function(GetCryptoWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetCryptoWalletBalanceResponse)) as GetCryptoWalletBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCryptoWalletBalanceResponse create() => GetCryptoWalletBalanceResponse._();
  GetCryptoWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoWalletBalanceResponse> createRepeated() => $pb.PbList<GetCryptoWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoWalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoWalletBalanceResponse>(create);
  static GetCryptoWalletBalanceResponse? _defaultInstance;

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
  $36.Timestamp get lastUpdated => $_getN(2);
  @$pb.TagNumber(3)
  set lastUpdated($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastUpdated() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastUpdated() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureLastUpdated() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get network => $_getSZ(3);
  @$pb.TagNumber(4)
  set network($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNetwork() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetwork() => clearField(4);
}

class ValidateCryptoWalletRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateCryptoWalletRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletAddress')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  ValidateCryptoWalletRequest._() : super();
  factory ValidateCryptoWalletRequest({
    $core.String? walletAddress,
    $core.String? currency,
    $core.String? network,
  }) {
    final _result = create();
    if (walletAddress != null) {
      _result.walletAddress = walletAddress;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory ValidateCryptoWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateCryptoWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateCryptoWalletRequest clone() => ValidateCryptoWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateCryptoWalletRequest copyWith(void Function(ValidateCryptoWalletRequest) updates) => super.copyWith((message) => updates(message as ValidateCryptoWalletRequest)) as ValidateCryptoWalletRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateCryptoWalletRequest create() => ValidateCryptoWalletRequest._();
  ValidateCryptoWalletRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateCryptoWalletRequest> createRepeated() => $pb.PbList<ValidateCryptoWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateCryptoWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateCryptoWalletRequest>(create);
  static ValidateCryptoWalletRequest? _defaultInstance;

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

class ValidateCryptoWalletResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateCryptoWalletResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationMessage')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isContract')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletType')
    ..hasRequiredFields = false
  ;

  ValidateCryptoWalletResponse._() : super();
  factory ValidateCryptoWalletResponse({
    $core.bool? isValid,
    $core.String? validationMessage,
    $core.bool? isContract,
    $core.String? walletType,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (validationMessage != null) {
      _result.validationMessage = validationMessage;
    }
    if (isContract != null) {
      _result.isContract = isContract;
    }
    if (walletType != null) {
      _result.walletType = walletType;
    }
    return _result;
  }
  factory ValidateCryptoWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateCryptoWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateCryptoWalletResponse clone() => ValidateCryptoWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateCryptoWalletResponse copyWith(void Function(ValidateCryptoWalletResponse) updates) => super.copyWith((message) => updates(message as ValidateCryptoWalletResponse)) as ValidateCryptoWalletResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateCryptoWalletResponse create() => ValidateCryptoWalletResponse._();
  ValidateCryptoWalletResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateCryptoWalletResponse> createRepeated() => $pb.PbList<ValidateCryptoWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateCryptoWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateCryptoWalletResponse>(create);
  static ValidateCryptoWalletResponse? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoInvoicePaymentStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionHash')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  GetCryptoInvoicePaymentStatusRequest._() : super();
  factory GetCryptoInvoicePaymentStatusRequest({
    $core.String? transactionHash,
    $core.String? network,
  }) {
    final _result = create();
    if (transactionHash != null) {
      _result.transactionHash = transactionHash;
    }
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory GetCryptoInvoicePaymentStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoInvoicePaymentStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusRequest clone() => GetCryptoInvoicePaymentStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusRequest copyWith(void Function(GetCryptoInvoicePaymentStatusRequest) updates) => super.copyWith((message) => updates(message as GetCryptoInvoicePaymentStatusRequest)) as GetCryptoInvoicePaymentStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoInvoicePaymentStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmations', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredConfirmations', $pb.PbFieldType.O3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetCryptoInvoicePaymentStatusResponse._() : super();
  factory GetCryptoInvoicePaymentStatusResponse({
    $core.String? status,
    $core.int? confirmations,
    $core.int? requiredConfirmations,
    $core.double? amount,
    $core.String? currency,
    $36.Timestamp? timestamp,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (confirmations != null) {
      _result.confirmations = confirmations;
    }
    if (requiredConfirmations != null) {
      _result.requiredConfirmations = requiredConfirmations;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory GetCryptoInvoicePaymentStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoInvoicePaymentStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusResponse clone() => GetCryptoInvoicePaymentStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoInvoicePaymentStatusResponse copyWith(void Function(GetCryptoInvoicePaymentStatusResponse) updates) => super.copyWith((message) => updates(message as GetCryptoInvoicePaymentStatusResponse)) as GetCryptoInvoicePaymentStatusResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get timestamp => $_getN(5);
  @$pb.TagNumber(6)
  set timestamp($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureTimestamp() => $_ensure(5);
}

class RequestInvoicePaymentExtensionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestInvoicePaymentExtensionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDueDate', subBuilder: $36.Timestamp.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'justification')
    ..hasRequiredFields = false
  ;

  RequestInvoicePaymentExtensionRequest._() : super();
  factory RequestInvoicePaymentExtensionRequest({
    $core.String? invoiceId,
    $36.Timestamp? newDueDate,
    $core.String? reason,
    $core.String? justification,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (newDueDate != null) {
      _result.newDueDate = newDueDate;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (justification != null) {
      _result.justification = justification;
    }
    return _result;
  }
  factory RequestInvoicePaymentExtensionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInvoicePaymentExtensionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionRequest clone() => RequestInvoicePaymentExtensionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionRequest copyWith(void Function(RequestInvoicePaymentExtensionRequest) updates) => super.copyWith((message) => updates(message as RequestInvoicePaymentExtensionRequest)) as RequestInvoicePaymentExtensionRequest; // ignore: deprecated_member_use
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
  $36.Timestamp get newDueDate => $_getN(1);
  @$pb.TagNumber(2)
  set newDueDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewDueDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewDueDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureNewDueDate() => $_ensure(1);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestInvoicePaymentExtensionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentExtensionRequest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extensionRequest', subBuilder: PaymentExtensionRequest.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestId')
    ..hasRequiredFields = false
  ;

  RequestInvoicePaymentExtensionResponse._() : super();
  factory RequestInvoicePaymentExtensionResponse({
    PaymentExtensionRequest? extensionRequest,
    $core.bool? success,
    $core.String? message,
    $core.String? requestId,
  }) {
    final _result = create();
    if (extensionRequest != null) {
      _result.extensionRequest = extensionRequest;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (requestId != null) {
      _result.requestId = requestId;
    }
    return _result;
  }
  factory RequestInvoicePaymentExtensionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInvoicePaymentExtensionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionResponse clone() => RequestInvoicePaymentExtensionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInvoicePaymentExtensionResponse copyWith(void Function(RequestInvoicePaymentExtensionResponse) updates) => super.copyWith((message) => updates(message as RequestInvoicePaymentExtensionResponse)) as RequestInvoicePaymentExtensionResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApproveInvoicePaymentExtensionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approved')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvalReason')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ApproveInvoicePaymentExtensionRequest._() : super();
  factory ApproveInvoicePaymentExtensionRequest({
    $core.String? requestId,
    $core.bool? approved,
    $core.String? approvalReason,
    $36.Timestamp? approvedDate,
  }) {
    final _result = create();
    if (requestId != null) {
      _result.requestId = requestId;
    }
    if (approved != null) {
      _result.approved = approved;
    }
    if (approvalReason != null) {
      _result.approvalReason = approvalReason;
    }
    if (approvedDate != null) {
      _result.approvedDate = approvedDate;
    }
    return _result;
  }
  factory ApproveInvoicePaymentExtensionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApproveInvoicePaymentExtensionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionRequest clone() => ApproveInvoicePaymentExtensionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionRequest copyWith(void Function(ApproveInvoicePaymentExtensionRequest) updates) => super.copyWith((message) => updates(message as ApproveInvoicePaymentExtensionRequest)) as ApproveInvoicePaymentExtensionRequest; // ignore: deprecated_member_use
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
  $36.Timestamp get approvedDate => $_getN(3);
  @$pb.TagNumber(4)
  set approvedDate($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasApprovedDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearApprovedDate() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureApprovedDate() => $_ensure(3);
}

class ApproveInvoicePaymentExtensionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApproveInvoicePaymentExtensionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PaymentExtensionRequest>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedRequest', subBuilder: PaymentExtensionRequest.create)
    ..hasRequiredFields = false
  ;

  ApproveInvoicePaymentExtensionResponse._() : super();
  factory ApproveInvoicePaymentExtensionResponse({
    $core.bool? success,
    $core.String? message,
    PaymentExtensionRequest? updatedRequest,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (updatedRequest != null) {
      _result.updatedRequest = updatedRequest;
    }
    return _result;
  }
  factory ApproveInvoicePaymentExtensionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApproveInvoicePaymentExtensionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionResponse clone() => ApproveInvoicePaymentExtensionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApproveInvoicePaymentExtensionResponse copyWith(void Function(ApproveInvoicePaymentExtensionResponse) updates) => super.copyWith((message) => updates(message as ApproveInvoicePaymentExtensionResponse)) as ApproveInvoicePaymentExtensionResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisputeInvoicePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evidenceFiles')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disputedAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DisputeInvoicePaymentRequest._() : super();
  factory DisputeInvoicePaymentRequest({
    $core.String? transactionId,
    $core.String? reason,
    $core.String? description,
    $core.Iterable<$core.String>? evidenceFiles,
    $core.double? disputedAmount,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (description != null) {
      _result.description = description;
    }
    if (evidenceFiles != null) {
      _result.evidenceFiles.addAll(evidenceFiles);
    }
    if (disputedAmount != null) {
      _result.disputedAmount = disputedAmount;
    }
    return _result;
  }
  factory DisputeInvoicePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisputeInvoicePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentRequest clone() => DisputeInvoicePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentRequest copyWith(void Function(DisputeInvoicePaymentRequest) updates) => super.copyWith((message) => updates(message as DisputeInvoicePaymentRequest)) as DisputeInvoicePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisputeInvoicePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentDispute>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dispute', subBuilder: PaymentDispute.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disputeId')
    ..hasRequiredFields = false
  ;

  DisputeInvoicePaymentResponse._() : super();
  factory DisputeInvoicePaymentResponse({
    PaymentDispute? dispute,
    $core.bool? success,
    $core.String? message,
    $core.String? disputeId,
  }) {
    final _result = create();
    if (dispute != null) {
      _result.dispute = dispute;
    }
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (disputeId != null) {
      _result.disputeId = disputeId;
    }
    return _result;
  }
  factory DisputeInvoicePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisputeInvoicePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentResponse clone() => DisputeInvoicePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisputeInvoicePaymentResponse copyWith(void Function(DisputeInvoicePaymentResponse) updates) => super.copyWith((message) => updates(message as DisputeInvoicePaymentResponse)) as DisputeInvoicePaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveInvoicePaymentDisputeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disputeId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolution')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolutionNotes')
    ..hasRequiredFields = false
  ;

  ResolveInvoicePaymentDisputeRequest._() : super();
  factory ResolveInvoicePaymentDisputeRequest({
    $core.String? disputeId,
    $core.String? resolution,
    $core.double? refundAmount,
    $core.String? resolutionNotes,
  }) {
    final _result = create();
    if (disputeId != null) {
      _result.disputeId = disputeId;
    }
    if (resolution != null) {
      _result.resolution = resolution;
    }
    if (refundAmount != null) {
      _result.refundAmount = refundAmount;
    }
    if (resolutionNotes != null) {
      _result.resolutionNotes = resolutionNotes;
    }
    return _result;
  }
  factory ResolveInvoicePaymentDisputeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveInvoicePaymentDisputeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeRequest clone() => ResolveInvoicePaymentDisputeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeRequest copyWith(void Function(ResolveInvoicePaymentDisputeRequest) updates) => super.copyWith((message) => updates(message as ResolveInvoicePaymentDisputeRequest)) as ResolveInvoicePaymentDisputeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveInvoicePaymentDisputeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PaymentDispute>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedDispute', subBuilder: PaymentDispute.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundTransactionId')
    ..hasRequiredFields = false
  ;

  ResolveInvoicePaymentDisputeResponse._() : super();
  factory ResolveInvoicePaymentDisputeResponse({
    $core.bool? success,
    $core.String? message,
    PaymentDispute? updatedDispute,
    $core.String? refundTransactionId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (updatedDispute != null) {
      _result.updatedDispute = updatedDispute;
    }
    if (refundTransactionId != null) {
      _result.refundTransactionId = refundTransactionId;
    }
    return _result;
  }
  factory ResolveInvoicePaymentDisputeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveInvoicePaymentDisputeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeResponse clone() => ResolveInvoicePaymentDisputeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveInvoicePaymentDisputeResponse copyWith(void Function(ResolveInvoicePaymentDisputeResponse) updates) => super.copyWith((message) => updates(message as ResolveInvoicePaymentDisputeResponse)) as ResolveInvoicePaymentDisputeResponse; // ignore: deprecated_member_use
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

class GetInvoicePaymentHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageToken')
    ..e<$37.InvoicePaymentStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: $37.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $37.InvoicePaymentStatus.valueOf, enumValues: $37.InvoicePaymentStatus.values)
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentHistoryRequest._() : super();
  factory GetInvoicePaymentHistoryRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
    $core.int? pageSize,
    $core.String? pageToken,
    $37.InvoicePaymentStatus? statusFilter,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (pageToken != null) {
      _result.pageToken = pageToken;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    return _result;
  }
  factory GetInvoicePaymentHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryRequest clone() => GetInvoicePaymentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryRequest copyWith(void Function(GetInvoicePaymentHistoryRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentHistoryRequest)) as GetInvoicePaymentHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentHistoryRequest create() => GetInvoicePaymentHistoryRequest._();
  GetInvoicePaymentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentHistoryRequest> createRepeated() => $pb.PbList<GetInvoicePaymentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentHistoryRequest>(create);
  static GetInvoicePaymentHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);

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
  $37.InvoicePaymentStatus get statusFilter => $_getN(4);
  @$pb.TagNumber(5)
  set statusFilter($37.InvoicePaymentStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatusFilter() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatusFilter() => clearField(5);
}

class GetInvoicePaymentHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvoicePaymentTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: InvoicePaymentTransaction.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentHistoryResponse._() : super();
  factory GetInvoicePaymentHistoryResponse({
    $core.Iterable<InvoicePaymentTransaction>? transactions,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (nextPageToken != null) {
      _result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetInvoicePaymentHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryResponse clone() => GetInvoicePaymentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentHistoryResponse copyWith(void Function(GetInvoicePaymentHistoryResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentHistoryResponse)) as GetInvoicePaymentHistoryResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$36.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentStatisticsRequest._() : super();
  factory GetInvoicePaymentStatisticsRequest({
    $36.Timestamp? startDate,
    $36.Timestamp? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetInvoicePaymentStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsRequest clone() => GetInvoicePaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsRequest copyWith(void Function(GetInvoicePaymentStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatisticsRequest)) as GetInvoicePaymentStatisticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatisticsRequest create() => GetInvoicePaymentStatisticsRequest._();
  GetInvoicePaymentStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentStatisticsRequest> createRepeated() => $pb.PbList<GetInvoicePaymentStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentStatisticsRequest>(create);
  static GetInvoicePaymentStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $36.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($36.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $36.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $36.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($36.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $36.Timestamp ensureEndDate() => $_ensure(1);
}

class GetInvoicePaymentStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successfulPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalFees', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averagePaymentAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethodUsage', entryClassName: 'GetInvoicePaymentStatisticsResponse.PaymentMethodUsageEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OU6, packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentStatisticsResponse._() : super();
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
    final _result = create();
    if (totalPayments != null) {
      _result.totalPayments = totalPayments;
    }
    if (successfulPayments != null) {
      _result.successfulPayments = successfulPayments;
    }
    if (failedPayments != null) {
      _result.failedPayments = failedPayments;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (totalFees != null) {
      _result.totalFees = totalFees;
    }
    if (averagePaymentAmount != null) {
      _result.averagePaymentAmount = averagePaymentAmount;
    }
    if (paymentMethodUsage != null) {
      _result.paymentMethodUsage.addAll(paymentMethodUsage);
    }
    if (successRate != null) {
      _result.successRate = successRate;
    }
    return _result;
  }
  factory GetInvoicePaymentStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsResponse clone() => GetInvoicePaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentStatisticsResponse copyWith(void Function(GetInvoicePaymentStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentStatisticsResponse)) as GetInvoicePaymentStatisticsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecentInvoicePaymentTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetRecentInvoicePaymentTransactionsRequest._() : super();
  factory GetRecentInvoicePaymentTransactionsRequest({
    $core.int? limit,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetRecentInvoicePaymentTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentInvoicePaymentTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsRequest clone() => GetRecentInvoicePaymentTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsRequest copyWith(void Function(GetRecentInvoicePaymentTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetRecentInvoicePaymentTransactionsRequest)) as GetRecentInvoicePaymentTransactionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecentInvoicePaymentTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvoicePaymentTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: InvoicePaymentTransaction.create)
    ..hasRequiredFields = false
  ;

  GetRecentInvoicePaymentTransactionsResponse._() : super();
  factory GetRecentInvoicePaymentTransactionsResponse({
    $core.Iterable<InvoicePaymentTransaction>? transactions,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    return _result;
  }
  factory GetRecentInvoicePaymentTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentInvoicePaymentTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsResponse clone() => GetRecentInvoicePaymentTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentInvoicePaymentTransactionsResponse copyWith(void Function(GetRecentInvoicePaymentTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetRecentInvoicePaymentTransactionsResponse)) as GetRecentInvoicePaymentTransactionsResponse; // ignore: deprecated_member_use
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

class GenerateInvoicePaymentReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateInvoicePaymentReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'templateId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeInvoiceDetails')
    ..hasRequiredFields = false
  ;

  GenerateInvoicePaymentReceiptRequest._() : super();
  factory GenerateInvoicePaymentReceiptRequest({
    $core.String? transactionId,
    $core.String? templateId,
    $core.bool? includeInvoiceDetails,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (templateId != null) {
      _result.templateId = templateId;
    }
    if (includeInvoiceDetails != null) {
      _result.includeInvoiceDetails = includeInvoiceDetails;
    }
    return _result;
  }
  factory GenerateInvoicePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateInvoicePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptRequest clone() => GenerateInvoicePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptRequest copyWith(void Function(GenerateInvoicePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GenerateInvoicePaymentReceiptRequest)) as GenerateInvoicePaymentReceiptRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenerateInvoicePaymentReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptData', $pb.PbFieldType.OY)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  GenerateInvoicePaymentReceiptResponse._() : super();
  factory GenerateInvoicePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.List<$core.int>? receiptData,
    $core.String? message,
    $core.bool? success,
  }) {
    final _result = create();
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (receiptData != null) {
      _result.receiptData = receiptData;
    }
    if (message != null) {
      _result.message = message;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory GenerateInvoicePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateInvoicePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptResponse clone() => GenerateInvoicePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateInvoicePaymentReceiptResponse copyWith(void Function(GenerateInvoicePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GenerateInvoicePaymentReceiptResponse)) as GenerateInvoicePaymentReceiptResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmailInvoicePaymentReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customMessage')
    ..hasRequiredFields = false
  ;

  EmailInvoicePaymentReceiptRequest._() : super();
  factory EmailInvoicePaymentReceiptRequest({
    $core.String? transactionId,
    $core.String? recipientEmail,
    $core.String? customMessage,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (customMessage != null) {
      _result.customMessage = customMessage;
    }
    return _result;
  }
  factory EmailInvoicePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailInvoicePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptRequest clone() => EmailInvoicePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptRequest copyWith(void Function(EmailInvoicePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as EmailInvoicePaymentReceiptRequest)) as EmailInvoicePaymentReceiptRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmailInvoicePaymentReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trackingId')
    ..hasRequiredFields = false
  ;

  EmailInvoicePaymentReceiptResponse._() : super();
  factory EmailInvoicePaymentReceiptResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? trackingId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (trackingId != null) {
      _result.trackingId = trackingId;
    }
    return _result;
  }
  factory EmailInvoicePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailInvoicePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptResponse clone() => EmailInvoicePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailInvoicePaymentReceiptResponse copyWith(void Function(EmailInvoicePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as EmailInvoicePaymentReceiptResponse)) as EmailInvoicePaymentReceiptResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentReceiptRequest._() : super();
  factory GetInvoicePaymentReceiptRequest({
    $core.String? transactionId,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory GetInvoicePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptRequest clone() => GetInvoicePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptRequest copyWith(void Function(GetInvoicePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentReceiptRequest)) as GetInvoicePaymentReceiptRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicePaymentReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptData', $pb.PbFieldType.OY)
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetInvoicePaymentReceiptResponse._() : super();
  factory GetInvoicePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.List<$core.int>? receiptData,
    $36.Timestamp? generatedAt,
  }) {
    final _result = create();
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (receiptData != null) {
      _result.receiptData = receiptData;
    }
    if (generatedAt != null) {
      _result.generatedAt = generatedAt;
    }
    return _result;
  }
  factory GetInvoicePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptResponse clone() => GetInvoicePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentReceiptResponse copyWith(void Function(GetInvoicePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentReceiptResponse)) as GetInvoicePaymentReceiptResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get generatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set generatedAt($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneratedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneratedAt() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureGeneratedAt() => $_ensure(2);
}

