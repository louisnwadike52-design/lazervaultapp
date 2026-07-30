///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'financial-products.pb.dart' as $0;
export 'financial-products.pb.dart';

class FinancialProductsServiceClient extends $grpc.Client {
  static final _$createGroupAccount = $grpc.ClientMethod<
          $0.CreateGroupAccountRequest, $0.CreateGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CreateGroupAccount',
      ($0.CreateGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateGroupAccountResponse.fromBuffer(value));
  static final _$getGroupAccounts = $grpc.ClientMethod<
          $0.GetGroupAccountsRequest, $0.GetGroupAccountsResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccounts',
      ($0.GetGroupAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetGroupAccountsResponse.fromBuffer(value));
  static final _$getGroupAccount =
      $grpc.ClientMethod<$0.GetGroupAccountRequest, $0.GetGroupAccountResponse>(
          '/financialproducts.FinancialProductsService/GetGroupAccount',
          ($0.GetGroupAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetGroupAccountResponse.fromBuffer(value));
  static final _$addGroupMember =
      $grpc.ClientMethod<$0.AddGroupMemberRequest, $0.AddGroupMemberResponse>(
          '/financialproducts.FinancialProductsService/AddGroupMember',
          ($0.AddGroupMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddGroupMemberResponse.fromBuffer(value));
  static final _$removeGroupMember = $grpc.ClientMethod<
          $0.RemoveGroupMemberRequest, $0.RemoveGroupMemberResponse>(
      '/financialproducts.FinancialProductsService/RemoveGroupMember',
      ($0.RemoveGroupMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RemoveGroupMemberResponse.fromBuffer(value));
  static final _$contributeToGroup = $grpc.ClientMethod<
          $0.ContributeToGroupRequest, $0.ContributeToGroupResponse>(
      '/financialproducts.FinancialProductsService/ContributeToGroup',
      ($0.ContributeToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ContributeToGroupResponse.fromBuffer(value));
  static final _$withdrawFromGroup = $grpc.ClientMethod<
          $0.WithdrawFromGroupRequest, $0.WithdrawFromGroupResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromGroup',
      ($0.WithdrawFromGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.WithdrawFromGroupResponse.fromBuffer(value));
  static final _$closeGroupAccount = $grpc.ClientMethod<
          $0.CloseGroupAccountRequest, $0.CloseGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CloseGroupAccount',
      ($0.CloseGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CloseGroupAccountResponse.fromBuffer(value));
  static final _$buyInsurance =
      $grpc.ClientMethod<$0.BuyInsuranceRequest, $0.BuyInsuranceResponse>(
          '/financialproducts.FinancialProductsService/BuyInsurance',
          ($0.BuyInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePolicies = $grpc.ClientMethod<
          $0.GetInsurancePoliciesRequest, $0.GetInsurancePoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicies',
      ($0.GetInsurancePoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePoliciesResponse.fromBuffer(value));
  static final _$getInsurancePolicy = $grpc.ClientMethod<
          $0.GetInsurancePolicyRequest, $0.GetInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicy',
      ($0.GetInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePolicyResponse.fromBuffer(value));
  static final _$makeInsuranceClaim = $grpc.ClientMethod<
          $0.MakeInsuranceClaimRequest, $0.MakeInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/MakeInsuranceClaim',
      ($0.MakeInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MakeInsuranceClaimResponse.fromBuffer(value));
  static final _$cancelInsurance =
      $grpc.ClientMethod<$0.CancelInsuranceRequest, $0.CancelInsuranceResponse>(
          '/financialproducts.FinancialProductsService/CancelInsurance',
          ($0.CancelInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePlans = $grpc.ClientMethod<
          $0.GetInsurancePlansRequest, $0.GetInsurancePlansResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlans',
      ($0.GetInsurancePlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePlansResponse.fromBuffer(value));
  static final _$getInsuranceMarketplaceProducts = $grpc.ClientMethod<
          $0.GetInsuranceMarketplaceProductsRequest,
          $0.GetInsuranceMarketplaceProductsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceMarketplaceProducts',
      ($0.GetInsuranceMarketplaceProductsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceMarketplaceProductsResponse.fromBuffer(value));
  static final _$getInsuranceMarketplaceCategories = $grpc.ClientMethod<
          $0.GetInsuranceMarketplaceCategoriesRequest,
          $0.GetInsuranceMarketplaceCategoriesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceMarketplaceCategories',
      ($0.GetInsuranceMarketplaceCategoriesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceMarketplaceCategoriesResponse.fromBuffer(value));
  static final _$getInsuranceQuote = $grpc.ClientMethod<
          $0.GetInsuranceQuoteRequest, $0.GetInsuranceQuoteResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceQuote',
      ($0.GetInsuranceQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceQuoteResponse.fromBuffer(value));
  static final _$purchaseMarketplaceInsurance = $grpc.ClientMethod<
          $0.PurchaseMarketplaceInsuranceRequest,
          $0.PurchaseMarketplaceInsuranceResponse>(
      '/financialproducts.FinancialProductsService/PurchaseMarketplaceInsurance',
      ($0.PurchaseMarketplaceInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PurchaseMarketplaceInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePurchaseStatus = $grpc.ClientMethod<
          $0.GetInsurancePurchaseStatusRequest,
          $0.GetInsurancePurchaseStatusResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePurchaseStatus',
      ($0.GetInsurancePurchaseStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePurchaseStatusResponse.fromBuffer(value));
  static final _$uploadInsuranceDocument = $grpc.ClientMethod<
          $0.UploadInsuranceDocumentRequest,
          $0.UploadInsuranceDocumentResponse>(
      '/financialproducts.FinancialProductsService/UploadInsuranceDocument',
      ($0.UploadInsuranceDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UploadInsuranceDocumentResponse.fromBuffer(value));
  static final _$getInsuranceDocumentUploadURL = $grpc.ClientMethod<
          $0.GetInsuranceDocumentUploadURLRequest,
          $0.GetInsuranceDocumentUploadURLResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceDocumentUploadURL',
      ($0.GetInsuranceDocumentUploadURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceDocumentUploadURLResponse.fromBuffer(value));
  static final _$getInsuranceAuxiliaryData = $grpc.ClientMethod<
          $0.GetInsuranceAuxiliaryDataRequest,
          $0.GetInsuranceAuxiliaryDataResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceAuxiliaryData',
      ($0.GetInsuranceAuxiliaryDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceAuxiliaryDataResponse.fromBuffer(value));
  static final _$getInsuranceProductSchema = $grpc.ClientMethod<
          $0.GetInsuranceProductSchemaRequest,
          $0.GetInsuranceProductSchemaResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceProductSchema',
      ($0.GetInsuranceProductSchemaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceProductSchemaResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<
          $0.GetInsurancePaymentsRequest, $0.GetInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePayments',
      ($0.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserInsurancePayments = $grpc.ClientMethod<
          $0.GetUserInsurancePaymentsRequest,
          $0.GetUserInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsurancePayments',
      ($0.GetUserInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserInsurancePaymentsResponse.fromBuffer(value));
  static final _$createInsurancePayment = $grpc.ClientMethod<
          $0.CreateInsurancePaymentRequest, $0.CreateInsurancePaymentResponse>(
      '/financialproducts.FinancialProductsService/CreateInsurancePayment',
      ($0.CreateInsurancePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateInsurancePaymentResponse.fromBuffer(value));
  static final _$processInsurancePayment = $grpc.ClientMethod<
          $0.ProcessInsurancePaymentRequest,
          $0.ProcessInsurancePaymentResponse>(
      '/financialproducts.FinancialProductsService/ProcessInsurancePayment',
      ($0.ProcessInsurancePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ProcessInsurancePaymentResponse.fromBuffer(value));
  static final _$getInsurancePaymentById = $grpc.ClientMethod<
          $0.GetInsurancePaymentByIdRequest,
          $0.GetInsurancePaymentByIdResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePaymentById',
      ($0.GetInsurancePaymentByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePaymentByIdResponse.fromBuffer(value));
  static final _$getOverdueInsurancePayments = $grpc.ClientMethod<
          $0.GetOverdueInsurancePaymentsRequest,
          $0.GetOverdueInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetOverdueInsurancePayments',
      ($0.GetOverdueInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetOverdueInsurancePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<
          $0.GetInsuranceClaimsRequest, $0.GetInsuranceClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceClaims',
      ($0.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserInsuranceClaims = $grpc.ClientMethod<
          $0.GetUserInsuranceClaimsRequest, $0.GetUserInsuranceClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsuranceClaims',
      ($0.GetUserInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserInsuranceClaimsResponse.fromBuffer(value));
  static final _$updateInsuranceClaim = $grpc.ClientMethod<
          $0.UpdateInsuranceClaimRequest, $0.UpdateInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsuranceClaim',
      ($0.UpdateInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInsuranceClaimResponse.fromBuffer(value));
  static final _$getInsuranceClaimById = $grpc.ClientMethod<
          $0.GetInsuranceClaimByIdRequest, $0.GetInsuranceClaimByIdResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceClaimById',
      ($0.GetInsuranceClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceClaimByIdResponse.fromBuffer(value));
  static final _$updateInsurancePolicy = $grpc.ClientMethod<
          $0.UpdateInsurancePolicyRequest, $0.UpdateInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsurancePolicy',
      ($0.UpdateInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInsurancePolicyResponse.fromBuffer(value));
  static final _$generateInsuranceReceipt = $grpc.ClientMethod<
          $0.GenerateInsuranceReceiptRequest,
          $0.GenerateInsuranceReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateInsuranceReceipt',
      ($0.GenerateInsuranceReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GenerateInsuranceReceiptResponse.fromBuffer(value));
  static final _$getUserInsuranceReceipts = $grpc.ClientMethod<
          $0.GetUserInsuranceReceiptsRequest,
          $0.GetUserInsuranceReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsuranceReceipts',
      ($0.GetUserInsuranceReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserInsuranceReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<
          $0.GetInsuranceStatisticsRequest, $0.GetInsuranceStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceStatistics',
      ($0.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getInsurancePaymentStatistics = $grpc.ClientMethod<
          $0.GetInsurancePaymentStatisticsRequest,
          $0.GetInsurancePaymentStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePaymentStatistics',
      ($0.GetInsurancePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePaymentStatisticsResponse.fromBuffer(value));
  static final _$getMyCoverCustomers = $grpc.ClientMethod<
          $0.GetMyCoverCustomersRequest, $0.GetMyCoverCustomersResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomers',
      ($0.GetMyCoverCustomersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverCustomersResponse.fromBuffer(value));
  static final _$getMyCoverCustomerById = $grpc.ClientMethod<
          $0.GetMyCoverCustomerByIdRequest, $0.GetMyCoverCustomerByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerById',
      ($0.GetMyCoverCustomerByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverCustomerByIdResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPolicies = $grpc.ClientMethod<
          $0.GetMyCoverCustomerPoliciesRequest,
          $0.GetMyCoverCustomerPoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerPolicies',
      ($0.GetMyCoverCustomerPoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverCustomerPoliciesResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPurchases = $grpc.ClientMethod<
          $0.GetMyCoverCustomerPurchasesRequest,
          $0.GetMyCoverCustomerPurchasesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerPurchases',
      ($0.GetMyCoverCustomerPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverCustomerPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchases = $grpc.ClientMethod<
          $0.GetMyCoverPurchasesRequest, $0.GetMyCoverPurchasesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPurchases',
      ($0.GetMyCoverPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchaseById = $grpc.ClientMethod<
          $0.GetMyCoverPurchaseByIdRequest, $0.GetMyCoverPurchaseByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPurchaseById',
      ($0.GetMyCoverPurchaseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverPurchaseByIdResponse.fromBuffer(value));
  static final _$getMyCoverClaims = $grpc.ClientMethod<
          $0.GetMyCoverClaimsRequest, $0.GetMyCoverClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverClaims',
      ($0.GetMyCoverClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverClaimsResponse.fromBuffer(value));
  static final _$getMyCoverPolicies = $grpc.ClientMethod<
          $0.GetMyCoverPoliciesRequest, $0.GetMyCoverPoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPolicies',
      ($0.GetMyCoverPoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverPoliciesResponse.fromBuffer(value));
  static final _$getMyCoverPolicyById = $grpc.ClientMethod<
          $0.GetMyCoverPolicyByIdRequest, $0.GetMyCoverPolicyByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPolicyById',
      ($0.GetMyCoverPolicyByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverPolicyByIdResponse.fromBuffer(value));
  static final _$getMyCoverClaimById = $grpc.ClientMethod<
          $0.GetMyCoverClaimByIdRequest, $0.GetMyCoverClaimByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverClaimById',
      ($0.GetMyCoverClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverClaimByIdResponse.fromBuffer(value));
  static final _$fileCreditLifeClaim = $grpc.ClientMethod<
          $0.FileCreditLifeClaimRequest, $0.FileCreditLifeClaimResponse>(
      '/financialproducts.FinancialProductsService/FileCreditLifeClaim',
      ($0.FileCreditLifeClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.FileCreditLifeClaimResponse.fromBuffer(value));
  static final _$getInsuranceStates = $grpc.ClientMethod<
          $0.GetInsuranceStatesRequest, $0.GetInsuranceStatesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceStates',
      ($0.GetInsuranceStatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceStatesResponse.fromBuffer(value));
  static final _$getInsuranceVehicleMakes = $grpc.ClientMethod<
          $0.GetInsuranceVehicleMakesRequest,
          $0.GetInsuranceVehicleMakesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceVehicleMakes',
      ($0.GetInsuranceVehicleMakesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceVehicleMakesResponse.fromBuffer(value));
  static final _$getMyCoverNotificationPreferences = $grpc.ClientMethod<
          $0.GetMyCoverNotificationPreferencesRequest,
          $0.GetMyCoverNotificationPreferencesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverNotificationPreferences',
      ($0.GetMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$updateMyCoverNotificationPreferences = $grpc.ClientMethod<
          $0.UpdateMyCoverNotificationPreferencesRequest,
          $0.UpdateMyCoverNotificationPreferencesResponse>(
      '/financialproducts.FinancialProductsService/UpdateMyCoverNotificationPreferences',
      ($0.UpdateMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$getMyCoverWalletBalance = $grpc.ClientMethod<
          $0.GetMyCoverWalletBalanceRequest,
          $0.GetMyCoverWalletBalanceResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverWalletBalance',
      ($0.GetMyCoverWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetMyCoverWalletBalanceResponse.fromBuffer(value));
  static final _$requestInsuranceRefund = $grpc.ClientMethod<
          $0.RequestInsuranceRefundRequest, $0.RequestInsuranceRefundResponse>(
      '/financialproducts.FinancialProductsService/RequestInsuranceRefund',
      ($0.RequestInsuranceRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestInsuranceRefundResponse.fromBuffer(value));
  static final _$getInsuranceRefundStatus = $grpc.ClientMethod<
          $0.GetInsuranceRefundStatusRequest,
          $0.GetInsuranceRefundStatusResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceRefundStatus',
      ($0.GetInsuranceRefundStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceRefundStatusResponse.fromBuffer(value));
  static final _$getInsuranceReconciliationOverview = $grpc.ClientMethod<
          $0.GetInsuranceReconciliationOverviewRequest,
          $0.GetInsuranceReconciliationOverviewResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceReconciliationOverview',
      ($0.GetInsuranceReconciliationOverviewRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceReconciliationOverviewResponse.fromBuffer(value));
  static final _$getOrphanedInsuranceTransactions = $grpc.ClientMethod<
          $0.GetOrphanedInsuranceTransactionsRequest,
          $0.GetOrphanedInsuranceTransactionsResponse>(
      '/financialproducts.FinancialProductsService/GetOrphanedInsuranceTransactions',
      ($0.GetOrphanedInsuranceTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetOrphanedInsuranceTransactionsResponse.fromBuffer(value));
  static final _$manualReconcilePurchase = $grpc.ClientMethod<
          $0.ManualReconcilePurchaseRequest,
          $0.ManualReconcilePurchaseResponse>(
      '/financialproducts.FinancialProductsService/ManualReconcilePurchase',
      ($0.ManualReconcilePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ManualReconcilePurchaseResponse.fromBuffer(value));
  static final _$adminTriggerRefund = $grpc.ClientMethod<
          $0.AdminTriggerRefundRequest, $0.AdminTriggerRefundResponse>(
      '/financialproducts.FinancialProductsService/AdminTriggerRefund',
      ($0.AdminTriggerRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminTriggerRefundResponse.fromBuffer(value));
  static final _$getInsuranceWebhookEvents = $grpc.ClientMethod<
          $0.GetInsuranceWebhookEventsRequest,
          $0.GetInsuranceWebhookEventsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceWebhookEvents',
      ($0.GetInsuranceWebhookEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceWebhookEventsResponse.fromBuffer(value));
  static final _$retryFailedWebhookEvent = $grpc.ClientMethod<
          $0.RetryFailedWebhookEventRequest,
          $0.RetryFailedWebhookEventResponse>(
      '/financialproducts.FinancialProductsService/RetryFailedWebhookEvent',
      ($0.RetryFailedWebhookEventRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RetryFailedWebhookEventResponse.fromBuffer(value));
  static final _$getFailedInsuranceTransactions = $grpc.ClientMethod<
          $0.GetFailedInsuranceTransactionsRequest,
          $0.GetFailedInsuranceTransactionsResponse>(
      '/financialproducts.FinancialProductsService/GetFailedInsuranceTransactions',
      ($0.GetFailedInsuranceTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetFailedInsuranceTransactionsResponse.fromBuffer(value));
  static final _$updateProductMargin = $grpc.ClientMethod<
          $0.UpdateProductMarginRequest, $0.UpdateProductMarginResponse>(
      '/financialproducts.FinancialProductsService/UpdateProductMargin',
      ($0.UpdateProductMarginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateProductMarginResponse.fromBuffer(value));
  static final _$getInsurancePlatformWallets = $grpc.ClientMethod<
          $0.GetInsurancePlatformWalletsRequest,
          $0.GetInsurancePlatformWalletsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlatformWallets',
      ($0.GetInsurancePlatformWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsurancePlatformWalletsResponse.fromBuffer(value));
  static final _$getInsuranceFeeConfig = $grpc.ClientMethod<
          $0.GetInsuranceFeeConfigRequest, $0.GetInsuranceFeeConfigResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceFeeConfig',
      ($0.GetInsuranceFeeConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInsuranceFeeConfigResponse.fromBuffer(value));
  static final _$updateInsuranceFeeConfig = $grpc.ClientMethod<
          $0.UpdateInsuranceFeeConfigRequest,
          $0.UpdateInsuranceFeeConfigResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsuranceFeeConfig',
      ($0.UpdateInsuranceFeeConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInsuranceFeeConfigResponse.fromBuffer(value));
  static final _$listInsuranceRollbacks = $grpc.ClientMethod<
          $0.ListInsuranceRollbacksRequest, $0.ListInsuranceRollbacksResponse>(
      '/financialproducts.FinancialProductsService/ListInsuranceRollbacks',
      ($0.ListInsuranceRollbacksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListInsuranceRollbacksResponse.fromBuffer(value));
  static final _$createCrowdfund =
      $grpc.ClientMethod<$0.CreateCrowdfundRequest, $0.CreateCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CreateCrowdfund',
          ($0.CreateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfunds =
      $grpc.ClientMethod<$0.GetCrowdfundsRequest, $0.GetCrowdfundsResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfunds',
          ($0.GetCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCrowdfundsResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfund',
          ($0.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCrowdfundResponse.fromBuffer(value));
  static final _$contributeToCrowdfund = $grpc.ClientMethod<
          $0.ContributeToCrowdfundRequest, $0.ContributeToCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ContributeToCrowdfund',
      ($0.ContributeToCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ContributeToCrowdfundResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<
          $0.WithdrawFromCrowdfundRequest, $0.WithdrawFromCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromCrowdfund',
      ($0.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundWithdrawalFeeQuote = $grpc.ClientMethod<
          $0.GetCrowdfundWithdrawalFeeQuoteRequest,
          $0.GetCrowdfundWithdrawalFeeQuoteResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundWithdrawalFeeQuote',
      ($0.GetCrowdfundWithdrawalFeeQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCrowdfundWithdrawalFeeQuoteResponse.fromBuffer(value));
  static final _$listCrowdfundCustomCategories = $grpc.ClientMethod<
          $0.ListCrowdfundCustomCategoriesRequest,
          $0.ListCrowdfundCustomCategoriesResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundCustomCategories',
      ($0.ListCrowdfundCustomCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListCrowdfundCustomCategoriesResponse.fromBuffer(value));
  static final _$addCrowdfundCustomCategory = $grpc.ClientMethod<
          $0.AddCrowdfundCustomCategoryRequest,
          $0.AddCrowdfundCustomCategoryResponse>(
      '/financialproducts.FinancialProductsService/AddCrowdfundCustomCategory',
      ($0.AddCrowdfundCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AddCrowdfundCustomCategoryResponse.fromBuffer(value));
  static final _$deleteCrowdfundCustomCategory = $grpc.ClientMethod<
          $0.DeleteCrowdfundCustomCategoryRequest,
          $0.DeleteCrowdfundCustomCategoryResponse>(
      '/financialproducts.FinancialProductsService/DeleteCrowdfundCustomCategory',
      ($0.DeleteCrowdfundCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteCrowdfundCustomCategoryResponse.fromBuffer(value));
  static final _$listCrowdfundWithdrawals = $grpc.ClientMethod<
          $0.ListCrowdfundWithdrawalsRequest,
          $0.ListCrowdfundWithdrawalsResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundWithdrawals',
      ($0.ListCrowdfundWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListCrowdfundWithdrawalsResponse.fromBuffer(value));
  static final _$closeCrowdfund =
      $grpc.ClientMethod<$0.CloseCrowdfundRequest, $0.CloseCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CloseCrowdfund',
          ($0.CloseCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CloseCrowdfundResponse.fromBuffer(value));
  static final _$cancelCrowdfund =
      $grpc.ClientMethod<$0.CancelCrowdfundRequest, $0.CancelCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CancelCrowdfund',
          ($0.CancelCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CancelCrowdfundResponse.fromBuffer(value));
  static final _$forceCompleteCrowdfund = $grpc.ClientMethod<
          $0.ForceCompleteCrowdfundRequest, $0.ForceCompleteCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ForceCompleteCrowdfund',
      ($0.ForceCompleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ForceCompleteCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfundRefunds = $grpc.ClientMethod<
          $0.ListCrowdfundRefundsRequest, $0.ListCrowdfundRefundsResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundRefunds',
      ($0.ListCrowdfundRefundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListCrowdfundRefundsResponse.fromBuffer(value));
  static final _$retryCrowdfundRefund = $grpc.ClientMethod<
          $0.RetryCrowdfundRefundRequest, $0.RetryCrowdfundRefundResponse>(
      '/financialproducts.FinancialProductsService/RetryCrowdfundRefund',
      ($0.RetryCrowdfundRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RetryCrowdfundRefundResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $0.GetCrowdfundStatisticsRequest, $0.GetCrowdfundStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundStatistics',
      ($0.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $0.SearchCrowdfundsRequest, $0.SearchCrowdfundsResponse>(
      '/financialproducts.FinancialProductsService/SearchCrowdfunds',
      ($0.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund =
      $grpc.ClientMethod<$0.UpdateCrowdfundRequest, $0.UpdateCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/UpdateCrowdfund',
          ($0.UpdateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund =
      $grpc.ClientMethod<$0.DeleteCrowdfundRequest, $0.DeleteCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/DeleteCrowdfund',
          ($0.DeleteCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $0.GetCrowdfundDonationsRequest, $0.GetCrowdfundDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundDonations',
      ($0.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $0.GetUserDonationsRequest, $0.GetUserDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetUserDonations',
      ($0.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $0.GenerateDonationReceiptRequest,
          $0.GenerateDonationReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateDonationReceipt',
      ($0.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $0.GetUserCrowdfundReceiptsRequest,
          $0.GetUserCrowdfundReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserCrowdfundReceipts',
      ($0.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<
          $0.ConnectNotificationChannelRequest,
          $0.ConnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/ConnectNotificationChannel',
      ($0.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<
          $0.DisconnectNotificationChannelRequest,
          $0.DisconnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/DisconnectNotificationChannel',
      ($0.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<
          $0.GetNotificationChannelsRequest,
          $0.GetNotificationChannelsResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationChannels',
      ($0.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<
          $0.UpdateNotificationChannelRequest,
          $0.UpdateNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/UpdateNotificationChannel',
      ($0.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<
          $0.TestNotificationChannelRequest,
          $0.TestNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/TestNotificationChannel',
      ($0.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<
          $0.GetTelegramBotInfoRequest, $0.GetTelegramBotInfoResponse>(
      '/financialproducts.FinancialProductsService/GetTelegramBotInfo',
      ($0.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<
          $0.VerifyTelegramChannelRequest, $0.VerifyTelegramChannelResponse>(
      '/financialproducts.FinancialProductsService/VerifyTelegramChannel',
      ($0.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<
          $0.GetNotificationHistoryRequest, $0.GetNotificationHistoryResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationHistory',
      ($0.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetNotificationHistoryResponse.fromBuffer(value));
  static final _$getCrowdfundLeaderboard = $grpc.ClientMethod<
          $0.GetCrowdfundLeaderboardRequest,
          $0.GetCrowdfundLeaderboardResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundLeaderboard',
      ($0.GetCrowdfundLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCrowdfundLeaderboardResponse.fromBuffer(value));
  static final _$createAutoSaveRule = $grpc.ClientMethod<
          $0.CreateAutoSaveRuleRequest2, $0.CreateAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/CreateAutoSaveRule',
      ($0.CreateAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateAutoSaveRuleResponse2.fromBuffer(value));
  static final _$getAutoSaveRules = $grpc.ClientMethod<
          $0.GetAutoSaveRulesRequest2, $0.GetAutoSaveRulesResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveRules',
      ($0.GetAutoSaveRulesRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAutoSaveRulesResponse2.fromBuffer(value));
  static final _$updateAutoSaveRule = $grpc.ClientMethod<
          $0.UpdateAutoSaveRuleRequest2, $0.UpdateAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/UpdateAutoSaveRule',
      ($0.UpdateAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAutoSaveRuleResponse2.fromBuffer(value));
  static final _$toggleAutoSaveRule = $grpc.ClientMethod<
          $0.ToggleAutoSaveRuleRequest2, $0.ToggleAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/ToggleAutoSaveRule',
      ($0.ToggleAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ToggleAutoSaveRuleResponse2.fromBuffer(value));
  static final _$deleteAutoSaveRule = $grpc.ClientMethod<
          $0.DeleteAutoSaveRuleRequest2, $0.DeleteAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/DeleteAutoSaveRule',
      ($0.DeleteAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteAutoSaveRuleResponse2.fromBuffer(value));
  static final _$getAutoSaveTransactions = $grpc.ClientMethod<
          $0.GetAutoSaveTransactionsRequest2,
          $0.GetAutoSaveTransactionsResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveTransactions',
      ($0.GetAutoSaveTransactionsRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAutoSaveTransactionsResponse2.fromBuffer(value));
  static final _$getAutoSaveStatistics = $grpc.ClientMethod<
          $0.GetAutoSaveStatisticsRequest2, $0.GetAutoSaveStatisticsResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveStatistics',
      ($0.GetAutoSaveStatisticsRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAutoSaveStatisticsResponse2.fromBuffer(value));
  static final _$triggerAutoSave = $grpc.ClientMethod<
          $0.TriggerAutoSaveRequest2, $0.TriggerAutoSaveResponse2>(
      '/financialproducts.FinancialProductsService/TriggerAutoSave',
      ($0.TriggerAutoSaveRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TriggerAutoSaveResponse2.fromBuffer(value));

  FinancialProductsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateGroupAccountResponse> createGroupAccount(
      $0.CreateGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupAccountsResponse> getGroupAccounts(
      $0.GetGroupAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGroupAccountResponse> getGroupAccount(
      $0.GetGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddGroupMemberResponse> addGroupMember(
      $0.AddGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveGroupMemberResponse> removeGroupMember(
      $0.RemoveGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContributeToGroupResponse> contributeToGroup(
      $0.ContributeToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawFromGroupResponse> withdrawFromGroup(
      $0.WithdrawFromGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromGroup, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseGroupAccountResponse> closeGroupAccount(
      $0.CloseGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyInsuranceResponse> buyInsurance(
      $0.BuyInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePoliciesResponse> getInsurancePolicies(
      $0.GetInsurancePoliciesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicies, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePolicyResponse> getInsurancePolicy(
      $0.GetInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $0.MakeInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelInsuranceResponse> cancelInsurance(
      $0.CancelInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePlansResponse> getInsurancePlans(
      $0.GetInsurancePlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlans, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts(
          $0.GetInsuranceMarketplaceProductsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceMarketplaceProducts, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories(
          $0.GetInsuranceMarketplaceCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceMarketplaceCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceQuoteResponse> getInsuranceQuote(
      $0.GetInsuranceQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance(
          $0.PurchaseMarketplaceInsuranceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseMarketplaceInsurance, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($0.GetInsurancePurchaseStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePurchaseStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument($0.UploadInsuranceDocumentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInsuranceDocument, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL(
          $0.GetInsuranceDocumentUploadURLRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceDocumentUploadURL, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData($0.GetInsuranceAuxiliaryDataRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceAuxiliaryData, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceProductSchemaResponse>
      getInsuranceProductSchema($0.GetInsuranceProductSchemaRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceProductSchema, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePaymentsResponse> getInsurancePayments(
      $0.GetInsurancePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserInsurancePaymentsResponse>
      getUserInsurancePayments($0.GetUserInsurancePaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurancePayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateInsurancePaymentResponse>
      createInsurancePayment($0.CreateInsurancePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurancePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ProcessInsurancePaymentResponse>
      processInsurancePayment($0.ProcessInsurancePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInsurancePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePaymentByIdResponse>
      getInsurancePaymentById($0.GetInsurancePaymentByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePaymentById, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments($0.GetOverdueInsurancePaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueInsurancePayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceClaimsResponse> getInsuranceClaims(
      $0.GetInsuranceClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserInsuranceClaimsResponse>
      getUserInsuranceClaims($0.GetUserInsuranceClaimsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsuranceClaims, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInsuranceClaimResponse> updateInsuranceClaim(
      $0.UpdateInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceClaimByIdResponse> getInsuranceClaimById(
      $0.GetInsuranceClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInsurancePolicyResponse> updateInsurancePolicy(
      $0.UpdateInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateInsuranceReceiptResponse>
      generateInsuranceReceipt($0.GenerateInsuranceReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInsuranceReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetUserInsuranceReceiptsResponse>
      getUserInsuranceReceipts($0.GetUserInsuranceReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsuranceReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceStatisticsResponse>
      getInsuranceStatistics($0.GetInsuranceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics(
          $0.GetInsurancePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $0.GetMyCoverCustomersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverCustomerByIdResponse>
      getMyCoverCustomerById($0.GetMyCoverCustomerByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerById, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($0.GetMyCoverCustomerPoliciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPolicies, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($0.GetMyCoverCustomerPurchasesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPurchases, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $0.GetMyCoverPurchasesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchases, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverPurchaseByIdResponse>
      getMyCoverPurchaseById($0.GetMyCoverPurchaseByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchaseById, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverClaimsResponse> getMyCoverClaims(
      $0.GetMyCoverClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaims, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverPoliciesResponse> getMyCoverPolicies(
      $0.GetMyCoverPoliciesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPolicies, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverPolicyByIdResponse> getMyCoverPolicyById(
      $0.GetMyCoverPolicyByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPolicyById, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $0.GetMyCoverClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$0.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $0.FileCreditLifeClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fileCreditLifeClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceStatesResponse> getInsuranceStates(
      $0.GetInsuranceStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStates, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes($0.GetInsuranceVehicleMakesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceVehicleMakes, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences(
          $0.GetMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences(
          $0.UpdateMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance($0.GetMyCoverWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RequestInsuranceRefundResponse>
      requestInsuranceRefund($0.RequestInsuranceRefundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInsuranceRefund, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus($0.GetInsuranceRefundStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceRefundStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview(
          $0.GetInsuranceReconciliationOverviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceReconciliationOverview, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions(
          $0.GetOrphanedInsuranceTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrphanedInsuranceTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ManualReconcilePurchaseResponse>
      manualReconcilePurchase($0.ManualReconcilePurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$manualReconcilePurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminTriggerRefundResponse> adminTriggerRefund(
      $0.AdminTriggerRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminTriggerRefund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents($0.GetInsuranceWebhookEventsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceWebhookEvents, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RetryFailedWebhookEventResponse>
      retryFailedWebhookEvent($0.RetryFailedWebhookEventRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryFailedWebhookEvent, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions(
          $0.GetFailedInsuranceTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFailedInsuranceTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateProductMarginResponse> updateProductMargin(
      $0.UpdateProductMarginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateProductMargin, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets($0.GetInsurancePlatformWalletsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlatformWallets, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceFeeConfigResponse> getInsuranceFeeConfig(
      $0.GetInsuranceFeeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceFeeConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInsuranceFeeConfigResponse>
      updateInsuranceFeeConfig($0.UpdateInsuranceFeeConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsuranceFeeConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListInsuranceRollbacksResponse>
      listInsuranceRollbacks($0.ListInsuranceRollbacksRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInsuranceRollbacks, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateCrowdfundResponse> createCrowdfund(
      $0.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundsResponse> getCrowdfunds(
      $0.GetCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundResponse> getCrowdfund(
      $0.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $0.ContributeToCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $0.WithdrawFromCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote(
          $0.GetCrowdfundWithdrawalFeeQuoteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundWithdrawalFeeQuote, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories(
          $0.ListCrowdfundCustomCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundCustomCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory($0.AddCrowdfundCustomCategoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addCrowdfundCustomCategory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory(
          $0.DeleteCrowdfundCustomCategoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfundCustomCategory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListCrowdfundWithdrawalsResponse>
      listCrowdfundWithdrawals($0.ListCrowdfundWithdrawalsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundWithdrawals, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CloseCrowdfundResponse> closeCrowdfund(
      $0.CloseCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelCrowdfundResponse> cancelCrowdfund(
      $0.CancelCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.ForceCompleteCrowdfundResponse>
      forceCompleteCrowdfund($0.ForceCompleteCrowdfundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forceCompleteCrowdfund, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListCrowdfundRefundsResponse> listCrowdfundRefunds(
      $0.ListCrowdfundRefundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundRefunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.RetryCrowdfundRefundResponse> retryCrowdfundRefund(
      $0.RetryCrowdfundRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryCrowdfundRefund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($0.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SearchCrowdfundsResponse> searchCrowdfunds(
      $0.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCrowdfundResponse> updateCrowdfund(
      $0.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCrowdfundResponse> deleteCrowdfund(
      $0.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $0.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserDonationsResponse> getUserDonations(
      $0.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateDonationReceiptResponse>
      generateDonationReceipt($0.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($0.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ConnectNotificationChannelResponse>
      connectNotificationChannel($0.ConnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel(
          $0.DisconnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetNotificationChannelsResponse>
      getNotificationChannels($0.GetNotificationChannelsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateNotificationChannelResponse>
      updateNotificationChannel($0.UpdateNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TestNotificationChannelResponse>
      testNotificationChannel($0.TestNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $0.GetTelegramBotInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $0.VerifyTelegramChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetNotificationHistoryResponse>
      getNotificationHistory($0.GetNotificationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundLeaderboardResponse>
      getCrowdfundLeaderboard($0.GetCrowdfundLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateAutoSaveRuleResponse2> createAutoSaveRule(
      $0.CreateAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSaveRulesResponse2> getAutoSaveRules(
      $0.GetAutoSaveRulesRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveRules, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoSaveRuleResponse2> updateAutoSaveRule(
      $0.UpdateAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule(
      $0.ToggleAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule(
      $0.DeleteAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSaveTransactionsResponse2>
      getAutoSaveTransactions($0.GetAutoSaveTransactionsRequest2 request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics(
      $0.GetAutoSaveStatisticsRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.TriggerAutoSaveResponse2> triggerAutoSave(
      $0.TriggerAutoSaveRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoSave, request, options: options);
  }
}

abstract class FinancialProductsServiceBase extends $grpc.Service {
  $core.String get $name => 'financialproducts.FinancialProductsService';

  FinancialProductsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateGroupAccountRequest,
            $0.CreateGroupAccountResponse>(
        'CreateGroupAccount',
        createGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateGroupAccountRequest.fromBuffer(value),
        ($0.CreateGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupAccountsRequest,
            $0.GetGroupAccountsResponse>(
        'GetGroupAccounts',
        getGroupAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupAccountsRequest.fromBuffer(value),
        ($0.GetGroupAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGroupAccountRequest,
            $0.GetGroupAccountResponse>(
        'GetGroupAccount',
        getGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetGroupAccountRequest.fromBuffer(value),
        ($0.GetGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddGroupMemberRequest,
            $0.AddGroupMemberResponse>(
        'AddGroupMember',
        addGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddGroupMemberRequest.fromBuffer(value),
        ($0.AddGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveGroupMemberRequest,
            $0.RemoveGroupMemberResponse>(
        'RemoveGroupMember',
        removeGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveGroupMemberRequest.fromBuffer(value),
        ($0.RemoveGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ContributeToGroupRequest,
            $0.ContributeToGroupResponse>(
        'ContributeToGroup',
        contributeToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ContributeToGroupRequest.fromBuffer(value),
        ($0.ContributeToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromGroupRequest,
            $0.WithdrawFromGroupResponse>(
        'WithdrawFromGroup',
        withdrawFromGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawFromGroupRequest.fromBuffer(value),
        ($0.WithdrawFromGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseGroupAccountRequest,
            $0.CloseGroupAccountResponse>(
        'CloseGroupAccount',
        closeGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CloseGroupAccountRequest.fromBuffer(value),
        ($0.CloseGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.BuyInsuranceRequest, $0.BuyInsuranceResponse>(
            'BuyInsurance',
            buyInsurance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BuyInsuranceRequest.fromBuffer(value),
            ($0.BuyInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePoliciesRequest,
            $0.GetInsurancePoliciesResponse>(
        'GetInsurancePolicies',
        getInsurancePolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePoliciesRequest.fromBuffer(value),
        ($0.GetInsurancePoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePolicyRequest,
            $0.GetInsurancePolicyResponse>(
        'GetInsurancePolicy',
        getInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePolicyRequest.fromBuffer(value),
        ($0.GetInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MakeInsuranceClaimRequest,
            $0.MakeInsuranceClaimResponse>(
        'MakeInsuranceClaim',
        makeInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MakeInsuranceClaimRequest.fromBuffer(value),
        ($0.MakeInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelInsuranceRequest,
            $0.CancelInsuranceResponse>(
        'CancelInsurance',
        cancelInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelInsuranceRequest.fromBuffer(value),
        ($0.CancelInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePlansRequest,
            $0.GetInsurancePlansResponse>(
        'GetInsurancePlans',
        getInsurancePlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePlansRequest.fromBuffer(value),
        ($0.GetInsurancePlansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceMarketplaceProductsRequest,
            $0.GetInsuranceMarketplaceProductsResponse>(
        'GetInsuranceMarketplaceProducts',
        getInsuranceMarketplaceProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceMarketplaceProductsRequest.fromBuffer(value),
        ($0.GetInsuranceMarketplaceProductsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceMarketplaceCategoriesRequest,
            $0.GetInsuranceMarketplaceCategoriesResponse>(
        'GetInsuranceMarketplaceCategories',
        getInsuranceMarketplaceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceMarketplaceCategoriesRequest.fromBuffer(value),
        ($0.GetInsuranceMarketplaceCategoriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceQuoteRequest,
            $0.GetInsuranceQuoteResponse>(
        'GetInsuranceQuote',
        getInsuranceQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceQuoteRequest.fromBuffer(value),
        ($0.GetInsuranceQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PurchaseMarketplaceInsuranceRequest,
            $0.PurchaseMarketplaceInsuranceResponse>(
        'PurchaseMarketplaceInsurance',
        purchaseMarketplaceInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PurchaseMarketplaceInsuranceRequest.fromBuffer(value),
        ($0.PurchaseMarketplaceInsuranceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePurchaseStatusRequest,
            $0.GetInsurancePurchaseStatusResponse>(
        'GetInsurancePurchaseStatus',
        getInsurancePurchaseStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePurchaseStatusRequest.fromBuffer(value),
        ($0.GetInsurancePurchaseStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadInsuranceDocumentRequest,
            $0.UploadInsuranceDocumentResponse>(
        'UploadInsuranceDocument',
        uploadInsuranceDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UploadInsuranceDocumentRequest.fromBuffer(value),
        ($0.UploadInsuranceDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceDocumentUploadURLRequest,
            $0.GetInsuranceDocumentUploadURLResponse>(
        'GetInsuranceDocumentUploadURL',
        getInsuranceDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceDocumentUploadURLRequest.fromBuffer(value),
        ($0.GetInsuranceDocumentUploadURLResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceAuxiliaryDataRequest,
            $0.GetInsuranceAuxiliaryDataResponse>(
        'GetInsuranceAuxiliaryData',
        getInsuranceAuxiliaryData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceAuxiliaryDataRequest.fromBuffer(value),
        ($0.GetInsuranceAuxiliaryDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceProductSchemaRequest,
            $0.GetInsuranceProductSchemaResponse>(
        'GetInsuranceProductSchema',
        getInsuranceProductSchema_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceProductSchemaRequest.fromBuffer(value),
        ($0.GetInsuranceProductSchemaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePaymentsRequest,
            $0.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePaymentsRequest.fromBuffer(value),
        ($0.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserInsurancePaymentsRequest,
            $0.GetUserInsurancePaymentsResponse>(
        'GetUserInsurancePayments',
        getUserInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserInsurancePaymentsRequest.fromBuffer(value),
        ($0.GetUserInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateInsurancePaymentRequest,
            $0.CreateInsurancePaymentResponse>(
        'CreateInsurancePayment',
        createInsurancePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateInsurancePaymentRequest.fromBuffer(value),
        ($0.CreateInsurancePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessInsurancePaymentRequest,
            $0.ProcessInsurancePaymentResponse>(
        'ProcessInsurancePayment',
        processInsurancePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessInsurancePaymentRequest.fromBuffer(value),
        ($0.ProcessInsurancePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePaymentByIdRequest,
            $0.GetInsurancePaymentByIdResponse>(
        'GetInsurancePaymentById',
        getInsurancePaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePaymentByIdRequest.fromBuffer(value),
        ($0.GetInsurancePaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOverdueInsurancePaymentsRequest,
            $0.GetOverdueInsurancePaymentsResponse>(
        'GetOverdueInsurancePayments',
        getOverdueInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetOverdueInsurancePaymentsRequest.fromBuffer(value),
        ($0.GetOverdueInsurancePaymentsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceClaimsRequest,
            $0.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceClaimsRequest.fromBuffer(value),
        ($0.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserInsuranceClaimsRequest,
            $0.GetUserInsuranceClaimsResponse>(
        'GetUserInsuranceClaims',
        getUserInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserInsuranceClaimsRequest.fromBuffer(value),
        ($0.GetUserInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInsuranceClaimRequest,
            $0.UpdateInsuranceClaimResponse>(
        'UpdateInsuranceClaim',
        updateInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInsuranceClaimRequest.fromBuffer(value),
        ($0.UpdateInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceClaimByIdRequest,
            $0.GetInsuranceClaimByIdResponse>(
        'GetInsuranceClaimById',
        getInsuranceClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceClaimByIdRequest.fromBuffer(value),
        ($0.GetInsuranceClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInsurancePolicyRequest,
            $0.UpdateInsurancePolicyResponse>(
        'UpdateInsurancePolicy',
        updateInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInsurancePolicyRequest.fromBuffer(value),
        ($0.UpdateInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateInsuranceReceiptRequest,
            $0.GenerateInsuranceReceiptResponse>(
        'GenerateInsuranceReceipt',
        generateInsuranceReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateInsuranceReceiptRequest.fromBuffer(value),
        ($0.GenerateInsuranceReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserInsuranceReceiptsRequest,
            $0.GetUserInsuranceReceiptsResponse>(
        'GetUserInsuranceReceipts',
        getUserInsuranceReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserInsuranceReceiptsRequest.fromBuffer(value),
        ($0.GetUserInsuranceReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceStatisticsRequest,
            $0.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($0.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePaymentStatisticsRequest,
            $0.GetInsurancePaymentStatisticsResponse>(
        'GetInsurancePaymentStatistics',
        getInsurancePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePaymentStatisticsRequest.fromBuffer(value),
        ($0.GetInsurancePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverCustomersRequest,
            $0.GetMyCoverCustomersResponse>(
        'GetMyCoverCustomers',
        getMyCoverCustomers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverCustomersRequest.fromBuffer(value),
        ($0.GetMyCoverCustomersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverCustomerByIdRequest,
            $0.GetMyCoverCustomerByIdResponse>(
        'GetMyCoverCustomerById',
        getMyCoverCustomerById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverCustomerByIdRequest.fromBuffer(value),
        ($0.GetMyCoverCustomerByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverCustomerPoliciesRequest,
            $0.GetMyCoverCustomerPoliciesResponse>(
        'GetMyCoverCustomerPolicies',
        getMyCoverCustomerPolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverCustomerPoliciesRequest.fromBuffer(value),
        ($0.GetMyCoverCustomerPoliciesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverCustomerPurchasesRequest,
            $0.GetMyCoverCustomerPurchasesResponse>(
        'GetMyCoverCustomerPurchases',
        getMyCoverCustomerPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverCustomerPurchasesRequest.fromBuffer(value),
        ($0.GetMyCoverCustomerPurchasesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverPurchasesRequest,
            $0.GetMyCoverPurchasesResponse>(
        'GetMyCoverPurchases',
        getMyCoverPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverPurchasesRequest.fromBuffer(value),
        ($0.GetMyCoverPurchasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverPurchaseByIdRequest,
            $0.GetMyCoverPurchaseByIdResponse>(
        'GetMyCoverPurchaseById',
        getMyCoverPurchaseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverPurchaseByIdRequest.fromBuffer(value),
        ($0.GetMyCoverPurchaseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverClaimsRequest,
            $0.GetMyCoverClaimsResponse>(
        'GetMyCoverClaims',
        getMyCoverClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverClaimsRequest.fromBuffer(value),
        ($0.GetMyCoverClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverPoliciesRequest,
            $0.GetMyCoverPoliciesResponse>(
        'GetMyCoverPolicies',
        getMyCoverPolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverPoliciesRequest.fromBuffer(value),
        ($0.GetMyCoverPoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverPolicyByIdRequest,
            $0.GetMyCoverPolicyByIdResponse>(
        'GetMyCoverPolicyById',
        getMyCoverPolicyById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverPolicyByIdRequest.fromBuffer(value),
        ($0.GetMyCoverPolicyByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverClaimByIdRequest,
            $0.GetMyCoverClaimByIdResponse>(
        'GetMyCoverClaimById',
        getMyCoverClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverClaimByIdRequest.fromBuffer(value),
        ($0.GetMyCoverClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FileCreditLifeClaimRequest,
            $0.FileCreditLifeClaimResponse>(
        'FileCreditLifeClaim',
        fileCreditLifeClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.FileCreditLifeClaimRequest.fromBuffer(value),
        ($0.FileCreditLifeClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceStatesRequest,
            $0.GetInsuranceStatesResponse>(
        'GetInsuranceStates',
        getInsuranceStates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceStatesRequest.fromBuffer(value),
        ($0.GetInsuranceStatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceVehicleMakesRequest,
            $0.GetInsuranceVehicleMakesResponse>(
        'GetInsuranceVehicleMakes',
        getInsuranceVehicleMakes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceVehicleMakesRequest.fromBuffer(value),
        ($0.GetInsuranceVehicleMakesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverNotificationPreferencesRequest,
            $0.GetMyCoverNotificationPreferencesResponse>(
        'GetMyCoverNotificationPreferences',
        getMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($0.GetMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $0.UpdateMyCoverNotificationPreferencesRequest,
            $0.UpdateMyCoverNotificationPreferencesResponse>(
        'UpdateMyCoverNotificationPreferences',
        updateMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($0.UpdateMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyCoverWalletBalanceRequest,
            $0.GetMyCoverWalletBalanceResponse>(
        'GetMyCoverWalletBalance',
        getMyCoverWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyCoverWalletBalanceRequest.fromBuffer(value),
        ($0.GetMyCoverWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestInsuranceRefundRequest,
            $0.RequestInsuranceRefundResponse>(
        'RequestInsuranceRefund',
        requestInsuranceRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestInsuranceRefundRequest.fromBuffer(value),
        ($0.RequestInsuranceRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceRefundStatusRequest,
            $0.GetInsuranceRefundStatusResponse>(
        'GetInsuranceRefundStatus',
        getInsuranceRefundStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceRefundStatusRequest.fromBuffer(value),
        ($0.GetInsuranceRefundStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceReconciliationOverviewRequest,
            $0.GetInsuranceReconciliationOverviewResponse>(
        'GetInsuranceReconciliationOverview',
        getInsuranceReconciliationOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceReconciliationOverviewRequest.fromBuffer(value),
        ($0.GetInsuranceReconciliationOverviewResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOrphanedInsuranceTransactionsRequest,
            $0.GetOrphanedInsuranceTransactionsResponse>(
        'GetOrphanedInsuranceTransactions',
        getOrphanedInsuranceTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetOrphanedInsuranceTransactionsRequest.fromBuffer(value),
        ($0.GetOrphanedInsuranceTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ManualReconcilePurchaseRequest,
            $0.ManualReconcilePurchaseResponse>(
        'ManualReconcilePurchase',
        manualReconcilePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ManualReconcilePurchaseRequest.fromBuffer(value),
        ($0.ManualReconcilePurchaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminTriggerRefundRequest,
            $0.AdminTriggerRefundResponse>(
        'AdminTriggerRefund',
        adminTriggerRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminTriggerRefundRequest.fromBuffer(value),
        ($0.AdminTriggerRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceWebhookEventsRequest,
            $0.GetInsuranceWebhookEventsResponse>(
        'GetInsuranceWebhookEvents',
        getInsuranceWebhookEvents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceWebhookEventsRequest.fromBuffer(value),
        ($0.GetInsuranceWebhookEventsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RetryFailedWebhookEventRequest,
            $0.RetryFailedWebhookEventResponse>(
        'RetryFailedWebhookEvent',
        retryFailedWebhookEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RetryFailedWebhookEventRequest.fromBuffer(value),
        ($0.RetryFailedWebhookEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFailedInsuranceTransactionsRequest,
            $0.GetFailedInsuranceTransactionsResponse>(
        'GetFailedInsuranceTransactions',
        getFailedInsuranceTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFailedInsuranceTransactionsRequest.fromBuffer(value),
        ($0.GetFailedInsuranceTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateProductMarginRequest,
            $0.UpdateProductMarginResponse>(
        'UpdateProductMargin',
        updateProductMargin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateProductMarginRequest.fromBuffer(value),
        ($0.UpdateProductMarginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePlatformWalletsRequest,
            $0.GetInsurancePlatformWalletsResponse>(
        'GetInsurancePlatformWallets',
        getInsurancePlatformWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsurancePlatformWalletsRequest.fromBuffer(value),
        ($0.GetInsurancePlatformWalletsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceFeeConfigRequest,
            $0.GetInsuranceFeeConfigResponse>(
        'GetInsuranceFeeConfig',
        getInsuranceFeeConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInsuranceFeeConfigRequest.fromBuffer(value),
        ($0.GetInsuranceFeeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInsuranceFeeConfigRequest,
            $0.UpdateInsuranceFeeConfigResponse>(
        'UpdateInsuranceFeeConfig',
        updateInsuranceFeeConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInsuranceFeeConfigRequest.fromBuffer(value),
        ($0.UpdateInsuranceFeeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListInsuranceRollbacksRequest,
            $0.ListInsuranceRollbacksResponse>(
        'ListInsuranceRollbacks',
        listInsuranceRollbacks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListInsuranceRollbacksRequest.fromBuffer(value),
        ($0.ListInsuranceRollbacksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateCrowdfundRequest,
            $0.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateCrowdfundRequest.fromBuffer(value),
        ($0.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCrowdfundsRequest, $0.GetCrowdfundsResponse>(
            'GetCrowdfunds',
            getCrowdfunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCrowdfundsRequest.fromBuffer(value),
            ($0.GetCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCrowdfundRequest.fromBuffer(value),
            ($0.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ContributeToCrowdfundRequest,
            $0.ContributeToCrowdfundResponse>(
        'ContributeToCrowdfund',
        contributeToCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ContributeToCrowdfundRequest.fromBuffer(value),
        ($0.ContributeToCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawFromCrowdfundRequest,
            $0.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($0.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundWithdrawalFeeQuoteRequest,
            $0.GetCrowdfundWithdrawalFeeQuoteResponse>(
        'GetCrowdfundWithdrawalFeeQuote',
        getCrowdfundWithdrawalFeeQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCrowdfundWithdrawalFeeQuoteRequest.fromBuffer(value),
        ($0.GetCrowdfundWithdrawalFeeQuoteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCrowdfundCustomCategoriesRequest,
            $0.ListCrowdfundCustomCategoriesResponse>(
        'ListCrowdfundCustomCategories',
        listCrowdfundCustomCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListCrowdfundCustomCategoriesRequest.fromBuffer(value),
        ($0.ListCrowdfundCustomCategoriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddCrowdfundCustomCategoryRequest,
            $0.AddCrowdfundCustomCategoryResponse>(
        'AddCrowdfundCustomCategory',
        addCrowdfundCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddCrowdfundCustomCategoryRequest.fromBuffer(value),
        ($0.AddCrowdfundCustomCategoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCrowdfundCustomCategoryRequest,
            $0.DeleteCrowdfundCustomCategoryResponse>(
        'DeleteCrowdfundCustomCategory',
        deleteCrowdfundCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCrowdfundCustomCategoryRequest.fromBuffer(value),
        ($0.DeleteCrowdfundCustomCategoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCrowdfundWithdrawalsRequest,
            $0.ListCrowdfundWithdrawalsResponse>(
        'ListCrowdfundWithdrawals',
        listCrowdfundWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListCrowdfundWithdrawalsRequest.fromBuffer(value),
        ($0.ListCrowdfundWithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseCrowdfundRequest,
            $0.CloseCrowdfundResponse>(
        'CloseCrowdfund',
        closeCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CloseCrowdfundRequest.fromBuffer(value),
        ($0.CloseCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelCrowdfundRequest,
            $0.CancelCrowdfundResponse>(
        'CancelCrowdfund',
        cancelCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelCrowdfundRequest.fromBuffer(value),
        ($0.CancelCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ForceCompleteCrowdfundRequest,
            $0.ForceCompleteCrowdfundResponse>(
        'ForceCompleteCrowdfund',
        forceCompleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ForceCompleteCrowdfundRequest.fromBuffer(value),
        ($0.ForceCompleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCrowdfundRefundsRequest,
            $0.ListCrowdfundRefundsResponse>(
        'ListCrowdfundRefunds',
        listCrowdfundRefunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListCrowdfundRefundsRequest.fromBuffer(value),
        ($0.ListCrowdfundRefundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RetryCrowdfundRefundRequest,
            $0.RetryCrowdfundRefundResponse>(
        'RetryCrowdfundRefund',
        retryCrowdfundRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RetryCrowdfundRefundRequest.fromBuffer(value),
        ($0.RetryCrowdfundRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundStatisticsRequest,
            $0.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($0.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchCrowdfundsRequest,
            $0.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchCrowdfundsRequest.fromBuffer(value),
        ($0.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCrowdfundRequest,
            $0.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCrowdfundRequest.fromBuffer(value),
        ($0.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCrowdfundRequest,
            $0.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCrowdfundRequest.fromBuffer(value),
        ($0.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundDonationsRequest,
            $0.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($0.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserDonationsRequest,
            $0.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserDonationsRequest.fromBuffer(value),
        ($0.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateDonationReceiptRequest,
            $0.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateDonationReceiptRequest.fromBuffer(value),
        ($0.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCrowdfundReceiptsRequest,
            $0.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($0.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConnectNotificationChannelRequest,
            $0.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ConnectNotificationChannelRequest.fromBuffer(value),
        ($0.ConnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisconnectNotificationChannelRequest,
            $0.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($0.DisconnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNotificationChannelsRequest,
            $0.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetNotificationChannelsRequest.fromBuffer(value),
        ($0.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateNotificationChannelRequest,
            $0.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateNotificationChannelRequest.fromBuffer(value),
        ($0.UpdateNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TestNotificationChannelRequest,
            $0.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TestNotificationChannelRequest.fromBuffer(value),
        ($0.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTelegramBotInfoRequest,
            $0.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTelegramBotInfoRequest.fromBuffer(value),
        ($0.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyTelegramChannelRequest,
            $0.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyTelegramChannelRequest.fromBuffer(value),
        ($0.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNotificationHistoryRequest,
            $0.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetNotificationHistoryRequest.fromBuffer(value),
        ($0.GetNotificationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundLeaderboardRequest,
            $0.GetCrowdfundLeaderboardResponse>(
        'GetCrowdfundLeaderboard',
        getCrowdfundLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCrowdfundLeaderboardRequest.fromBuffer(value),
        ($0.GetCrowdfundLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAutoSaveRuleRequest2,
            $0.CreateAutoSaveRuleResponse2>(
        'CreateAutoSaveRule',
        createAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAutoSaveRuleRequest2.fromBuffer(value),
        ($0.CreateAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSaveRulesRequest2,
            $0.GetAutoSaveRulesResponse2>(
        'GetAutoSaveRules',
        getAutoSaveRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAutoSaveRulesRequest2.fromBuffer(value),
        ($0.GetAutoSaveRulesResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoSaveRuleRequest2,
            $0.UpdateAutoSaveRuleResponse2>(
        'UpdateAutoSaveRule',
        updateAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAutoSaveRuleRequest2.fromBuffer(value),
        ($0.UpdateAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ToggleAutoSaveRuleRequest2,
            $0.ToggleAutoSaveRuleResponse2>(
        'ToggleAutoSaveRule',
        toggleAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ToggleAutoSaveRuleRequest2.fromBuffer(value),
        ($0.ToggleAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAutoSaveRuleRequest2,
            $0.DeleteAutoSaveRuleResponse2>(
        'DeleteAutoSaveRule',
        deleteAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteAutoSaveRuleRequest2.fromBuffer(value),
        ($0.DeleteAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSaveTransactionsRequest2,
            $0.GetAutoSaveTransactionsResponse2>(
        'GetAutoSaveTransactions',
        getAutoSaveTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAutoSaveTransactionsRequest2.fromBuffer(value),
        ($0.GetAutoSaveTransactionsResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSaveStatisticsRequest2,
            $0.GetAutoSaveStatisticsResponse2>(
        'GetAutoSaveStatistics',
        getAutoSaveStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAutoSaveStatisticsRequest2.fromBuffer(value),
        ($0.GetAutoSaveStatisticsResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TriggerAutoSaveRequest2,
            $0.TriggerAutoSaveResponse2>(
        'TriggerAutoSave',
        triggerAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TriggerAutoSaveRequest2.fromBuffer(value),
        ($0.TriggerAutoSaveResponse2 value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateGroupAccountResponse> createGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateGroupAccountRequest> request) async {
    return createGroupAccount(call, await request);
  }

  $async.Future<$0.GetGroupAccountsResponse> getGroupAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupAccountsRequest> request) async {
    return getGroupAccounts(call, await request);
  }

  $async.Future<$0.GetGroupAccountResponse> getGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetGroupAccountRequest> request) async {
    return getGroupAccount(call, await request);
  }

  $async.Future<$0.AddGroupMemberResponse> addGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AddGroupMemberRequest> request) async {
    return addGroupMember(call, await request);
  }

  $async.Future<$0.RemoveGroupMemberResponse> removeGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RemoveGroupMemberRequest> request) async {
    return removeGroupMember(call, await request);
  }

  $async.Future<$0.ContributeToGroupResponse> contributeToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ContributeToGroupRequest> request) async {
    return contributeToGroup(call, await request);
  }

  $async.Future<$0.WithdrawFromGroupResponse> withdrawFromGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.WithdrawFromGroupRequest> request) async {
    return withdrawFromGroup(call, await request);
  }

  $async.Future<$0.CloseGroupAccountResponse> closeGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CloseGroupAccountRequest> request) async {
    return closeGroupAccount(call, await request);
  }

  $async.Future<$0.BuyInsuranceResponse> buyInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.BuyInsuranceRequest> request) async {
    return buyInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePoliciesResponse> getInsurancePolicies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePoliciesRequest> request) async {
    return getInsurancePolicies(call, await request);
  }

  $async.Future<$0.GetInsurancePolicyResponse> getInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePolicyRequest> request) async {
    return getInsurancePolicy(call, await request);
  }

  $async.Future<$0.MakeInsuranceClaimResponse> makeInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MakeInsuranceClaimRequest> request) async {
    return makeInsuranceClaim(call, await request);
  }

  $async.Future<$0.CancelInsuranceResponse> cancelInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelInsuranceRequest> request) async {
    return cancelInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePlansResponse> getInsurancePlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePlansRequest> request) async {
    return getInsurancePlans(call, await request);
  }

  $async.Future<$0.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceMarketplaceProductsRequest>
              request) async {
    return getInsuranceMarketplaceProducts(call, await request);
  }

  $async.Future<$0.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceMarketplaceCategoriesRequest>
              request) async {
    return getInsuranceMarketplaceCategories(call, await request);
  }

  $async.Future<$0.GetInsuranceQuoteResponse> getInsuranceQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsuranceQuoteRequest> request) async {
    return getInsuranceQuote(call, await request);
  }

  $async.Future<$0.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance_Pre($grpc.ServiceCall call,
          $async.Future<$0.PurchaseMarketplaceInsuranceRequest> request) async {
    return purchaseMarketplaceInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsurancePurchaseStatusRequest> request) async {
    return getInsurancePurchaseStatus(call, await request);
  }

  $async.Future<$0.UploadInsuranceDocumentResponse> uploadInsuranceDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UploadInsuranceDocumentRequest> request) async {
    return uploadInsuranceDocument(call, await request);
  }

  $async.Future<$0.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceDocumentUploadURLRequest>
              request) async {
    return getInsuranceDocumentUploadURL(call, await request);
  }

  $async.Future<$0.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceAuxiliaryDataRequest> request) async {
    return getInsuranceAuxiliaryData(call, await request);
  }

  $async.Future<$0.GetInsuranceProductSchemaResponse>
      getInsuranceProductSchema_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceProductSchemaRequest> request) async {
    return getInsuranceProductSchema(call, await request);
  }

  $async.Future<$0.GetInsurancePaymentsResponse> getInsurancePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$0.GetUserInsurancePaymentsResponse>
      getUserInsurancePayments_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetUserInsurancePaymentsRequest> request) async {
    return getUserInsurancePayments(call, await request);
  }

  $async.Future<$0.CreateInsurancePaymentResponse> createInsurancePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateInsurancePaymentRequest> request) async {
    return createInsurancePayment(call, await request);
  }

  $async.Future<$0.ProcessInsurancePaymentResponse> processInsurancePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ProcessInsurancePaymentRequest> request) async {
    return processInsurancePayment(call, await request);
  }

  $async.Future<$0.GetInsurancePaymentByIdResponse> getInsurancePaymentById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsurancePaymentByIdRequest> request) async {
    return getInsurancePaymentById(call, await request);
  }

  $async.Future<$0.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetOverdueInsurancePaymentsRequest> request) async {
    return getOverdueInsurancePayments(call, await request);
  }

  $async.Future<$0.GetInsuranceClaimsResponse> getInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$0.GetUserInsuranceClaimsResponse> getUserInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserInsuranceClaimsRequest> request) async {
    return getUserInsuranceClaims(call, await request);
  }

  $async.Future<$0.UpdateInsuranceClaimResponse> updateInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateInsuranceClaimRequest> request) async {
    return updateInsuranceClaim(call, await request);
  }

  $async.Future<$0.GetInsuranceClaimByIdResponse> getInsuranceClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsuranceClaimByIdRequest> request) async {
    return getInsuranceClaimById(call, await request);
  }

  $async.Future<$0.UpdateInsurancePolicyResponse> updateInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateInsurancePolicyRequest> request) async {
    return updateInsurancePolicy(call, await request);
  }

  $async.Future<$0.GenerateInsuranceReceiptResponse>
      generateInsuranceReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$0.GenerateInsuranceReceiptRequest> request) async {
    return generateInsuranceReceipt(call, await request);
  }

  $async.Future<$0.GetUserInsuranceReceiptsResponse>
      getUserInsuranceReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetUserInsuranceReceiptsRequest> request) async {
    return getUserInsuranceReceipts(call, await request);
  }

  $async.Future<$0.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$0.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetInsurancePaymentStatisticsRequest>
              request) async {
    return getInsurancePaymentStatistics(call, await request);
  }

  $async.Future<$0.GetMyCoverCustomersResponse> getMyCoverCustomers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverCustomersRequest> request) async {
    return getMyCoverCustomers(call, await request);
  }

  $async.Future<$0.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverCustomerByIdRequest> request) async {
    return getMyCoverCustomerById(call, await request);
  }

  $async.Future<$0.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetMyCoverCustomerPoliciesRequest> request) async {
    return getMyCoverCustomerPolicies(call, await request);
  }

  $async.Future<$0.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetMyCoverCustomerPurchasesRequest> request) async {
    return getMyCoverCustomerPurchases(call, await request);
  }

  $async.Future<$0.GetMyCoverPurchasesResponse> getMyCoverPurchases_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverPurchasesRequest> request) async {
    return getMyCoverPurchases(call, await request);
  }

  $async.Future<$0.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverPurchaseByIdRequest> request) async {
    return getMyCoverPurchaseById(call, await request);
  }

  $async.Future<$0.GetMyCoverClaimsResponse> getMyCoverClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverClaimsRequest> request) async {
    return getMyCoverClaims(call, await request);
  }

  $async.Future<$0.GetMyCoverPoliciesResponse> getMyCoverPolicies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverPoliciesRequest> request) async {
    return getMyCoverPolicies(call, await request);
  }

  $async.Future<$0.GetMyCoverPolicyByIdResponse> getMyCoverPolicyById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverPolicyByIdRequest> request) async {
    return getMyCoverPolicyById(call, await request);
  }

  $async.Future<$0.GetMyCoverClaimByIdResponse> getMyCoverClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverClaimByIdRequest> request) async {
    return getMyCoverClaimById(call, await request);
  }

  $async.Future<$0.FileCreditLifeClaimResponse> fileCreditLifeClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.FileCreditLifeClaimRequest> request) async {
    return fileCreditLifeClaim(call, await request);
  }

  $async.Future<$0.GetInsuranceStatesResponse> getInsuranceStates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsuranceStatesRequest> request) async {
    return getInsuranceStates(call, await request);
  }

  $async.Future<$0.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceVehicleMakesRequest> request) async {
    return getInsuranceVehicleMakes(call, await request);
  }

  $async.Future<$0.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetMyCoverNotificationPreferencesRequest>
              request) async {
    return getMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$0.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.UpdateMyCoverNotificationPreferencesRequest>
              request) async {
    return updateMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$0.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetMyCoverWalletBalanceRequest> request) async {
    return getMyCoverWalletBalance(call, await request);
  }

  $async.Future<$0.RequestInsuranceRefundResponse> requestInsuranceRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RequestInsuranceRefundRequest> request) async {
    return requestInsuranceRefund(call, await request);
  }

  $async.Future<$0.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceRefundStatusRequest> request) async {
    return getInsuranceRefundStatus(call, await request);
  }

  $async.Future<$0.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceReconciliationOverviewRequest>
              request) async {
    return getInsuranceReconciliationOverview(call, await request);
  }

  $async.Future<$0.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetOrphanedInsuranceTransactionsRequest>
              request) async {
    return getOrphanedInsuranceTransactions(call, await request);
  }

  $async.Future<$0.ManualReconcilePurchaseResponse> manualReconcilePurchase_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ManualReconcilePurchaseRequest> request) async {
    return manualReconcilePurchase(call, await request);
  }

  $async.Future<$0.AdminTriggerRefundResponse> adminTriggerRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminTriggerRefundRequest> request) async {
    return adminTriggerRefund(call, await request);
  }

  $async.Future<$0.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsuranceWebhookEventsRequest> request) async {
    return getInsuranceWebhookEvents(call, await request);
  }

  $async.Future<$0.RetryFailedWebhookEventResponse> retryFailedWebhookEvent_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RetryFailedWebhookEventRequest> request) async {
    return retryFailedWebhookEvent(call, await request);
  }

  $async.Future<$0.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetFailedInsuranceTransactionsRequest>
              request) async {
    return getFailedInsuranceTransactions(call, await request);
  }

  $async.Future<$0.UpdateProductMarginResponse> updateProductMargin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateProductMarginRequest> request) async {
    return updateProductMargin(call, await request);
  }

  $async.Future<$0.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInsurancePlatformWalletsRequest> request) async {
    return getInsurancePlatformWallets(call, await request);
  }

  $async.Future<$0.GetInsuranceFeeConfigResponse> getInsuranceFeeConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInsuranceFeeConfigRequest> request) async {
    return getInsuranceFeeConfig(call, await request);
  }

  $async.Future<$0.UpdateInsuranceFeeConfigResponse>
      updateInsuranceFeeConfig_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateInsuranceFeeConfigRequest> request) async {
    return updateInsuranceFeeConfig(call, await request);
  }

  $async.Future<$0.ListInsuranceRollbacksResponse> listInsuranceRollbacks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListInsuranceRollbacksRequest> request) async {
    return listInsuranceRollbacks(call, await request);
  }

  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundsResponse> getCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundsRequest> request) async {
    return getCrowdfunds(call, await request);
  }

  $async.Future<$0.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$0.ContributeToCrowdfundResponse> contributeToCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ContributeToCrowdfundRequest> request) async {
    return contributeToCrowdfund(call, await request);
  }

  $async.Future<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetCrowdfundWithdrawalFeeQuoteRequest>
              request) async {
    return getCrowdfundWithdrawalFeeQuote(call, await request);
  }

  $async.Future<$0.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.ListCrowdfundCustomCategoriesRequest>
              request) async {
    return listCrowdfundCustomCategories(call, await request);
  }

  $async.Future<$0.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory_Pre($grpc.ServiceCall call,
          $async.Future<$0.AddCrowdfundCustomCategoryRequest> request) async {
    return addCrowdfundCustomCategory(call, await request);
  }

  $async.Future<$0.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.DeleteCrowdfundCustomCategoryRequest>
              request) async {
    return deleteCrowdfundCustomCategory(call, await request);
  }

  $async.Future<$0.ListCrowdfundWithdrawalsResponse>
      listCrowdfundWithdrawals_Pre($grpc.ServiceCall call,
          $async.Future<$0.ListCrowdfundWithdrawalsRequest> request) async {
    return listCrowdfundWithdrawals(call, await request);
  }

  $async.Future<$0.CloseCrowdfundResponse> closeCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CloseCrowdfundRequest> request) async {
    return closeCrowdfund(call, await request);
  }

  $async.Future<$0.CancelCrowdfundResponse> cancelCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelCrowdfundRequest> request) async {
    return cancelCrowdfund(call, await request);
  }

  $async.Future<$0.ForceCompleteCrowdfundResponse> forceCompleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ForceCompleteCrowdfundRequest> request) async {
    return forceCompleteCrowdfund(call, await request);
  }

  $async.Future<$0.ListCrowdfundRefundsResponse> listCrowdfundRefunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListCrowdfundRefundsRequest> request) async {
    return listCrowdfundRefunds(call, await request);
  }

  $async.Future<$0.RetryCrowdfundRefundResponse> retryCrowdfundRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RetryCrowdfundRefundRequest> request) async {
    return retryCrowdfundRefund(call, await request);
  }

  $async.Future<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$0.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$0.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$0.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$0.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$0.GenerateDonationReceiptResponse> generateDonationReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$0.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$0.ConnectNotificationChannelResponse>
      connectNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$0.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$0.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.DisconnectNotificationChannelRequest>
              request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$0.GetNotificationChannelsResponse> getNotificationChannels_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$0.UpdateNotificationChannelResponse>
      updateNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$0.TestNotificationChannelResponse> testNotificationChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$0.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$0.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$0.GetNotificationHistoryResponse> getNotificationHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$0.GetCrowdfundLeaderboardResponse> getCrowdfundLeaderboard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundLeaderboardRequest> request) async {
    return getCrowdfundLeaderboard(call, await request);
  }

  $async.Future<$0.CreateAutoSaveRuleResponse2> createAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateAutoSaveRuleRequest2> request) async {
    return createAutoSaveRule(call, await request);
  }

  $async.Future<$0.GetAutoSaveRulesResponse2> getAutoSaveRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAutoSaveRulesRequest2> request) async {
    return getAutoSaveRules(call, await request);
  }

  $async.Future<$0.UpdateAutoSaveRuleResponse2> updateAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateAutoSaveRuleRequest2> request) async {
    return updateAutoSaveRule(call, await request);
  }

  $async.Future<$0.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ToggleAutoSaveRuleRequest2> request) async {
    return toggleAutoSaveRule(call, await request);
  }

  $async.Future<$0.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteAutoSaveRuleRequest2> request) async {
    return deleteAutoSaveRule(call, await request);
  }

  $async.Future<$0.GetAutoSaveTransactionsResponse2>
      getAutoSaveTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetAutoSaveTransactionsRequest2> request) async {
    return getAutoSaveTransactions(call, await request);
  }

  $async.Future<$0.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAutoSaveStatisticsRequest2> request) async {
    return getAutoSaveStatistics(call, await request);
  }

  $async.Future<$0.TriggerAutoSaveResponse2> triggerAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TriggerAutoSaveRequest2> request) async {
    return triggerAutoSave(call, await request);
  }

  $async.Future<$0.CreateGroupAccountResponse> createGroupAccount(
      $grpc.ServiceCall call, $0.CreateGroupAccountRequest request);
  $async.Future<$0.GetGroupAccountsResponse> getGroupAccounts(
      $grpc.ServiceCall call, $0.GetGroupAccountsRequest request);
  $async.Future<$0.GetGroupAccountResponse> getGroupAccount(
      $grpc.ServiceCall call, $0.GetGroupAccountRequest request);
  $async.Future<$0.AddGroupMemberResponse> addGroupMember(
      $grpc.ServiceCall call, $0.AddGroupMemberRequest request);
  $async.Future<$0.RemoveGroupMemberResponse> removeGroupMember(
      $grpc.ServiceCall call, $0.RemoveGroupMemberRequest request);
  $async.Future<$0.ContributeToGroupResponse> contributeToGroup(
      $grpc.ServiceCall call, $0.ContributeToGroupRequest request);
  $async.Future<$0.WithdrawFromGroupResponse> withdrawFromGroup(
      $grpc.ServiceCall call, $0.WithdrawFromGroupRequest request);
  $async.Future<$0.CloseGroupAccountResponse> closeGroupAccount(
      $grpc.ServiceCall call, $0.CloseGroupAccountRequest request);
  $async.Future<$0.BuyInsuranceResponse> buyInsurance(
      $grpc.ServiceCall call, $0.BuyInsuranceRequest request);
  $async.Future<$0.GetInsurancePoliciesResponse> getInsurancePolicies(
      $grpc.ServiceCall call, $0.GetInsurancePoliciesRequest request);
  $async.Future<$0.GetInsurancePolicyResponse> getInsurancePolicy(
      $grpc.ServiceCall call, $0.GetInsurancePolicyRequest request);
  $async.Future<$0.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $grpc.ServiceCall call, $0.MakeInsuranceClaimRequest request);
  $async.Future<$0.CancelInsuranceResponse> cancelInsurance(
      $grpc.ServiceCall call, $0.CancelInsuranceRequest request);
  $async.Future<$0.GetInsurancePlansResponse> getInsurancePlans(
      $grpc.ServiceCall call, $0.GetInsurancePlansRequest request);
  $async.Future<$0.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts($grpc.ServiceCall call,
          $0.GetInsuranceMarketplaceProductsRequest request);
  $async.Future<$0.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories($grpc.ServiceCall call,
          $0.GetInsuranceMarketplaceCategoriesRequest request);
  $async.Future<$0.GetInsuranceQuoteResponse> getInsuranceQuote(
      $grpc.ServiceCall call, $0.GetInsuranceQuoteRequest request);
  $async.Future<$0.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance($grpc.ServiceCall call,
          $0.PurchaseMarketplaceInsuranceRequest request);
  $async.Future<$0.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus(
          $grpc.ServiceCall call, $0.GetInsurancePurchaseStatusRequest request);
  $async.Future<$0.UploadInsuranceDocumentResponse> uploadInsuranceDocument(
      $grpc.ServiceCall call, $0.UploadInsuranceDocumentRequest request);
  $async.Future<$0.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL($grpc.ServiceCall call,
          $0.GetInsuranceDocumentUploadURLRequest request);
  $async.Future<$0.GetInsuranceAuxiliaryDataResponse> getInsuranceAuxiliaryData(
      $grpc.ServiceCall call, $0.GetInsuranceAuxiliaryDataRequest request);
  $async.Future<$0.GetInsuranceProductSchemaResponse> getInsuranceProductSchema(
      $grpc.ServiceCall call, $0.GetInsuranceProductSchemaRequest request);
  $async.Future<$0.GetInsurancePaymentsResponse> getInsurancePayments(
      $grpc.ServiceCall call, $0.GetInsurancePaymentsRequest request);
  $async.Future<$0.GetUserInsurancePaymentsResponse> getUserInsurancePayments(
      $grpc.ServiceCall call, $0.GetUserInsurancePaymentsRequest request);
  $async.Future<$0.CreateInsurancePaymentResponse> createInsurancePayment(
      $grpc.ServiceCall call, $0.CreateInsurancePaymentRequest request);
  $async.Future<$0.ProcessInsurancePaymentResponse> processInsurancePayment(
      $grpc.ServiceCall call, $0.ProcessInsurancePaymentRequest request);
  $async.Future<$0.GetInsurancePaymentByIdResponse> getInsurancePaymentById(
      $grpc.ServiceCall call, $0.GetInsurancePaymentByIdRequest request);
  $async.Future<$0.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments($grpc.ServiceCall call,
          $0.GetOverdueInsurancePaymentsRequest request);
  $async.Future<$0.GetInsuranceClaimsResponse> getInsuranceClaims(
      $grpc.ServiceCall call, $0.GetInsuranceClaimsRequest request);
  $async.Future<$0.GetUserInsuranceClaimsResponse> getUserInsuranceClaims(
      $grpc.ServiceCall call, $0.GetUserInsuranceClaimsRequest request);
  $async.Future<$0.UpdateInsuranceClaimResponse> updateInsuranceClaim(
      $grpc.ServiceCall call, $0.UpdateInsuranceClaimRequest request);
  $async.Future<$0.GetInsuranceClaimByIdResponse> getInsuranceClaimById(
      $grpc.ServiceCall call, $0.GetInsuranceClaimByIdRequest request);
  $async.Future<$0.UpdateInsurancePolicyResponse> updateInsurancePolicy(
      $grpc.ServiceCall call, $0.UpdateInsurancePolicyRequest request);
  $async.Future<$0.GenerateInsuranceReceiptResponse> generateInsuranceReceipt(
      $grpc.ServiceCall call, $0.GenerateInsuranceReceiptRequest request);
  $async.Future<$0.GetUserInsuranceReceiptsResponse> getUserInsuranceReceipts(
      $grpc.ServiceCall call, $0.GetUserInsuranceReceiptsRequest request);
  $async.Future<$0.GetInsuranceStatisticsResponse> getInsuranceStatistics(
      $grpc.ServiceCall call, $0.GetInsuranceStatisticsRequest request);
  $async.Future<$0.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics($grpc.ServiceCall call,
          $0.GetInsurancePaymentStatisticsRequest request);
  $async.Future<$0.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $grpc.ServiceCall call, $0.GetMyCoverCustomersRequest request);
  $async.Future<$0.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById(
      $grpc.ServiceCall call, $0.GetMyCoverCustomerByIdRequest request);
  $async.Future<$0.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies(
          $grpc.ServiceCall call, $0.GetMyCoverCustomerPoliciesRequest request);
  $async.Future<$0.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($grpc.ServiceCall call,
          $0.GetMyCoverCustomerPurchasesRequest request);
  $async.Future<$0.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $grpc.ServiceCall call, $0.GetMyCoverPurchasesRequest request);
  $async.Future<$0.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById(
      $grpc.ServiceCall call, $0.GetMyCoverPurchaseByIdRequest request);
  $async.Future<$0.GetMyCoverClaimsResponse> getMyCoverClaims(
      $grpc.ServiceCall call, $0.GetMyCoverClaimsRequest request);
  $async.Future<$0.GetMyCoverPoliciesResponse> getMyCoverPolicies(
      $grpc.ServiceCall call, $0.GetMyCoverPoliciesRequest request);
  $async.Future<$0.GetMyCoverPolicyByIdResponse> getMyCoverPolicyById(
      $grpc.ServiceCall call, $0.GetMyCoverPolicyByIdRequest request);
  $async.Future<$0.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $grpc.ServiceCall call, $0.GetMyCoverClaimByIdRequest request);
  $async.Future<$0.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $grpc.ServiceCall call, $0.FileCreditLifeClaimRequest request);
  $async.Future<$0.GetInsuranceStatesResponse> getInsuranceStates(
      $grpc.ServiceCall call, $0.GetInsuranceStatesRequest request);
  $async.Future<$0.GetInsuranceVehicleMakesResponse> getInsuranceVehicleMakes(
      $grpc.ServiceCall call, $0.GetInsuranceVehicleMakesRequest request);
  $async.Future<$0.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences($grpc.ServiceCall call,
          $0.GetMyCoverNotificationPreferencesRequest request);
  $async.Future<$0.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences($grpc.ServiceCall call,
          $0.UpdateMyCoverNotificationPreferencesRequest request);
  $async.Future<$0.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance(
      $grpc.ServiceCall call, $0.GetMyCoverWalletBalanceRequest request);
  $async.Future<$0.RequestInsuranceRefundResponse> requestInsuranceRefund(
      $grpc.ServiceCall call, $0.RequestInsuranceRefundRequest request);
  $async.Future<$0.GetInsuranceRefundStatusResponse> getInsuranceRefundStatus(
      $grpc.ServiceCall call, $0.GetInsuranceRefundStatusRequest request);
  $async.Future<$0.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview($grpc.ServiceCall call,
          $0.GetInsuranceReconciliationOverviewRequest request);
  $async.Future<$0.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions($grpc.ServiceCall call,
          $0.GetOrphanedInsuranceTransactionsRequest request);
  $async.Future<$0.ManualReconcilePurchaseResponse> manualReconcilePurchase(
      $grpc.ServiceCall call, $0.ManualReconcilePurchaseRequest request);
  $async.Future<$0.AdminTriggerRefundResponse> adminTriggerRefund(
      $grpc.ServiceCall call, $0.AdminTriggerRefundRequest request);
  $async.Future<$0.GetInsuranceWebhookEventsResponse> getInsuranceWebhookEvents(
      $grpc.ServiceCall call, $0.GetInsuranceWebhookEventsRequest request);
  $async.Future<$0.RetryFailedWebhookEventResponse> retryFailedWebhookEvent(
      $grpc.ServiceCall call, $0.RetryFailedWebhookEventRequest request);
  $async.Future<$0.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions($grpc.ServiceCall call,
          $0.GetFailedInsuranceTransactionsRequest request);
  $async.Future<$0.UpdateProductMarginResponse> updateProductMargin(
      $grpc.ServiceCall call, $0.UpdateProductMarginRequest request);
  $async.Future<$0.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets($grpc.ServiceCall call,
          $0.GetInsurancePlatformWalletsRequest request);
  $async.Future<$0.GetInsuranceFeeConfigResponse> getInsuranceFeeConfig(
      $grpc.ServiceCall call, $0.GetInsuranceFeeConfigRequest request);
  $async.Future<$0.UpdateInsuranceFeeConfigResponse> updateInsuranceFeeConfig(
      $grpc.ServiceCall call, $0.UpdateInsuranceFeeConfigRequest request);
  $async.Future<$0.ListInsuranceRollbacksResponse> listInsuranceRollbacks(
      $grpc.ServiceCall call, $0.ListInsuranceRollbacksRequest request);
  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $0.CreateCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundsResponse> getCrowdfunds(
      $grpc.ServiceCall call, $0.GetCrowdfundsRequest request);
  $async.Future<$0.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $0.GetCrowdfundRequest request);
  $async.Future<$0.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $grpc.ServiceCall call, $0.ContributeToCrowdfundRequest request);
  $async.Future<$0.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $grpc.ServiceCall call, $0.WithdrawFromCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote($grpc.ServiceCall call,
          $0.GetCrowdfundWithdrawalFeeQuoteRequest request);
  $async.Future<$0.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories($grpc.ServiceCall call,
          $0.ListCrowdfundCustomCategoriesRequest request);
  $async.Future<$0.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory(
          $grpc.ServiceCall call, $0.AddCrowdfundCustomCategoryRequest request);
  $async.Future<$0.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory($grpc.ServiceCall call,
          $0.DeleteCrowdfundCustomCategoryRequest request);
  $async.Future<$0.ListCrowdfundWithdrawalsResponse> listCrowdfundWithdrawals(
      $grpc.ServiceCall call, $0.ListCrowdfundWithdrawalsRequest request);
  $async.Future<$0.CloseCrowdfundResponse> closeCrowdfund(
      $grpc.ServiceCall call, $0.CloseCrowdfundRequest request);
  $async.Future<$0.CancelCrowdfundResponse> cancelCrowdfund(
      $grpc.ServiceCall call, $0.CancelCrowdfundRequest request);
  $async.Future<$0.ForceCompleteCrowdfundResponse> forceCompleteCrowdfund(
      $grpc.ServiceCall call, $0.ForceCompleteCrowdfundRequest request);
  $async.Future<$0.ListCrowdfundRefundsResponse> listCrowdfundRefunds(
      $grpc.ServiceCall call, $0.ListCrowdfundRefundsRequest request);
  $async.Future<$0.RetryCrowdfundRefundResponse> retryCrowdfundRefund(
      $grpc.ServiceCall call, $0.RetryCrowdfundRefundRequest request);
  $async.Future<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $0.GetCrowdfundStatisticsRequest request);
  $async.Future<$0.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $0.SearchCrowdfundsRequest request);
  $async.Future<$0.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $0.UpdateCrowdfundRequest request);
  $async.Future<$0.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $0.DeleteCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $0.GetCrowdfundDonationsRequest request);
  $async.Future<$0.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $0.GetUserDonationsRequest request);
  $async.Future<$0.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $0.GenerateDonationReceiptRequest request);
  $async.Future<$0.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $0.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$0.ConnectNotificationChannelResponse>
      connectNotificationChannel(
          $grpc.ServiceCall call, $0.ConnectNotificationChannelRequest request);
  $async.Future<$0.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel($grpc.ServiceCall call,
          $0.DisconnectNotificationChannelRequest request);
  $async.Future<$0.GetNotificationChannelsResponse> getNotificationChannels(
      $grpc.ServiceCall call, $0.GetNotificationChannelsRequest request);
  $async.Future<$0.UpdateNotificationChannelResponse> updateNotificationChannel(
      $grpc.ServiceCall call, $0.UpdateNotificationChannelRequest request);
  $async.Future<$0.TestNotificationChannelResponse> testNotificationChannel(
      $grpc.ServiceCall call, $0.TestNotificationChannelRequest request);
  $async.Future<$0.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $grpc.ServiceCall call, $0.GetTelegramBotInfoRequest request);
  $async.Future<$0.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $grpc.ServiceCall call, $0.VerifyTelegramChannelRequest request);
  $async.Future<$0.GetNotificationHistoryResponse> getNotificationHistory(
      $grpc.ServiceCall call, $0.GetNotificationHistoryRequest request);
  $async.Future<$0.GetCrowdfundLeaderboardResponse> getCrowdfundLeaderboard(
      $grpc.ServiceCall call, $0.GetCrowdfundLeaderboardRequest request);
  $async.Future<$0.CreateAutoSaveRuleResponse2> createAutoSaveRule(
      $grpc.ServiceCall call, $0.CreateAutoSaveRuleRequest2 request);
  $async.Future<$0.GetAutoSaveRulesResponse2> getAutoSaveRules(
      $grpc.ServiceCall call, $0.GetAutoSaveRulesRequest2 request);
  $async.Future<$0.UpdateAutoSaveRuleResponse2> updateAutoSaveRule(
      $grpc.ServiceCall call, $0.UpdateAutoSaveRuleRequest2 request);
  $async.Future<$0.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule(
      $grpc.ServiceCall call, $0.ToggleAutoSaveRuleRequest2 request);
  $async.Future<$0.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule(
      $grpc.ServiceCall call, $0.DeleteAutoSaveRuleRequest2 request);
  $async.Future<$0.GetAutoSaveTransactionsResponse2> getAutoSaveTransactions(
      $grpc.ServiceCall call, $0.GetAutoSaveTransactionsRequest2 request);
  $async.Future<$0.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics(
      $grpc.ServiceCall call, $0.GetAutoSaveStatisticsRequest2 request);
  $async.Future<$0.TriggerAutoSaveResponse2> triggerAutoSave(
      $grpc.ServiceCall call, $0.TriggerAutoSaveRequest2 request);
}
