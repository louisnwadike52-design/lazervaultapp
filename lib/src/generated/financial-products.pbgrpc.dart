///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'financial-products.pb.dart' as $1;
export 'financial-products.pb.dart';

class FinancialProductsServiceClient extends $grpc.Client {
  static final _$createGroupAccount = $grpc.ClientMethod<
          $1.CreateGroupAccountRequest, $1.CreateGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CreateGroupAccount',
      ($1.CreateGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateGroupAccountResponse.fromBuffer(value));
  static final _$getGroupAccounts = $grpc.ClientMethod<
          $1.GetGroupAccountsRequest, $1.GetGroupAccountsResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccounts',
      ($1.GetGroupAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetGroupAccountsResponse.fromBuffer(value));
  static final _$getGroupAccount =
      $grpc.ClientMethod<$1.GetGroupAccountRequest, $1.GetGroupAccountResponse>(
          '/financialproducts.FinancialProductsService/GetGroupAccount',
          ($1.GetGroupAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetGroupAccountResponse.fromBuffer(value));
  static final _$addGroupMember =
      $grpc.ClientMethod<$1.AddGroupMemberRequest, $1.AddGroupMemberResponse>(
          '/financialproducts.FinancialProductsService/AddGroupMember',
          ($1.AddGroupMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.AddGroupMemberResponse.fromBuffer(value));
  static final _$removeGroupMember = $grpc.ClientMethod<
          $1.RemoveGroupMemberRequest, $1.RemoveGroupMemberResponse>(
      '/financialproducts.FinancialProductsService/RemoveGroupMember',
      ($1.RemoveGroupMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RemoveGroupMemberResponse.fromBuffer(value));
  static final _$contributeToGroup = $grpc.ClientMethod<
          $1.ContributeToGroupRequest, $1.ContributeToGroupResponse>(
      '/financialproducts.FinancialProductsService/ContributeToGroup',
      ($1.ContributeToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ContributeToGroupResponse.fromBuffer(value));
  static final _$withdrawFromGroup = $grpc.ClientMethod<
          $1.WithdrawFromGroupRequest, $1.WithdrawFromGroupResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromGroup',
      ($1.WithdrawFromGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.WithdrawFromGroupResponse.fromBuffer(value));
  static final _$closeGroupAccount = $grpc.ClientMethod<
          $1.CloseGroupAccountRequest, $1.CloseGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CloseGroupAccount',
      ($1.CloseGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CloseGroupAccountResponse.fromBuffer(value));
  static final _$buyInsurance =
      $grpc.ClientMethod<$1.BuyInsuranceRequest, $1.BuyInsuranceResponse>(
          '/financialproducts.FinancialProductsService/BuyInsurance',
          ($1.BuyInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.BuyInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePolicies = $grpc.ClientMethod<
          $1.GetInsurancePoliciesRequest, $1.GetInsurancePoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicies',
      ($1.GetInsurancePoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePoliciesResponse.fromBuffer(value));
  static final _$getInsurancePolicy = $grpc.ClientMethod<
          $1.GetInsurancePolicyRequest, $1.GetInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicy',
      ($1.GetInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePolicyResponse.fromBuffer(value));
  static final _$makeInsuranceClaim = $grpc.ClientMethod<
          $1.MakeInsuranceClaimRequest, $1.MakeInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/MakeInsuranceClaim',
      ($1.MakeInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MakeInsuranceClaimResponse.fromBuffer(value));
  static final _$cancelInsurance =
      $grpc.ClientMethod<$1.CancelInsuranceRequest, $1.CancelInsuranceResponse>(
          '/financialproducts.FinancialProductsService/CancelInsurance',
          ($1.CancelInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CancelInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePlans = $grpc.ClientMethod<
          $1.GetInsurancePlansRequest, $1.GetInsurancePlansResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlans',
      ($1.GetInsurancePlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePlansResponse.fromBuffer(value));
  static final _$getInsuranceMarketplaceProducts = $grpc.ClientMethod<
          $1.GetInsuranceMarketplaceProductsRequest,
          $1.GetInsuranceMarketplaceProductsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceMarketplaceProducts',
      ($1.GetInsuranceMarketplaceProductsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceMarketplaceProductsResponse.fromBuffer(value));
  static final _$getInsuranceMarketplaceCategories = $grpc.ClientMethod<
          $1.GetInsuranceMarketplaceCategoriesRequest,
          $1.GetInsuranceMarketplaceCategoriesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceMarketplaceCategories',
      ($1.GetInsuranceMarketplaceCategoriesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceMarketplaceCategoriesResponse.fromBuffer(value));
  static final _$getInsuranceQuote = $grpc.ClientMethod<
          $1.GetInsuranceQuoteRequest, $1.GetInsuranceQuoteResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceQuote',
      ($1.GetInsuranceQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceQuoteResponse.fromBuffer(value));
  static final _$purchaseMarketplaceInsurance = $grpc.ClientMethod<
          $1.PurchaseMarketplaceInsuranceRequest,
          $1.PurchaseMarketplaceInsuranceResponse>(
      '/financialproducts.FinancialProductsService/PurchaseMarketplaceInsurance',
      ($1.PurchaseMarketplaceInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PurchaseMarketplaceInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePurchaseStatus = $grpc.ClientMethod<
          $1.GetInsurancePurchaseStatusRequest,
          $1.GetInsurancePurchaseStatusResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePurchaseStatus',
      ($1.GetInsurancePurchaseStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePurchaseStatusResponse.fromBuffer(value));
  static final _$uploadInsuranceDocument = $grpc.ClientMethod<
          $1.UploadInsuranceDocumentRequest,
          $1.UploadInsuranceDocumentResponse>(
      '/financialproducts.FinancialProductsService/UploadInsuranceDocument',
      ($1.UploadInsuranceDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UploadInsuranceDocumentResponse.fromBuffer(value));
  static final _$getInsuranceDocumentUploadURL = $grpc.ClientMethod<
          $1.GetInsuranceDocumentUploadURLRequest,
          $1.GetInsuranceDocumentUploadURLResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceDocumentUploadURL',
      ($1.GetInsuranceDocumentUploadURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceDocumentUploadURLResponse.fromBuffer(value));
  static final _$getInsuranceAuxiliaryData = $grpc.ClientMethod<
          $1.GetInsuranceAuxiliaryDataRequest,
          $1.GetInsuranceAuxiliaryDataResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceAuxiliaryData',
      ($1.GetInsuranceAuxiliaryDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceAuxiliaryDataResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<
          $1.GetInsurancePaymentsRequest, $1.GetInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePayments',
      ($1.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserInsurancePayments = $grpc.ClientMethod<
          $1.GetUserInsurancePaymentsRequest,
          $1.GetUserInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsurancePayments',
      ($1.GetUserInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetUserInsurancePaymentsResponse.fromBuffer(value));
  static final _$createInsurancePayment = $grpc.ClientMethod<
          $1.CreateInsurancePaymentRequest, $1.CreateInsurancePaymentResponse>(
      '/financialproducts.FinancialProductsService/CreateInsurancePayment',
      ($1.CreateInsurancePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateInsurancePaymentResponse.fromBuffer(value));
  static final _$processInsurancePayment = $grpc.ClientMethod<
          $1.ProcessInsurancePaymentRequest,
          $1.ProcessInsurancePaymentResponse>(
      '/financialproducts.FinancialProductsService/ProcessInsurancePayment',
      ($1.ProcessInsurancePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ProcessInsurancePaymentResponse.fromBuffer(value));
  static final _$getInsurancePaymentById = $grpc.ClientMethod<
          $1.GetInsurancePaymentByIdRequest,
          $1.GetInsurancePaymentByIdResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePaymentById',
      ($1.GetInsurancePaymentByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePaymentByIdResponse.fromBuffer(value));
  static final _$getOverdueInsurancePayments = $grpc.ClientMethod<
          $1.GetOverdueInsurancePaymentsRequest,
          $1.GetOverdueInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetOverdueInsurancePayments',
      ($1.GetOverdueInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetOverdueInsurancePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<
          $1.GetInsuranceClaimsRequest, $1.GetInsuranceClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceClaims',
      ($1.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserInsuranceClaims = $grpc.ClientMethod<
          $1.GetUserInsuranceClaimsRequest, $1.GetUserInsuranceClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsuranceClaims',
      ($1.GetUserInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetUserInsuranceClaimsResponse.fromBuffer(value));
  static final _$updateInsuranceClaim = $grpc.ClientMethod<
          $1.UpdateInsuranceClaimRequest, $1.UpdateInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsuranceClaim',
      ($1.UpdateInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateInsuranceClaimResponse.fromBuffer(value));
  static final _$getInsuranceClaimById = $grpc.ClientMethod<
          $1.GetInsuranceClaimByIdRequest, $1.GetInsuranceClaimByIdResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceClaimById',
      ($1.GetInsuranceClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceClaimByIdResponse.fromBuffer(value));
  static final _$updateInsurancePolicy = $grpc.ClientMethod<
          $1.UpdateInsurancePolicyRequest, $1.UpdateInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsurancePolicy',
      ($1.UpdateInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateInsurancePolicyResponse.fromBuffer(value));
  static final _$generateInsuranceReceipt = $grpc.ClientMethod<
          $1.GenerateInsuranceReceiptRequest,
          $1.GenerateInsuranceReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateInsuranceReceipt',
      ($1.GenerateInsuranceReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GenerateInsuranceReceiptResponse.fromBuffer(value));
  static final _$getUserInsuranceReceipts = $grpc.ClientMethod<
          $1.GetUserInsuranceReceiptsRequest,
          $1.GetUserInsuranceReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsuranceReceipts',
      ($1.GetUserInsuranceReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetUserInsuranceReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<
          $1.GetInsuranceStatisticsRequest, $1.GetInsuranceStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceStatistics',
      ($1.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getInsurancePaymentStatistics = $grpc.ClientMethod<
          $1.GetInsurancePaymentStatisticsRequest,
          $1.GetInsurancePaymentStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePaymentStatistics',
      ($1.GetInsurancePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePaymentStatisticsResponse.fromBuffer(value));
  static final _$getMyCoverCustomers = $grpc.ClientMethod<
          $1.GetMyCoverCustomersRequest, $1.GetMyCoverCustomersResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomers',
      ($1.GetMyCoverCustomersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverCustomersResponse.fromBuffer(value));
  static final _$getMyCoverCustomerById = $grpc.ClientMethod<
          $1.GetMyCoverCustomerByIdRequest, $1.GetMyCoverCustomerByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerById',
      ($1.GetMyCoverCustomerByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverCustomerByIdResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPolicies = $grpc.ClientMethod<
          $1.GetMyCoverCustomerPoliciesRequest,
          $1.GetMyCoverCustomerPoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerPolicies',
      ($1.GetMyCoverCustomerPoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverCustomerPoliciesResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPurchases = $grpc.ClientMethod<
          $1.GetMyCoverCustomerPurchasesRequest,
          $1.GetMyCoverCustomerPurchasesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerPurchases',
      ($1.GetMyCoverCustomerPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverCustomerPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchases = $grpc.ClientMethod<
          $1.GetMyCoverPurchasesRequest, $1.GetMyCoverPurchasesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPurchases',
      ($1.GetMyCoverPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchaseById = $grpc.ClientMethod<
          $1.GetMyCoverPurchaseByIdRequest, $1.GetMyCoverPurchaseByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPurchaseById',
      ($1.GetMyCoverPurchaseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverPurchaseByIdResponse.fromBuffer(value));
  static final _$getMyCoverClaims = $grpc.ClientMethod<
          $1.GetMyCoverClaimsRequest, $1.GetMyCoverClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverClaims',
      ($1.GetMyCoverClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverClaimsResponse.fromBuffer(value));
  static final _$getMyCoverClaimById = $grpc.ClientMethod<
          $1.GetMyCoverClaimByIdRequest, $1.GetMyCoverClaimByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverClaimById',
      ($1.GetMyCoverClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverClaimByIdResponse.fromBuffer(value));
  static final _$fileCreditLifeClaim = $grpc.ClientMethod<
          $1.FileCreditLifeClaimRequest, $1.FileCreditLifeClaimResponse>(
      '/financialproducts.FinancialProductsService/FileCreditLifeClaim',
      ($1.FileCreditLifeClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.FileCreditLifeClaimResponse.fromBuffer(value));
  static final _$getInsuranceStates = $grpc.ClientMethod<
          $1.GetInsuranceStatesRequest, $1.GetInsuranceStatesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceStates',
      ($1.GetInsuranceStatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceStatesResponse.fromBuffer(value));
  static final _$getInsuranceVehicleMakes = $grpc.ClientMethod<
          $1.GetInsuranceVehicleMakesRequest,
          $1.GetInsuranceVehicleMakesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceVehicleMakes',
      ($1.GetInsuranceVehicleMakesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceVehicleMakesResponse.fromBuffer(value));
  static final _$getMyCoverNotificationPreferences = $grpc.ClientMethod<
          $1.GetMyCoverNotificationPreferencesRequest,
          $1.GetMyCoverNotificationPreferencesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverNotificationPreferences',
      ($1.GetMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$updateMyCoverNotificationPreferences = $grpc.ClientMethod<
          $1.UpdateMyCoverNotificationPreferencesRequest,
          $1.UpdateMyCoverNotificationPreferencesResponse>(
      '/financialproducts.FinancialProductsService/UpdateMyCoverNotificationPreferences',
      ($1.UpdateMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$getMyCoverWalletBalance = $grpc.ClientMethod<
          $1.GetMyCoverWalletBalanceRequest,
          $1.GetMyCoverWalletBalanceResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverWalletBalance',
      ($1.GetMyCoverWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetMyCoverWalletBalanceResponse.fromBuffer(value));
  static final _$requestInsuranceRefund = $grpc.ClientMethod<
          $1.RequestInsuranceRefundRequest, $1.RequestInsuranceRefundResponse>(
      '/financialproducts.FinancialProductsService/RequestInsuranceRefund',
      ($1.RequestInsuranceRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RequestInsuranceRefundResponse.fromBuffer(value));
  static final _$getInsuranceRefundStatus = $grpc.ClientMethod<
          $1.GetInsuranceRefundStatusRequest,
          $1.GetInsuranceRefundStatusResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceRefundStatus',
      ($1.GetInsuranceRefundStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceRefundStatusResponse.fromBuffer(value));
  static final _$getInsuranceReconciliationOverview = $grpc.ClientMethod<
          $1.GetInsuranceReconciliationOverviewRequest,
          $1.GetInsuranceReconciliationOverviewResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceReconciliationOverview',
      ($1.GetInsuranceReconciliationOverviewRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceReconciliationOverviewResponse.fromBuffer(value));
  static final _$getOrphanedInsuranceTransactions = $grpc.ClientMethod<
          $1.GetOrphanedInsuranceTransactionsRequest,
          $1.GetOrphanedInsuranceTransactionsResponse>(
      '/financialproducts.FinancialProductsService/GetOrphanedInsuranceTransactions',
      ($1.GetOrphanedInsuranceTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetOrphanedInsuranceTransactionsResponse.fromBuffer(value));
  static final _$manualReconcilePurchase = $grpc.ClientMethod<
          $1.ManualReconcilePurchaseRequest,
          $1.ManualReconcilePurchaseResponse>(
      '/financialproducts.FinancialProductsService/ManualReconcilePurchase',
      ($1.ManualReconcilePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ManualReconcilePurchaseResponse.fromBuffer(value));
  static final _$adminTriggerRefund = $grpc.ClientMethod<
          $1.AdminTriggerRefundRequest, $1.AdminTriggerRefundResponse>(
      '/financialproducts.FinancialProductsService/AdminTriggerRefund',
      ($1.AdminTriggerRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AdminTriggerRefundResponse.fromBuffer(value));
  static final _$getInsuranceWebhookEvents = $grpc.ClientMethod<
          $1.GetInsuranceWebhookEventsRequest,
          $1.GetInsuranceWebhookEventsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceWebhookEvents',
      ($1.GetInsuranceWebhookEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsuranceWebhookEventsResponse.fromBuffer(value));
  static final _$retryFailedWebhookEvent = $grpc.ClientMethod<
          $1.RetryFailedWebhookEventRequest,
          $1.RetryFailedWebhookEventResponse>(
      '/financialproducts.FinancialProductsService/RetryFailedWebhookEvent',
      ($1.RetryFailedWebhookEventRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RetryFailedWebhookEventResponse.fromBuffer(value));
  static final _$getFailedInsuranceTransactions = $grpc.ClientMethod<
          $1.GetFailedInsuranceTransactionsRequest,
          $1.GetFailedInsuranceTransactionsResponse>(
      '/financialproducts.FinancialProductsService/GetFailedInsuranceTransactions',
      ($1.GetFailedInsuranceTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetFailedInsuranceTransactionsResponse.fromBuffer(value));
  static final _$updateProductMargin = $grpc.ClientMethod<
          $1.UpdateProductMarginRequest, $1.UpdateProductMarginResponse>(
      '/financialproducts.FinancialProductsService/UpdateProductMargin',
      ($1.UpdateProductMarginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateProductMarginResponse.fromBuffer(value));
  static final _$getInsurancePlatformWallets = $grpc.ClientMethod<
          $1.GetInsurancePlatformWalletsRequest,
          $1.GetInsurancePlatformWalletsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlatformWallets',
      ($1.GetInsurancePlatformWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInsurancePlatformWalletsResponse.fromBuffer(value));
  static final _$createCrowdfund =
      $grpc.ClientMethod<$1.CreateCrowdfundRequest, $1.CreateCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CreateCrowdfund',
          ($1.CreateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfunds =
      $grpc.ClientMethod<$1.GetCrowdfundsRequest, $1.GetCrowdfundsResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfunds',
          ($1.GetCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetCrowdfundsResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$1.GetCrowdfundRequest, $1.GetCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfund',
          ($1.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetCrowdfundResponse.fromBuffer(value));
  static final _$contributeToCrowdfund = $grpc.ClientMethod<
          $1.ContributeToCrowdfundRequest, $1.ContributeToCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ContributeToCrowdfund',
      ($1.ContributeToCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ContributeToCrowdfundResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<
          $1.WithdrawFromCrowdfundRequest, $1.WithdrawFromCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromCrowdfund',
      ($1.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundWithdrawalFeeQuote = $grpc.ClientMethod<
          $1.GetCrowdfundWithdrawalFeeQuoteRequest,
          $1.GetCrowdfundWithdrawalFeeQuoteResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundWithdrawalFeeQuote',
      ($1.GetCrowdfundWithdrawalFeeQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCrowdfundWithdrawalFeeQuoteResponse.fromBuffer(value));
  static final _$listCrowdfundCustomCategories = $grpc.ClientMethod<
          $1.ListCrowdfundCustomCategoriesRequest,
          $1.ListCrowdfundCustomCategoriesResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundCustomCategories',
      ($1.ListCrowdfundCustomCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ListCrowdfundCustomCategoriesResponse.fromBuffer(value));
  static final _$addCrowdfundCustomCategory = $grpc.ClientMethod<
          $1.AddCrowdfundCustomCategoryRequest,
          $1.AddCrowdfundCustomCategoryResponse>(
      '/financialproducts.FinancialProductsService/AddCrowdfundCustomCategory',
      ($1.AddCrowdfundCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AddCrowdfundCustomCategoryResponse.fromBuffer(value));
  static final _$deleteCrowdfundCustomCategory = $grpc.ClientMethod<
          $1.DeleteCrowdfundCustomCategoryRequest,
          $1.DeleteCrowdfundCustomCategoryResponse>(
      '/financialproducts.FinancialProductsService/DeleteCrowdfundCustomCategory',
      ($1.DeleteCrowdfundCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteCrowdfundCustomCategoryResponse.fromBuffer(value));
  static final _$listCrowdfundWithdrawals = $grpc.ClientMethod<
          $1.ListCrowdfundWithdrawalsRequest,
          $1.ListCrowdfundWithdrawalsResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundWithdrawals',
      ($1.ListCrowdfundWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ListCrowdfundWithdrawalsResponse.fromBuffer(value));
  static final _$closeCrowdfund =
      $grpc.ClientMethod<$1.CloseCrowdfundRequest, $1.CloseCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CloseCrowdfund',
          ($1.CloseCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CloseCrowdfundResponse.fromBuffer(value));
  static final _$cancelCrowdfund =
      $grpc.ClientMethod<$1.CancelCrowdfundRequest, $1.CancelCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CancelCrowdfund',
          ($1.CancelCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CancelCrowdfundResponse.fromBuffer(value));
  static final _$forceCompleteCrowdfund = $grpc.ClientMethod<
          $1.ForceCompleteCrowdfundRequest, $1.ForceCompleteCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ForceCompleteCrowdfund',
      ($1.ForceCompleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ForceCompleteCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfundRefunds = $grpc.ClientMethod<
          $1.ListCrowdfundRefundsRequest, $1.ListCrowdfundRefundsResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundRefunds',
      ($1.ListCrowdfundRefundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ListCrowdfundRefundsResponse.fromBuffer(value));
  static final _$retryCrowdfundRefund = $grpc.ClientMethod<
          $1.RetryCrowdfundRefundRequest, $1.RetryCrowdfundRefundResponse>(
      '/financialproducts.FinancialProductsService/RetryCrowdfundRefund',
      ($1.RetryCrowdfundRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RetryCrowdfundRefundResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $1.GetCrowdfundStatisticsRequest, $1.GetCrowdfundStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundStatistics',
      ($1.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $1.SearchCrowdfundsRequest, $1.SearchCrowdfundsResponse>(
      '/financialproducts.FinancialProductsService/SearchCrowdfunds',
      ($1.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund =
      $grpc.ClientMethod<$1.UpdateCrowdfundRequest, $1.UpdateCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/UpdateCrowdfund',
          ($1.UpdateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund =
      $grpc.ClientMethod<$1.DeleteCrowdfundRequest, $1.DeleteCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/DeleteCrowdfund',
          ($1.DeleteCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $1.GetCrowdfundDonationsRequest, $1.GetCrowdfundDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundDonations',
      ($1.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $1.GetUserDonationsRequest, $1.GetUserDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetUserDonations',
      ($1.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $1.GenerateDonationReceiptRequest,
          $1.GenerateDonationReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateDonationReceipt',
      ($1.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $1.GetUserCrowdfundReceiptsRequest,
          $1.GetUserCrowdfundReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserCrowdfundReceipts',
      ($1.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<
          $1.ConnectNotificationChannelRequest,
          $1.ConnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/ConnectNotificationChannel',
      ($1.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<
          $1.DisconnectNotificationChannelRequest,
          $1.DisconnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/DisconnectNotificationChannel',
      ($1.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<
          $1.GetNotificationChannelsRequest,
          $1.GetNotificationChannelsResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationChannels',
      ($1.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<
          $1.UpdateNotificationChannelRequest,
          $1.UpdateNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/UpdateNotificationChannel',
      ($1.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<
          $1.TestNotificationChannelRequest,
          $1.TestNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/TestNotificationChannel',
      ($1.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<
          $1.GetTelegramBotInfoRequest, $1.GetTelegramBotInfoResponse>(
      '/financialproducts.FinancialProductsService/GetTelegramBotInfo',
      ($1.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<
          $1.VerifyTelegramChannelRequest, $1.VerifyTelegramChannelResponse>(
      '/financialproducts.FinancialProductsService/VerifyTelegramChannel',
      ($1.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<
          $1.GetNotificationHistoryRequest, $1.GetNotificationHistoryResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationHistory',
      ($1.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetNotificationHistoryResponse.fromBuffer(value));
  static final _$getCrowdfundLeaderboard = $grpc.ClientMethod<
          $1.GetCrowdfundLeaderboardRequest,
          $1.GetCrowdfundLeaderboardResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundLeaderboard',
      ($1.GetCrowdfundLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCrowdfundLeaderboardResponse.fromBuffer(value));
  static final _$createAutoSaveRule = $grpc.ClientMethod<
          $1.CreateAutoSaveRuleRequest2, $1.CreateAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/CreateAutoSaveRule',
      ($1.CreateAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateAutoSaveRuleResponse2.fromBuffer(value));
  static final _$getAutoSaveRules = $grpc.ClientMethod<
          $1.GetAutoSaveRulesRequest2, $1.GetAutoSaveRulesResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveRules',
      ($1.GetAutoSaveRulesRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAutoSaveRulesResponse2.fromBuffer(value));
  static final _$updateAutoSaveRule = $grpc.ClientMethod<
          $1.UpdateAutoSaveRuleRequest2, $1.UpdateAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/UpdateAutoSaveRule',
      ($1.UpdateAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateAutoSaveRuleResponse2.fromBuffer(value));
  static final _$toggleAutoSaveRule = $grpc.ClientMethod<
          $1.ToggleAutoSaveRuleRequest2, $1.ToggleAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/ToggleAutoSaveRule',
      ($1.ToggleAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ToggleAutoSaveRuleResponse2.fromBuffer(value));
  static final _$deleteAutoSaveRule = $grpc.ClientMethod<
          $1.DeleteAutoSaveRuleRequest2, $1.DeleteAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/DeleteAutoSaveRule',
      ($1.DeleteAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteAutoSaveRuleResponse2.fromBuffer(value));
  static final _$getAutoSaveTransactions = $grpc.ClientMethod<
          $1.GetAutoSaveTransactionsRequest2,
          $1.GetAutoSaveTransactionsResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveTransactions',
      ($1.GetAutoSaveTransactionsRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAutoSaveTransactionsResponse2.fromBuffer(value));
  static final _$getAutoSaveStatistics = $grpc.ClientMethod<
          $1.GetAutoSaveStatisticsRequest2, $1.GetAutoSaveStatisticsResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveStatistics',
      ($1.GetAutoSaveStatisticsRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAutoSaveStatisticsResponse2.fromBuffer(value));
  static final _$triggerAutoSave = $grpc.ClientMethod<
          $1.TriggerAutoSaveRequest2, $1.TriggerAutoSaveResponse2>(
      '/financialproducts.FinancialProductsService/TriggerAutoSave',
      ($1.TriggerAutoSaveRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.TriggerAutoSaveResponse2.fromBuffer(value));

  FinancialProductsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.CreateGroupAccountResponse> createGroupAccount(
      $1.CreateGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetGroupAccountsResponse> getGroupAccounts(
      $1.GetGroupAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetGroupAccountResponse> getGroupAccount(
      $1.GetGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.AddGroupMemberResponse> addGroupMember(
      $1.AddGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$1.RemoveGroupMemberResponse> removeGroupMember(
      $1.RemoveGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$1.ContributeToGroupResponse> contributeToGroup(
      $1.ContributeToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$1.WithdrawFromGroupResponse> withdrawFromGroup(
      $1.WithdrawFromGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromGroup, request, options: options);
  }

  $grpc.ResponseFuture<$1.CloseGroupAccountResponse> closeGroupAccount(
      $1.CloseGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.BuyInsuranceResponse> buyInsurance(
      $1.BuyInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePoliciesResponse> getInsurancePolicies(
      $1.GetInsurancePoliciesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicies, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePolicyResponse> getInsurancePolicy(
      $1.GetInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$1.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $1.MakeInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$1.CancelInsuranceResponse> cancelInsurance(
      $1.CancelInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePlansResponse> getInsurancePlans(
      $1.GetInsurancePlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlans, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts(
          $1.GetInsuranceMarketplaceProductsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceMarketplaceProducts, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories(
          $1.GetInsuranceMarketplaceCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceMarketplaceCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceQuoteResponse> getInsuranceQuote(
      $1.GetInsuranceQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceQuote, request, options: options);
  }

  $grpc.ResponseFuture<$1.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance(
          $1.PurchaseMarketplaceInsuranceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseMarketplaceInsurance, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($1.GetInsurancePurchaseStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePurchaseStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument($1.UploadInsuranceDocumentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInsuranceDocument, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL(
          $1.GetInsuranceDocumentUploadURLRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceDocumentUploadURL, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData($1.GetInsuranceAuxiliaryDataRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceAuxiliaryData, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePaymentsResponse> getInsurancePayments(
      $1.GetInsurancePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserInsurancePaymentsResponse>
      getUserInsurancePayments($1.GetUserInsurancePaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurancePayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateInsurancePaymentResponse>
      createInsurancePayment($1.CreateInsurancePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurancePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ProcessInsurancePaymentResponse>
      processInsurancePayment($1.ProcessInsurancePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInsurancePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePaymentByIdResponse>
      getInsurancePaymentById($1.GetInsurancePaymentByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePaymentById, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments($1.GetOverdueInsurancePaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueInsurancePayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceClaimsResponse> getInsuranceClaims(
      $1.GetInsuranceClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserInsuranceClaimsResponse>
      getUserInsuranceClaims($1.GetUserInsuranceClaimsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsuranceClaims, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateInsuranceClaimResponse> updateInsuranceClaim(
      $1.UpdateInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceClaimByIdResponse> getInsuranceClaimById(
      $1.GetInsuranceClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateInsurancePolicyResponse> updateInsurancePolicy(
      $1.UpdateInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$1.GenerateInsuranceReceiptResponse>
      generateInsuranceReceipt($1.GenerateInsuranceReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInsuranceReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetUserInsuranceReceiptsResponse>
      getUserInsuranceReceipts($1.GetUserInsuranceReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsuranceReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceStatisticsResponse>
      getInsuranceStatistics($1.GetInsuranceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics(
          $1.GetInsurancePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $1.GetMyCoverCustomersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomers, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverCustomerByIdResponse>
      getMyCoverCustomerById($1.GetMyCoverCustomerByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerById, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($1.GetMyCoverCustomerPoliciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPolicies, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($1.GetMyCoverCustomerPurchasesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPurchases, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $1.GetMyCoverPurchasesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchases, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverPurchaseByIdResponse>
      getMyCoverPurchaseById($1.GetMyCoverPurchaseByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchaseById, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverClaimsResponse> getMyCoverClaims(
      $1.GetMyCoverClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaims, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $1.GetMyCoverClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$1.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $1.FileCreditLifeClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fileCreditLifeClaim, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceStatesResponse> getInsuranceStates(
      $1.GetInsuranceStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStates, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes($1.GetInsuranceVehicleMakesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceVehicleMakes, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences(
          $1.GetMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences(
          $1.UpdateMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance($1.GetMyCoverWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.RequestInsuranceRefundResponse>
      requestInsuranceRefund($1.RequestInsuranceRefundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInsuranceRefund, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus($1.GetInsuranceRefundStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceRefundStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview(
          $1.GetInsuranceReconciliationOverviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceReconciliationOverview, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions(
          $1.GetOrphanedInsuranceTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrphanedInsuranceTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ManualReconcilePurchaseResponse>
      manualReconcilePurchase($1.ManualReconcilePurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$manualReconcilePurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AdminTriggerRefundResponse> adminTriggerRefund(
      $1.AdminTriggerRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminTriggerRefund, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents($1.GetInsuranceWebhookEventsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceWebhookEvents, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.RetryFailedWebhookEventResponse>
      retryFailedWebhookEvent($1.RetryFailedWebhookEventRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryFailedWebhookEvent, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions(
          $1.GetFailedInsuranceTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFailedInsuranceTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateProductMarginResponse> updateProductMargin(
      $1.UpdateProductMarginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateProductMargin, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets($1.GetInsurancePlatformWalletsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlatformWallets, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateCrowdfundResponse> createCrowdfund(
      $1.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCrowdfundsResponse> getCrowdfunds(
      $1.GetCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCrowdfundResponse> getCrowdfund(
      $1.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $1.ContributeToCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $1.WithdrawFromCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote(
          $1.GetCrowdfundWithdrawalFeeQuoteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundWithdrawalFeeQuote, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories(
          $1.ListCrowdfundCustomCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundCustomCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory($1.AddCrowdfundCustomCategoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addCrowdfundCustomCategory, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory(
          $1.DeleteCrowdfundCustomCategoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfundCustomCategory, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ListCrowdfundWithdrawalsResponse>
      listCrowdfundWithdrawals($1.ListCrowdfundWithdrawalsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundWithdrawals, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CloseCrowdfundResponse> closeCrowdfund(
      $1.CloseCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.CancelCrowdfundResponse> cancelCrowdfund(
      $1.CancelCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.ForceCompleteCrowdfundResponse>
      forceCompleteCrowdfund($1.ForceCompleteCrowdfundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forceCompleteCrowdfund, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ListCrowdfundRefundsResponse> listCrowdfundRefunds(
      $1.ListCrowdfundRefundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundRefunds, request, options: options);
  }

  $grpc.ResponseFuture<$1.RetryCrowdfundRefundResponse> retryCrowdfundRefund(
      $1.RetryCrowdfundRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryCrowdfundRefund, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($1.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.SearchCrowdfundsResponse> searchCrowdfunds(
      $1.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateCrowdfundResponse> updateCrowdfund(
      $1.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteCrowdfundResponse> deleteCrowdfund(
      $1.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $1.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserDonationsResponse> getUserDonations(
      $1.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$1.GenerateDonationReceiptResponse>
      generateDonationReceipt($1.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($1.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ConnectNotificationChannelResponse>
      connectNotificationChannel($1.ConnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel(
          $1.DisconnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetNotificationChannelsResponse>
      getNotificationChannels($1.GetNotificationChannelsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateNotificationChannelResponse>
      updateNotificationChannel($1.UpdateNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.TestNotificationChannelResponse>
      testNotificationChannel($1.TestNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $1.GetTelegramBotInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $1.VerifyTelegramChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetNotificationHistoryResponse>
      getNotificationHistory($1.GetNotificationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetCrowdfundLeaderboardResponse>
      getCrowdfundLeaderboard($1.GetCrowdfundLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateAutoSaveRuleResponse2> createAutoSaveRule(
      $1.CreateAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAutoSaveRulesResponse2> getAutoSaveRules(
      $1.GetAutoSaveRulesRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveRules, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateAutoSaveRuleResponse2> updateAutoSaveRule(
      $1.UpdateAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$1.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule(
      $1.ToggleAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule(
      $1.DeleteAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAutoSaveTransactionsResponse2>
      getAutoSaveTransactions($1.GetAutoSaveTransactionsRequest2 request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics(
      $1.GetAutoSaveStatisticsRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$1.TriggerAutoSaveResponse2> triggerAutoSave(
      $1.TriggerAutoSaveRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoSave, request, options: options);
  }
}

abstract class FinancialProductsServiceBase extends $grpc.Service {
  $core.String get $name => 'financialproducts.FinancialProductsService';

  FinancialProductsServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.CreateGroupAccountRequest,
            $1.CreateGroupAccountResponse>(
        'CreateGroupAccount',
        createGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateGroupAccountRequest.fromBuffer(value),
        ($1.CreateGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetGroupAccountsRequest,
            $1.GetGroupAccountsResponse>(
        'GetGroupAccounts',
        getGroupAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetGroupAccountsRequest.fromBuffer(value),
        ($1.GetGroupAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetGroupAccountRequest,
            $1.GetGroupAccountResponse>(
        'GetGroupAccount',
        getGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetGroupAccountRequest.fromBuffer(value),
        ($1.GetGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddGroupMemberRequest,
            $1.AddGroupMemberResponse>(
        'AddGroupMember',
        addGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AddGroupMemberRequest.fromBuffer(value),
        ($1.AddGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemoveGroupMemberRequest,
            $1.RemoveGroupMemberResponse>(
        'RemoveGroupMember',
        removeGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RemoveGroupMemberRequest.fromBuffer(value),
        ($1.RemoveGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ContributeToGroupRequest,
            $1.ContributeToGroupResponse>(
        'ContributeToGroup',
        contributeToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ContributeToGroupRequest.fromBuffer(value),
        ($1.ContributeToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.WithdrawFromGroupRequest,
            $1.WithdrawFromGroupResponse>(
        'WithdrawFromGroup',
        withdrawFromGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.WithdrawFromGroupRequest.fromBuffer(value),
        ($1.WithdrawFromGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CloseGroupAccountRequest,
            $1.CloseGroupAccountResponse>(
        'CloseGroupAccount',
        closeGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CloseGroupAccountRequest.fromBuffer(value),
        ($1.CloseGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.BuyInsuranceRequest, $1.BuyInsuranceResponse>(
            'BuyInsurance',
            buyInsurance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.BuyInsuranceRequest.fromBuffer(value),
            ($1.BuyInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePoliciesRequest,
            $1.GetInsurancePoliciesResponse>(
        'GetInsurancePolicies',
        getInsurancePolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePoliciesRequest.fromBuffer(value),
        ($1.GetInsurancePoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePolicyRequest,
            $1.GetInsurancePolicyResponse>(
        'GetInsurancePolicy',
        getInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePolicyRequest.fromBuffer(value),
        ($1.GetInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MakeInsuranceClaimRequest,
            $1.MakeInsuranceClaimResponse>(
        'MakeInsuranceClaim',
        makeInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MakeInsuranceClaimRequest.fromBuffer(value),
        ($1.MakeInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CancelInsuranceRequest,
            $1.CancelInsuranceResponse>(
        'CancelInsurance',
        cancelInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CancelInsuranceRequest.fromBuffer(value),
        ($1.CancelInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePlansRequest,
            $1.GetInsurancePlansResponse>(
        'GetInsurancePlans',
        getInsurancePlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePlansRequest.fromBuffer(value),
        ($1.GetInsurancePlansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceMarketplaceProductsRequest,
            $1.GetInsuranceMarketplaceProductsResponse>(
        'GetInsuranceMarketplaceProducts',
        getInsuranceMarketplaceProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceMarketplaceProductsRequest.fromBuffer(value),
        ($1.GetInsuranceMarketplaceProductsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceMarketplaceCategoriesRequest,
            $1.GetInsuranceMarketplaceCategoriesResponse>(
        'GetInsuranceMarketplaceCategories',
        getInsuranceMarketplaceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceMarketplaceCategoriesRequest.fromBuffer(value),
        ($1.GetInsuranceMarketplaceCategoriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceQuoteRequest,
            $1.GetInsuranceQuoteResponse>(
        'GetInsuranceQuote',
        getInsuranceQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceQuoteRequest.fromBuffer(value),
        ($1.GetInsuranceQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PurchaseMarketplaceInsuranceRequest,
            $1.PurchaseMarketplaceInsuranceResponse>(
        'PurchaseMarketplaceInsurance',
        purchaseMarketplaceInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PurchaseMarketplaceInsuranceRequest.fromBuffer(value),
        ($1.PurchaseMarketplaceInsuranceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePurchaseStatusRequest,
            $1.GetInsurancePurchaseStatusResponse>(
        'GetInsurancePurchaseStatus',
        getInsurancePurchaseStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePurchaseStatusRequest.fromBuffer(value),
        ($1.GetInsurancePurchaseStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UploadInsuranceDocumentRequest,
            $1.UploadInsuranceDocumentResponse>(
        'UploadInsuranceDocument',
        uploadInsuranceDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UploadInsuranceDocumentRequest.fromBuffer(value),
        ($1.UploadInsuranceDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceDocumentUploadURLRequest,
            $1.GetInsuranceDocumentUploadURLResponse>(
        'GetInsuranceDocumentUploadURL',
        getInsuranceDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceDocumentUploadURLRequest.fromBuffer(value),
        ($1.GetInsuranceDocumentUploadURLResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceAuxiliaryDataRequest,
            $1.GetInsuranceAuxiliaryDataResponse>(
        'GetInsuranceAuxiliaryData',
        getInsuranceAuxiliaryData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceAuxiliaryDataRequest.fromBuffer(value),
        ($1.GetInsuranceAuxiliaryDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePaymentsRequest,
            $1.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePaymentsRequest.fromBuffer(value),
        ($1.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserInsurancePaymentsRequest,
            $1.GetUserInsurancePaymentsResponse>(
        'GetUserInsurancePayments',
        getUserInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetUserInsurancePaymentsRequest.fromBuffer(value),
        ($1.GetUserInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateInsurancePaymentRequest,
            $1.CreateInsurancePaymentResponse>(
        'CreateInsurancePayment',
        createInsurancePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateInsurancePaymentRequest.fromBuffer(value),
        ($1.CreateInsurancePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProcessInsurancePaymentRequest,
            $1.ProcessInsurancePaymentResponse>(
        'ProcessInsurancePayment',
        processInsurancePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ProcessInsurancePaymentRequest.fromBuffer(value),
        ($1.ProcessInsurancePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePaymentByIdRequest,
            $1.GetInsurancePaymentByIdResponse>(
        'GetInsurancePaymentById',
        getInsurancePaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePaymentByIdRequest.fromBuffer(value),
        ($1.GetInsurancePaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetOverdueInsurancePaymentsRequest,
            $1.GetOverdueInsurancePaymentsResponse>(
        'GetOverdueInsurancePayments',
        getOverdueInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetOverdueInsurancePaymentsRequest.fromBuffer(value),
        ($1.GetOverdueInsurancePaymentsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceClaimsRequest,
            $1.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceClaimsRequest.fromBuffer(value),
        ($1.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserInsuranceClaimsRequest,
            $1.GetUserInsuranceClaimsResponse>(
        'GetUserInsuranceClaims',
        getUserInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetUserInsuranceClaimsRequest.fromBuffer(value),
        ($1.GetUserInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateInsuranceClaimRequest,
            $1.UpdateInsuranceClaimResponse>(
        'UpdateInsuranceClaim',
        updateInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateInsuranceClaimRequest.fromBuffer(value),
        ($1.UpdateInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceClaimByIdRequest,
            $1.GetInsuranceClaimByIdResponse>(
        'GetInsuranceClaimById',
        getInsuranceClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceClaimByIdRequest.fromBuffer(value),
        ($1.GetInsuranceClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateInsurancePolicyRequest,
            $1.UpdateInsurancePolicyResponse>(
        'UpdateInsurancePolicy',
        updateInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateInsurancePolicyRequest.fromBuffer(value),
        ($1.UpdateInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GenerateInsuranceReceiptRequest,
            $1.GenerateInsuranceReceiptResponse>(
        'GenerateInsuranceReceipt',
        generateInsuranceReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GenerateInsuranceReceiptRequest.fromBuffer(value),
        ($1.GenerateInsuranceReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserInsuranceReceiptsRequest,
            $1.GetUserInsuranceReceiptsResponse>(
        'GetUserInsuranceReceipts',
        getUserInsuranceReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetUserInsuranceReceiptsRequest.fromBuffer(value),
        ($1.GetUserInsuranceReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceStatisticsRequest,
            $1.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($1.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePaymentStatisticsRequest,
            $1.GetInsurancePaymentStatisticsResponse>(
        'GetInsurancePaymentStatistics',
        getInsurancePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePaymentStatisticsRequest.fromBuffer(value),
        ($1.GetInsurancePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverCustomersRequest,
            $1.GetMyCoverCustomersResponse>(
        'GetMyCoverCustomers',
        getMyCoverCustomers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverCustomersRequest.fromBuffer(value),
        ($1.GetMyCoverCustomersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverCustomerByIdRequest,
            $1.GetMyCoverCustomerByIdResponse>(
        'GetMyCoverCustomerById',
        getMyCoverCustomerById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverCustomerByIdRequest.fromBuffer(value),
        ($1.GetMyCoverCustomerByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverCustomerPoliciesRequest,
            $1.GetMyCoverCustomerPoliciesResponse>(
        'GetMyCoverCustomerPolicies',
        getMyCoverCustomerPolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverCustomerPoliciesRequest.fromBuffer(value),
        ($1.GetMyCoverCustomerPoliciesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverCustomerPurchasesRequest,
            $1.GetMyCoverCustomerPurchasesResponse>(
        'GetMyCoverCustomerPurchases',
        getMyCoverCustomerPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverCustomerPurchasesRequest.fromBuffer(value),
        ($1.GetMyCoverCustomerPurchasesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverPurchasesRequest,
            $1.GetMyCoverPurchasesResponse>(
        'GetMyCoverPurchases',
        getMyCoverPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverPurchasesRequest.fromBuffer(value),
        ($1.GetMyCoverPurchasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverPurchaseByIdRequest,
            $1.GetMyCoverPurchaseByIdResponse>(
        'GetMyCoverPurchaseById',
        getMyCoverPurchaseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverPurchaseByIdRequest.fromBuffer(value),
        ($1.GetMyCoverPurchaseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverClaimsRequest,
            $1.GetMyCoverClaimsResponse>(
        'GetMyCoverClaims',
        getMyCoverClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverClaimsRequest.fromBuffer(value),
        ($1.GetMyCoverClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverClaimByIdRequest,
            $1.GetMyCoverClaimByIdResponse>(
        'GetMyCoverClaimById',
        getMyCoverClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverClaimByIdRequest.fromBuffer(value),
        ($1.GetMyCoverClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FileCreditLifeClaimRequest,
            $1.FileCreditLifeClaimResponse>(
        'FileCreditLifeClaim',
        fileCreditLifeClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.FileCreditLifeClaimRequest.fromBuffer(value),
        ($1.FileCreditLifeClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceStatesRequest,
            $1.GetInsuranceStatesResponse>(
        'GetInsuranceStates',
        getInsuranceStates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceStatesRequest.fromBuffer(value),
        ($1.GetInsuranceStatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceVehicleMakesRequest,
            $1.GetInsuranceVehicleMakesResponse>(
        'GetInsuranceVehicleMakes',
        getInsuranceVehicleMakes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceVehicleMakesRequest.fromBuffer(value),
        ($1.GetInsuranceVehicleMakesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverNotificationPreferencesRequest,
            $1.GetMyCoverNotificationPreferencesResponse>(
        'GetMyCoverNotificationPreferences',
        getMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($1.GetMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $1.UpdateMyCoverNotificationPreferencesRequest,
            $1.UpdateMyCoverNotificationPreferencesResponse>(
        'UpdateMyCoverNotificationPreferences',
        updateMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($1.UpdateMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetMyCoverWalletBalanceRequest,
            $1.GetMyCoverWalletBalanceResponse>(
        'GetMyCoverWalletBalance',
        getMyCoverWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetMyCoverWalletBalanceRequest.fromBuffer(value),
        ($1.GetMyCoverWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RequestInsuranceRefundRequest,
            $1.RequestInsuranceRefundResponse>(
        'RequestInsuranceRefund',
        requestInsuranceRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RequestInsuranceRefundRequest.fromBuffer(value),
        ($1.RequestInsuranceRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceRefundStatusRequest,
            $1.GetInsuranceRefundStatusResponse>(
        'GetInsuranceRefundStatus',
        getInsuranceRefundStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceRefundStatusRequest.fromBuffer(value),
        ($1.GetInsuranceRefundStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceReconciliationOverviewRequest,
            $1.GetInsuranceReconciliationOverviewResponse>(
        'GetInsuranceReconciliationOverview',
        getInsuranceReconciliationOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceReconciliationOverviewRequest.fromBuffer(value),
        ($1.GetInsuranceReconciliationOverviewResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetOrphanedInsuranceTransactionsRequest,
            $1.GetOrphanedInsuranceTransactionsResponse>(
        'GetOrphanedInsuranceTransactions',
        getOrphanedInsuranceTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetOrphanedInsuranceTransactionsRequest.fromBuffer(value),
        ($1.GetOrphanedInsuranceTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ManualReconcilePurchaseRequest,
            $1.ManualReconcilePurchaseResponse>(
        'ManualReconcilePurchase',
        manualReconcilePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ManualReconcilePurchaseRequest.fromBuffer(value),
        ($1.ManualReconcilePurchaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AdminTriggerRefundRequest,
            $1.AdminTriggerRefundResponse>(
        'AdminTriggerRefund',
        adminTriggerRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AdminTriggerRefundRequest.fromBuffer(value),
        ($1.AdminTriggerRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsuranceWebhookEventsRequest,
            $1.GetInsuranceWebhookEventsResponse>(
        'GetInsuranceWebhookEvents',
        getInsuranceWebhookEvents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsuranceWebhookEventsRequest.fromBuffer(value),
        ($1.GetInsuranceWebhookEventsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RetryFailedWebhookEventRequest,
            $1.RetryFailedWebhookEventResponse>(
        'RetryFailedWebhookEvent',
        retryFailedWebhookEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RetryFailedWebhookEventRequest.fromBuffer(value),
        ($1.RetryFailedWebhookEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetFailedInsuranceTransactionsRequest,
            $1.GetFailedInsuranceTransactionsResponse>(
        'GetFailedInsuranceTransactions',
        getFailedInsuranceTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetFailedInsuranceTransactionsRequest.fromBuffer(value),
        ($1.GetFailedInsuranceTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateProductMarginRequest,
            $1.UpdateProductMarginResponse>(
        'UpdateProductMargin',
        updateProductMargin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateProductMarginRequest.fromBuffer(value),
        ($1.UpdateProductMarginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInsurancePlatformWalletsRequest,
            $1.GetInsurancePlatformWalletsResponse>(
        'GetInsurancePlatformWallets',
        getInsurancePlatformWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInsurancePlatformWalletsRequest.fromBuffer(value),
        ($1.GetInsurancePlatformWalletsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateCrowdfundRequest,
            $1.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateCrowdfundRequest.fromBuffer(value),
        ($1.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetCrowdfundsRequest, $1.GetCrowdfundsResponse>(
            'GetCrowdfunds',
            getCrowdfunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetCrowdfundsRequest.fromBuffer(value),
            ($1.GetCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetCrowdfundRequest, $1.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetCrowdfundRequest.fromBuffer(value),
            ($1.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ContributeToCrowdfundRequest,
            $1.ContributeToCrowdfundResponse>(
        'ContributeToCrowdfund',
        contributeToCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ContributeToCrowdfundRequest.fromBuffer(value),
        ($1.ContributeToCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.WithdrawFromCrowdfundRequest,
            $1.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($1.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCrowdfundWithdrawalFeeQuoteRequest,
            $1.GetCrowdfundWithdrawalFeeQuoteResponse>(
        'GetCrowdfundWithdrawalFeeQuote',
        getCrowdfundWithdrawalFeeQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCrowdfundWithdrawalFeeQuoteRequest.fromBuffer(value),
        ($1.GetCrowdfundWithdrawalFeeQuoteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListCrowdfundCustomCategoriesRequest,
            $1.ListCrowdfundCustomCategoriesResponse>(
        'ListCrowdfundCustomCategories',
        listCrowdfundCustomCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ListCrowdfundCustomCategoriesRequest.fromBuffer(value),
        ($1.ListCrowdfundCustomCategoriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddCrowdfundCustomCategoryRequest,
            $1.AddCrowdfundCustomCategoryResponse>(
        'AddCrowdfundCustomCategory',
        addCrowdfundCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AddCrowdfundCustomCategoryRequest.fromBuffer(value),
        ($1.AddCrowdfundCustomCategoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteCrowdfundCustomCategoryRequest,
            $1.DeleteCrowdfundCustomCategoryResponse>(
        'DeleteCrowdfundCustomCategory',
        deleteCrowdfundCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteCrowdfundCustomCategoryRequest.fromBuffer(value),
        ($1.DeleteCrowdfundCustomCategoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListCrowdfundWithdrawalsRequest,
            $1.ListCrowdfundWithdrawalsResponse>(
        'ListCrowdfundWithdrawals',
        listCrowdfundWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ListCrowdfundWithdrawalsRequest.fromBuffer(value),
        ($1.ListCrowdfundWithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CloseCrowdfundRequest,
            $1.CloseCrowdfundResponse>(
        'CloseCrowdfund',
        closeCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CloseCrowdfundRequest.fromBuffer(value),
        ($1.CloseCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CancelCrowdfundRequest,
            $1.CancelCrowdfundResponse>(
        'CancelCrowdfund',
        cancelCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CancelCrowdfundRequest.fromBuffer(value),
        ($1.CancelCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ForceCompleteCrowdfundRequest,
            $1.ForceCompleteCrowdfundResponse>(
        'ForceCompleteCrowdfund',
        forceCompleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ForceCompleteCrowdfundRequest.fromBuffer(value),
        ($1.ForceCompleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListCrowdfundRefundsRequest,
            $1.ListCrowdfundRefundsResponse>(
        'ListCrowdfundRefunds',
        listCrowdfundRefunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ListCrowdfundRefundsRequest.fromBuffer(value),
        ($1.ListCrowdfundRefundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RetryCrowdfundRefundRequest,
            $1.RetryCrowdfundRefundResponse>(
        'RetryCrowdfundRefund',
        retryCrowdfundRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RetryCrowdfundRefundRequest.fromBuffer(value),
        ($1.RetryCrowdfundRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCrowdfundStatisticsRequest,
            $1.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($1.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SearchCrowdfundsRequest,
            $1.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SearchCrowdfundsRequest.fromBuffer(value),
        ($1.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCrowdfundRequest,
            $1.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCrowdfundRequest.fromBuffer(value),
        ($1.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteCrowdfundRequest,
            $1.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteCrowdfundRequest.fromBuffer(value),
        ($1.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCrowdfundDonationsRequest,
            $1.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($1.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserDonationsRequest,
            $1.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetUserDonationsRequest.fromBuffer(value),
        ($1.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GenerateDonationReceiptRequest,
            $1.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GenerateDonationReceiptRequest.fromBuffer(value),
        ($1.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserCrowdfundReceiptsRequest,
            $1.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($1.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ConnectNotificationChannelRequest,
            $1.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ConnectNotificationChannelRequest.fromBuffer(value),
        ($1.ConnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DisconnectNotificationChannelRequest,
            $1.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($1.DisconnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetNotificationChannelsRequest,
            $1.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetNotificationChannelsRequest.fromBuffer(value),
        ($1.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateNotificationChannelRequest,
            $1.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateNotificationChannelRequest.fromBuffer(value),
        ($1.UpdateNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.TestNotificationChannelRequest,
            $1.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.TestNotificationChannelRequest.fromBuffer(value),
        ($1.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetTelegramBotInfoRequest,
            $1.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetTelegramBotInfoRequest.fromBuffer(value),
        ($1.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyTelegramChannelRequest,
            $1.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.VerifyTelegramChannelRequest.fromBuffer(value),
        ($1.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetNotificationHistoryRequest,
            $1.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetNotificationHistoryRequest.fromBuffer(value),
        ($1.GetNotificationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCrowdfundLeaderboardRequest,
            $1.GetCrowdfundLeaderboardResponse>(
        'GetCrowdfundLeaderboard',
        getCrowdfundLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCrowdfundLeaderboardRequest.fromBuffer(value),
        ($1.GetCrowdfundLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateAutoSaveRuleRequest2,
            $1.CreateAutoSaveRuleResponse2>(
        'CreateAutoSaveRule',
        createAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateAutoSaveRuleRequest2.fromBuffer(value),
        ($1.CreateAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAutoSaveRulesRequest2,
            $1.GetAutoSaveRulesResponse2>(
        'GetAutoSaveRules',
        getAutoSaveRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAutoSaveRulesRequest2.fromBuffer(value),
        ($1.GetAutoSaveRulesResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateAutoSaveRuleRequest2,
            $1.UpdateAutoSaveRuleResponse2>(
        'UpdateAutoSaveRule',
        updateAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateAutoSaveRuleRequest2.fromBuffer(value),
        ($1.UpdateAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ToggleAutoSaveRuleRequest2,
            $1.ToggleAutoSaveRuleResponse2>(
        'ToggleAutoSaveRule',
        toggleAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ToggleAutoSaveRuleRequest2.fromBuffer(value),
        ($1.ToggleAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteAutoSaveRuleRequest2,
            $1.DeleteAutoSaveRuleResponse2>(
        'DeleteAutoSaveRule',
        deleteAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteAutoSaveRuleRequest2.fromBuffer(value),
        ($1.DeleteAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAutoSaveTransactionsRequest2,
            $1.GetAutoSaveTransactionsResponse2>(
        'GetAutoSaveTransactions',
        getAutoSaveTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAutoSaveTransactionsRequest2.fromBuffer(value),
        ($1.GetAutoSaveTransactionsResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAutoSaveStatisticsRequest2,
            $1.GetAutoSaveStatisticsResponse2>(
        'GetAutoSaveStatistics',
        getAutoSaveStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAutoSaveStatisticsRequest2.fromBuffer(value),
        ($1.GetAutoSaveStatisticsResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.TriggerAutoSaveRequest2,
            $1.TriggerAutoSaveResponse2>(
        'TriggerAutoSave',
        triggerAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.TriggerAutoSaveRequest2.fromBuffer(value),
        ($1.TriggerAutoSaveResponse2 value) => value.writeToBuffer()));
  }

  $async.Future<$1.CreateGroupAccountResponse> createGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateGroupAccountRequest> request) async {
    return createGroupAccount(call, await request);
  }

  $async.Future<$1.GetGroupAccountsResponse> getGroupAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetGroupAccountsRequest> request) async {
    return getGroupAccounts(call, await request);
  }

  $async.Future<$1.GetGroupAccountResponse> getGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetGroupAccountRequest> request) async {
    return getGroupAccount(call, await request);
  }

  $async.Future<$1.AddGroupMemberResponse> addGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AddGroupMemberRequest> request) async {
    return addGroupMember(call, await request);
  }

  $async.Future<$1.RemoveGroupMemberResponse> removeGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RemoveGroupMemberRequest> request) async {
    return removeGroupMember(call, await request);
  }

  $async.Future<$1.ContributeToGroupResponse> contributeToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ContributeToGroupRequest> request) async {
    return contributeToGroup(call, await request);
  }

  $async.Future<$1.WithdrawFromGroupResponse> withdrawFromGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.WithdrawFromGroupRequest> request) async {
    return withdrawFromGroup(call, await request);
  }

  $async.Future<$1.CloseGroupAccountResponse> closeGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CloseGroupAccountRequest> request) async {
    return closeGroupAccount(call, await request);
  }

  $async.Future<$1.BuyInsuranceResponse> buyInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.BuyInsuranceRequest> request) async {
    return buyInsurance(call, await request);
  }

  $async.Future<$1.GetInsurancePoliciesResponse> getInsurancePolicies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsurancePoliciesRequest> request) async {
    return getInsurancePolicies(call, await request);
  }

  $async.Future<$1.GetInsurancePolicyResponse> getInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsurancePolicyRequest> request) async {
    return getInsurancePolicy(call, await request);
  }

  $async.Future<$1.MakeInsuranceClaimResponse> makeInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.MakeInsuranceClaimRequest> request) async {
    return makeInsuranceClaim(call, await request);
  }

  $async.Future<$1.CancelInsuranceResponse> cancelInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CancelInsuranceRequest> request) async {
    return cancelInsurance(call, await request);
  }

  $async.Future<$1.GetInsurancePlansResponse> getInsurancePlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsurancePlansRequest> request) async {
    return getInsurancePlans(call, await request);
  }

  $async.Future<$1.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceMarketplaceProductsRequest>
              request) async {
    return getInsuranceMarketplaceProducts(call, await request);
  }

  $async.Future<$1.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceMarketplaceCategoriesRequest>
              request) async {
    return getInsuranceMarketplaceCategories(call, await request);
  }

  $async.Future<$1.GetInsuranceQuoteResponse> getInsuranceQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsuranceQuoteRequest> request) async {
    return getInsuranceQuote(call, await request);
  }

  $async.Future<$1.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance_Pre($grpc.ServiceCall call,
          $async.Future<$1.PurchaseMarketplaceInsuranceRequest> request) async {
    return purchaseMarketplaceInsurance(call, await request);
  }

  $async.Future<$1.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInsurancePurchaseStatusRequest> request) async {
    return getInsurancePurchaseStatus(call, await request);
  }

  $async.Future<$1.UploadInsuranceDocumentResponse> uploadInsuranceDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UploadInsuranceDocumentRequest> request) async {
    return uploadInsuranceDocument(call, await request);
  }

  $async.Future<$1.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceDocumentUploadURLRequest>
              request) async {
    return getInsuranceDocumentUploadURL(call, await request);
  }

  $async.Future<$1.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceAuxiliaryDataRequest> request) async {
    return getInsuranceAuxiliaryData(call, await request);
  }

  $async.Future<$1.GetInsurancePaymentsResponse> getInsurancePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$1.GetUserInsurancePaymentsResponse>
      getUserInsurancePayments_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetUserInsurancePaymentsRequest> request) async {
    return getUserInsurancePayments(call, await request);
  }

  $async.Future<$1.CreateInsurancePaymentResponse> createInsurancePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateInsurancePaymentRequest> request) async {
    return createInsurancePayment(call, await request);
  }

  $async.Future<$1.ProcessInsurancePaymentResponse> processInsurancePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ProcessInsurancePaymentRequest> request) async {
    return processInsurancePayment(call, await request);
  }

  $async.Future<$1.GetInsurancePaymentByIdResponse> getInsurancePaymentById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsurancePaymentByIdRequest> request) async {
    return getInsurancePaymentById(call, await request);
  }

  $async.Future<$1.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetOverdueInsurancePaymentsRequest> request) async {
    return getOverdueInsurancePayments(call, await request);
  }

  $async.Future<$1.GetInsuranceClaimsResponse> getInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$1.GetUserInsuranceClaimsResponse> getUserInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetUserInsuranceClaimsRequest> request) async {
    return getUserInsuranceClaims(call, await request);
  }

  $async.Future<$1.UpdateInsuranceClaimResponse> updateInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateInsuranceClaimRequest> request) async {
    return updateInsuranceClaim(call, await request);
  }

  $async.Future<$1.GetInsuranceClaimByIdResponse> getInsuranceClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsuranceClaimByIdRequest> request) async {
    return getInsuranceClaimById(call, await request);
  }

  $async.Future<$1.UpdateInsurancePolicyResponse> updateInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateInsurancePolicyRequest> request) async {
    return updateInsurancePolicy(call, await request);
  }

  $async.Future<$1.GenerateInsuranceReceiptResponse>
      generateInsuranceReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$1.GenerateInsuranceReceiptRequest> request) async {
    return generateInsuranceReceipt(call, await request);
  }

  $async.Future<$1.GetUserInsuranceReceiptsResponse>
      getUserInsuranceReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetUserInsuranceReceiptsRequest> request) async {
    return getUserInsuranceReceipts(call, await request);
  }

  $async.Future<$1.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$1.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetInsurancePaymentStatisticsRequest>
              request) async {
    return getInsurancePaymentStatistics(call, await request);
  }

  $async.Future<$1.GetMyCoverCustomersResponse> getMyCoverCustomers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverCustomersRequest> request) async {
    return getMyCoverCustomers(call, await request);
  }

  $async.Future<$1.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverCustomerByIdRequest> request) async {
    return getMyCoverCustomerById(call, await request);
  }

  $async.Future<$1.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetMyCoverCustomerPoliciesRequest> request) async {
    return getMyCoverCustomerPolicies(call, await request);
  }

  $async.Future<$1.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetMyCoverCustomerPurchasesRequest> request) async {
    return getMyCoverCustomerPurchases(call, await request);
  }

  $async.Future<$1.GetMyCoverPurchasesResponse> getMyCoverPurchases_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverPurchasesRequest> request) async {
    return getMyCoverPurchases(call, await request);
  }

  $async.Future<$1.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverPurchaseByIdRequest> request) async {
    return getMyCoverPurchaseById(call, await request);
  }

  $async.Future<$1.GetMyCoverClaimsResponse> getMyCoverClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverClaimsRequest> request) async {
    return getMyCoverClaims(call, await request);
  }

  $async.Future<$1.GetMyCoverClaimByIdResponse> getMyCoverClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverClaimByIdRequest> request) async {
    return getMyCoverClaimById(call, await request);
  }

  $async.Future<$1.FileCreditLifeClaimResponse> fileCreditLifeClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.FileCreditLifeClaimRequest> request) async {
    return fileCreditLifeClaim(call, await request);
  }

  $async.Future<$1.GetInsuranceStatesResponse> getInsuranceStates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInsuranceStatesRequest> request) async {
    return getInsuranceStates(call, await request);
  }

  $async.Future<$1.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceVehicleMakesRequest> request) async {
    return getInsuranceVehicleMakes(call, await request);
  }

  $async.Future<$1.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetMyCoverNotificationPreferencesRequest>
              request) async {
    return getMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$1.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.UpdateMyCoverNotificationPreferencesRequest>
              request) async {
    return updateMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$1.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetMyCoverWalletBalanceRequest> request) async {
    return getMyCoverWalletBalance(call, await request);
  }

  $async.Future<$1.RequestInsuranceRefundResponse> requestInsuranceRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RequestInsuranceRefundRequest> request) async {
    return requestInsuranceRefund(call, await request);
  }

  $async.Future<$1.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceRefundStatusRequest> request) async {
    return getInsuranceRefundStatus(call, await request);
  }

  $async.Future<$1.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceReconciliationOverviewRequest>
              request) async {
    return getInsuranceReconciliationOverview(call, await request);
  }

  $async.Future<$1.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetOrphanedInsuranceTransactionsRequest>
              request) async {
    return getOrphanedInsuranceTransactions(call, await request);
  }

  $async.Future<$1.ManualReconcilePurchaseResponse> manualReconcilePurchase_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ManualReconcilePurchaseRequest> request) async {
    return manualReconcilePurchase(call, await request);
  }

  $async.Future<$1.AdminTriggerRefundResponse> adminTriggerRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AdminTriggerRefundRequest> request) async {
    return adminTriggerRefund(call, await request);
  }

  $async.Future<$1.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInsuranceWebhookEventsRequest> request) async {
    return getInsuranceWebhookEvents(call, await request);
  }

  $async.Future<$1.RetryFailedWebhookEventResponse> retryFailedWebhookEvent_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RetryFailedWebhookEventRequest> request) async {
    return retryFailedWebhookEvent(call, await request);
  }

  $async.Future<$1.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetFailedInsuranceTransactionsRequest>
              request) async {
    return getFailedInsuranceTransactions(call, await request);
  }

  $async.Future<$1.UpdateProductMarginResponse> updateProductMargin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateProductMarginRequest> request) async {
    return updateProductMargin(call, await request);
  }

  $async.Future<$1.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInsurancePlatformWalletsRequest> request) async {
    return getInsurancePlatformWallets(call, await request);
  }

  $async.Future<$1.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$1.GetCrowdfundsResponse> getCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCrowdfundsRequest> request) async {
    return getCrowdfunds(call, await request);
  }

  $async.Future<$1.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$1.ContributeToCrowdfundResponse> contributeToCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ContributeToCrowdfundRequest> request) async {
    return contributeToCrowdfund(call, await request);
  }

  $async.Future<$1.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$1.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetCrowdfundWithdrawalFeeQuoteRequest>
              request) async {
    return getCrowdfundWithdrawalFeeQuote(call, await request);
  }

  $async.Future<$1.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.ListCrowdfundCustomCategoriesRequest>
              request) async {
    return listCrowdfundCustomCategories(call, await request);
  }

  $async.Future<$1.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory_Pre($grpc.ServiceCall call,
          $async.Future<$1.AddCrowdfundCustomCategoryRequest> request) async {
    return addCrowdfundCustomCategory(call, await request);
  }

  $async.Future<$1.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.DeleteCrowdfundCustomCategoryRequest>
              request) async {
    return deleteCrowdfundCustomCategory(call, await request);
  }

  $async.Future<$1.ListCrowdfundWithdrawalsResponse>
      listCrowdfundWithdrawals_Pre($grpc.ServiceCall call,
          $async.Future<$1.ListCrowdfundWithdrawalsRequest> request) async {
    return listCrowdfundWithdrawals(call, await request);
  }

  $async.Future<$1.CloseCrowdfundResponse> closeCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CloseCrowdfundRequest> request) async {
    return closeCrowdfund(call, await request);
  }

  $async.Future<$1.CancelCrowdfundResponse> cancelCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CancelCrowdfundRequest> request) async {
    return cancelCrowdfund(call, await request);
  }

  $async.Future<$1.ForceCompleteCrowdfundResponse> forceCompleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ForceCompleteCrowdfundRequest> request) async {
    return forceCompleteCrowdfund(call, await request);
  }

  $async.Future<$1.ListCrowdfundRefundsResponse> listCrowdfundRefunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ListCrowdfundRefundsRequest> request) async {
    return listCrowdfundRefunds(call, await request);
  }

  $async.Future<$1.RetryCrowdfundRefundResponse> retryCrowdfundRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RetryCrowdfundRefundRequest> request) async {
    return retryCrowdfundRefund(call, await request);
  }

  $async.Future<$1.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$1.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$1.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$1.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$1.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$1.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$1.GenerateDonationReceiptResponse> generateDonationReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$1.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$1.ConnectNotificationChannelResponse>
      connectNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$1.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$1.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.DisconnectNotificationChannelRequest>
              request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$1.GetNotificationChannelsResponse> getNotificationChannels_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$1.UpdateNotificationChannelResponse>
      updateNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$1.TestNotificationChannelResponse> testNotificationChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$1.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$1.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$1.GetNotificationHistoryResponse> getNotificationHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$1.GetCrowdfundLeaderboardResponse> getCrowdfundLeaderboard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCrowdfundLeaderboardRequest> request) async {
    return getCrowdfundLeaderboard(call, await request);
  }

  $async.Future<$1.CreateAutoSaveRuleResponse2> createAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateAutoSaveRuleRequest2> request) async {
    return createAutoSaveRule(call, await request);
  }

  $async.Future<$1.GetAutoSaveRulesResponse2> getAutoSaveRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAutoSaveRulesRequest2> request) async {
    return getAutoSaveRules(call, await request);
  }

  $async.Future<$1.UpdateAutoSaveRuleResponse2> updateAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateAutoSaveRuleRequest2> request) async {
    return updateAutoSaveRule(call, await request);
  }

  $async.Future<$1.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ToggleAutoSaveRuleRequest2> request) async {
    return toggleAutoSaveRule(call, await request);
  }

  $async.Future<$1.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteAutoSaveRuleRequest2> request) async {
    return deleteAutoSaveRule(call, await request);
  }

  $async.Future<$1.GetAutoSaveTransactionsResponse2>
      getAutoSaveTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetAutoSaveTransactionsRequest2> request) async {
    return getAutoSaveTransactions(call, await request);
  }

  $async.Future<$1.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAutoSaveStatisticsRequest2> request) async {
    return getAutoSaveStatistics(call, await request);
  }

  $async.Future<$1.TriggerAutoSaveResponse2> triggerAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.TriggerAutoSaveRequest2> request) async {
    return triggerAutoSave(call, await request);
  }

  $async.Future<$1.CreateGroupAccountResponse> createGroupAccount(
      $grpc.ServiceCall call, $1.CreateGroupAccountRequest request);
  $async.Future<$1.GetGroupAccountsResponse> getGroupAccounts(
      $grpc.ServiceCall call, $1.GetGroupAccountsRequest request);
  $async.Future<$1.GetGroupAccountResponse> getGroupAccount(
      $grpc.ServiceCall call, $1.GetGroupAccountRequest request);
  $async.Future<$1.AddGroupMemberResponse> addGroupMember(
      $grpc.ServiceCall call, $1.AddGroupMemberRequest request);
  $async.Future<$1.RemoveGroupMemberResponse> removeGroupMember(
      $grpc.ServiceCall call, $1.RemoveGroupMemberRequest request);
  $async.Future<$1.ContributeToGroupResponse> contributeToGroup(
      $grpc.ServiceCall call, $1.ContributeToGroupRequest request);
  $async.Future<$1.WithdrawFromGroupResponse> withdrawFromGroup(
      $grpc.ServiceCall call, $1.WithdrawFromGroupRequest request);
  $async.Future<$1.CloseGroupAccountResponse> closeGroupAccount(
      $grpc.ServiceCall call, $1.CloseGroupAccountRequest request);
  $async.Future<$1.BuyInsuranceResponse> buyInsurance(
      $grpc.ServiceCall call, $1.BuyInsuranceRequest request);
  $async.Future<$1.GetInsurancePoliciesResponse> getInsurancePolicies(
      $grpc.ServiceCall call, $1.GetInsurancePoliciesRequest request);
  $async.Future<$1.GetInsurancePolicyResponse> getInsurancePolicy(
      $grpc.ServiceCall call, $1.GetInsurancePolicyRequest request);
  $async.Future<$1.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $grpc.ServiceCall call, $1.MakeInsuranceClaimRequest request);
  $async.Future<$1.CancelInsuranceResponse> cancelInsurance(
      $grpc.ServiceCall call, $1.CancelInsuranceRequest request);
  $async.Future<$1.GetInsurancePlansResponse> getInsurancePlans(
      $grpc.ServiceCall call, $1.GetInsurancePlansRequest request);
  $async.Future<$1.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts($grpc.ServiceCall call,
          $1.GetInsuranceMarketplaceProductsRequest request);
  $async.Future<$1.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories($grpc.ServiceCall call,
          $1.GetInsuranceMarketplaceCategoriesRequest request);
  $async.Future<$1.GetInsuranceQuoteResponse> getInsuranceQuote(
      $grpc.ServiceCall call, $1.GetInsuranceQuoteRequest request);
  $async.Future<$1.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance($grpc.ServiceCall call,
          $1.PurchaseMarketplaceInsuranceRequest request);
  $async.Future<$1.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus(
          $grpc.ServiceCall call, $1.GetInsurancePurchaseStatusRequest request);
  $async.Future<$1.UploadInsuranceDocumentResponse> uploadInsuranceDocument(
      $grpc.ServiceCall call, $1.UploadInsuranceDocumentRequest request);
  $async.Future<$1.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL($grpc.ServiceCall call,
          $1.GetInsuranceDocumentUploadURLRequest request);
  $async.Future<$1.GetInsuranceAuxiliaryDataResponse> getInsuranceAuxiliaryData(
      $grpc.ServiceCall call, $1.GetInsuranceAuxiliaryDataRequest request);
  $async.Future<$1.GetInsurancePaymentsResponse> getInsurancePayments(
      $grpc.ServiceCall call, $1.GetInsurancePaymentsRequest request);
  $async.Future<$1.GetUserInsurancePaymentsResponse> getUserInsurancePayments(
      $grpc.ServiceCall call, $1.GetUserInsurancePaymentsRequest request);
  $async.Future<$1.CreateInsurancePaymentResponse> createInsurancePayment(
      $grpc.ServiceCall call, $1.CreateInsurancePaymentRequest request);
  $async.Future<$1.ProcessInsurancePaymentResponse> processInsurancePayment(
      $grpc.ServiceCall call, $1.ProcessInsurancePaymentRequest request);
  $async.Future<$1.GetInsurancePaymentByIdResponse> getInsurancePaymentById(
      $grpc.ServiceCall call, $1.GetInsurancePaymentByIdRequest request);
  $async.Future<$1.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments($grpc.ServiceCall call,
          $1.GetOverdueInsurancePaymentsRequest request);
  $async.Future<$1.GetInsuranceClaimsResponse> getInsuranceClaims(
      $grpc.ServiceCall call, $1.GetInsuranceClaimsRequest request);
  $async.Future<$1.GetUserInsuranceClaimsResponse> getUserInsuranceClaims(
      $grpc.ServiceCall call, $1.GetUserInsuranceClaimsRequest request);
  $async.Future<$1.UpdateInsuranceClaimResponse> updateInsuranceClaim(
      $grpc.ServiceCall call, $1.UpdateInsuranceClaimRequest request);
  $async.Future<$1.GetInsuranceClaimByIdResponse> getInsuranceClaimById(
      $grpc.ServiceCall call, $1.GetInsuranceClaimByIdRequest request);
  $async.Future<$1.UpdateInsurancePolicyResponse> updateInsurancePolicy(
      $grpc.ServiceCall call, $1.UpdateInsurancePolicyRequest request);
  $async.Future<$1.GenerateInsuranceReceiptResponse> generateInsuranceReceipt(
      $grpc.ServiceCall call, $1.GenerateInsuranceReceiptRequest request);
  $async.Future<$1.GetUserInsuranceReceiptsResponse> getUserInsuranceReceipts(
      $grpc.ServiceCall call, $1.GetUserInsuranceReceiptsRequest request);
  $async.Future<$1.GetInsuranceStatisticsResponse> getInsuranceStatistics(
      $grpc.ServiceCall call, $1.GetInsuranceStatisticsRequest request);
  $async.Future<$1.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics($grpc.ServiceCall call,
          $1.GetInsurancePaymentStatisticsRequest request);
  $async.Future<$1.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $grpc.ServiceCall call, $1.GetMyCoverCustomersRequest request);
  $async.Future<$1.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById(
      $grpc.ServiceCall call, $1.GetMyCoverCustomerByIdRequest request);
  $async.Future<$1.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies(
          $grpc.ServiceCall call, $1.GetMyCoverCustomerPoliciesRequest request);
  $async.Future<$1.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($grpc.ServiceCall call,
          $1.GetMyCoverCustomerPurchasesRequest request);
  $async.Future<$1.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $grpc.ServiceCall call, $1.GetMyCoverPurchasesRequest request);
  $async.Future<$1.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById(
      $grpc.ServiceCall call, $1.GetMyCoverPurchaseByIdRequest request);
  $async.Future<$1.GetMyCoverClaimsResponse> getMyCoverClaims(
      $grpc.ServiceCall call, $1.GetMyCoverClaimsRequest request);
  $async.Future<$1.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $grpc.ServiceCall call, $1.GetMyCoverClaimByIdRequest request);
  $async.Future<$1.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $grpc.ServiceCall call, $1.FileCreditLifeClaimRequest request);
  $async.Future<$1.GetInsuranceStatesResponse> getInsuranceStates(
      $grpc.ServiceCall call, $1.GetInsuranceStatesRequest request);
  $async.Future<$1.GetInsuranceVehicleMakesResponse> getInsuranceVehicleMakes(
      $grpc.ServiceCall call, $1.GetInsuranceVehicleMakesRequest request);
  $async.Future<$1.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences($grpc.ServiceCall call,
          $1.GetMyCoverNotificationPreferencesRequest request);
  $async.Future<$1.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences($grpc.ServiceCall call,
          $1.UpdateMyCoverNotificationPreferencesRequest request);
  $async.Future<$1.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance(
      $grpc.ServiceCall call, $1.GetMyCoverWalletBalanceRequest request);
  $async.Future<$1.RequestInsuranceRefundResponse> requestInsuranceRefund(
      $grpc.ServiceCall call, $1.RequestInsuranceRefundRequest request);
  $async.Future<$1.GetInsuranceRefundStatusResponse> getInsuranceRefundStatus(
      $grpc.ServiceCall call, $1.GetInsuranceRefundStatusRequest request);
  $async.Future<$1.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview($grpc.ServiceCall call,
          $1.GetInsuranceReconciliationOverviewRequest request);
  $async.Future<$1.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions($grpc.ServiceCall call,
          $1.GetOrphanedInsuranceTransactionsRequest request);
  $async.Future<$1.ManualReconcilePurchaseResponse> manualReconcilePurchase(
      $grpc.ServiceCall call, $1.ManualReconcilePurchaseRequest request);
  $async.Future<$1.AdminTriggerRefundResponse> adminTriggerRefund(
      $grpc.ServiceCall call, $1.AdminTriggerRefundRequest request);
  $async.Future<$1.GetInsuranceWebhookEventsResponse> getInsuranceWebhookEvents(
      $grpc.ServiceCall call, $1.GetInsuranceWebhookEventsRequest request);
  $async.Future<$1.RetryFailedWebhookEventResponse> retryFailedWebhookEvent(
      $grpc.ServiceCall call, $1.RetryFailedWebhookEventRequest request);
  $async.Future<$1.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions($grpc.ServiceCall call,
          $1.GetFailedInsuranceTransactionsRequest request);
  $async.Future<$1.UpdateProductMarginResponse> updateProductMargin(
      $grpc.ServiceCall call, $1.UpdateProductMarginRequest request);
  $async.Future<$1.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets($grpc.ServiceCall call,
          $1.GetInsurancePlatformWalletsRequest request);
  $async.Future<$1.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $1.CreateCrowdfundRequest request);
  $async.Future<$1.GetCrowdfundsResponse> getCrowdfunds(
      $grpc.ServiceCall call, $1.GetCrowdfundsRequest request);
  $async.Future<$1.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $1.GetCrowdfundRequest request);
  $async.Future<$1.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $grpc.ServiceCall call, $1.ContributeToCrowdfundRequest request);
  $async.Future<$1.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $grpc.ServiceCall call, $1.WithdrawFromCrowdfundRequest request);
  $async.Future<$1.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote($grpc.ServiceCall call,
          $1.GetCrowdfundWithdrawalFeeQuoteRequest request);
  $async.Future<$1.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories($grpc.ServiceCall call,
          $1.ListCrowdfundCustomCategoriesRequest request);
  $async.Future<$1.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory(
          $grpc.ServiceCall call, $1.AddCrowdfundCustomCategoryRequest request);
  $async.Future<$1.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory($grpc.ServiceCall call,
          $1.DeleteCrowdfundCustomCategoryRequest request);
  $async.Future<$1.ListCrowdfundWithdrawalsResponse> listCrowdfundWithdrawals(
      $grpc.ServiceCall call, $1.ListCrowdfundWithdrawalsRequest request);
  $async.Future<$1.CloseCrowdfundResponse> closeCrowdfund(
      $grpc.ServiceCall call, $1.CloseCrowdfundRequest request);
  $async.Future<$1.CancelCrowdfundResponse> cancelCrowdfund(
      $grpc.ServiceCall call, $1.CancelCrowdfundRequest request);
  $async.Future<$1.ForceCompleteCrowdfundResponse> forceCompleteCrowdfund(
      $grpc.ServiceCall call, $1.ForceCompleteCrowdfundRequest request);
  $async.Future<$1.ListCrowdfundRefundsResponse> listCrowdfundRefunds(
      $grpc.ServiceCall call, $1.ListCrowdfundRefundsRequest request);
  $async.Future<$1.RetryCrowdfundRefundResponse> retryCrowdfundRefund(
      $grpc.ServiceCall call, $1.RetryCrowdfundRefundRequest request);
  $async.Future<$1.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $1.GetCrowdfundStatisticsRequest request);
  $async.Future<$1.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $1.SearchCrowdfundsRequest request);
  $async.Future<$1.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $1.UpdateCrowdfundRequest request);
  $async.Future<$1.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $1.DeleteCrowdfundRequest request);
  $async.Future<$1.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $1.GetCrowdfundDonationsRequest request);
  $async.Future<$1.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $1.GetUserDonationsRequest request);
  $async.Future<$1.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $1.GenerateDonationReceiptRequest request);
  $async.Future<$1.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $1.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$1.ConnectNotificationChannelResponse>
      connectNotificationChannel(
          $grpc.ServiceCall call, $1.ConnectNotificationChannelRequest request);
  $async.Future<$1.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel($grpc.ServiceCall call,
          $1.DisconnectNotificationChannelRequest request);
  $async.Future<$1.GetNotificationChannelsResponse> getNotificationChannels(
      $grpc.ServiceCall call, $1.GetNotificationChannelsRequest request);
  $async.Future<$1.UpdateNotificationChannelResponse> updateNotificationChannel(
      $grpc.ServiceCall call, $1.UpdateNotificationChannelRequest request);
  $async.Future<$1.TestNotificationChannelResponse> testNotificationChannel(
      $grpc.ServiceCall call, $1.TestNotificationChannelRequest request);
  $async.Future<$1.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $grpc.ServiceCall call, $1.GetTelegramBotInfoRequest request);
  $async.Future<$1.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $grpc.ServiceCall call, $1.VerifyTelegramChannelRequest request);
  $async.Future<$1.GetNotificationHistoryResponse> getNotificationHistory(
      $grpc.ServiceCall call, $1.GetNotificationHistoryRequest request);
  $async.Future<$1.GetCrowdfundLeaderboardResponse> getCrowdfundLeaderboard(
      $grpc.ServiceCall call, $1.GetCrowdfundLeaderboardRequest request);
  $async.Future<$1.CreateAutoSaveRuleResponse2> createAutoSaveRule(
      $grpc.ServiceCall call, $1.CreateAutoSaveRuleRequest2 request);
  $async.Future<$1.GetAutoSaveRulesResponse2> getAutoSaveRules(
      $grpc.ServiceCall call, $1.GetAutoSaveRulesRequest2 request);
  $async.Future<$1.UpdateAutoSaveRuleResponse2> updateAutoSaveRule(
      $grpc.ServiceCall call, $1.UpdateAutoSaveRuleRequest2 request);
  $async.Future<$1.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule(
      $grpc.ServiceCall call, $1.ToggleAutoSaveRuleRequest2 request);
  $async.Future<$1.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule(
      $grpc.ServiceCall call, $1.DeleteAutoSaveRuleRequest2 request);
  $async.Future<$1.GetAutoSaveTransactionsResponse2> getAutoSaveTransactions(
      $grpc.ServiceCall call, $1.GetAutoSaveTransactionsRequest2 request);
  $async.Future<$1.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics(
      $grpc.ServiceCall call, $1.GetAutoSaveStatisticsRequest2 request);
  $async.Future<$1.TriggerAutoSaveResponse2> triggerAutoSave(
      $grpc.ServiceCall call, $1.TriggerAutoSaveRequest2 request);
}
