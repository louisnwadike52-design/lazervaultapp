///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'financial-products.pb.dart' as $19;
export 'financial-products.pb.dart';

class FinancialProductsServiceClient extends $grpc.Client {
  static final _$createGroupAccount = $grpc.ClientMethod<
          $19.CreateGroupAccountRequest, $19.CreateGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CreateGroupAccount',
      ($19.CreateGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateGroupAccountResponse.fromBuffer(value));
  static final _$getGroupAccounts = $grpc.ClientMethod<
          $19.GetGroupAccountsRequest, $19.GetGroupAccountsResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccounts',
      ($19.GetGroupAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetGroupAccountsResponse.fromBuffer(value));
  static final _$getGroupAccount = $grpc.ClientMethod<
          $19.GetGroupAccountRequest, $19.GetGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/GetGroupAccount',
      ($19.GetGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetGroupAccountResponse.fromBuffer(value));
  static final _$addGroupMember =
      $grpc.ClientMethod<$19.AddGroupMemberRequest, $19.AddGroupMemberResponse>(
          '/financialproducts.FinancialProductsService/AddGroupMember',
          ($19.AddGroupMemberRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.AddGroupMemberResponse.fromBuffer(value));
  static final _$removeGroupMember = $grpc.ClientMethod<
          $19.RemoveGroupMemberRequest, $19.RemoveGroupMemberResponse>(
      '/financialproducts.FinancialProductsService/RemoveGroupMember',
      ($19.RemoveGroupMemberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.RemoveGroupMemberResponse.fromBuffer(value));
  static final _$contributeToGroup = $grpc.ClientMethod<
          $19.ContributeToGroupRequest, $19.ContributeToGroupResponse>(
      '/financialproducts.FinancialProductsService/ContributeToGroup',
      ($19.ContributeToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ContributeToGroupResponse.fromBuffer(value));
  static final _$withdrawFromGroup = $grpc.ClientMethod<
          $19.WithdrawFromGroupRequest, $19.WithdrawFromGroupResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromGroup',
      ($19.WithdrawFromGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.WithdrawFromGroupResponse.fromBuffer(value));
  static final _$closeGroupAccount = $grpc.ClientMethod<
          $19.CloseGroupAccountRequest, $19.CloseGroupAccountResponse>(
      '/financialproducts.FinancialProductsService/CloseGroupAccount',
      ($19.CloseGroupAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CloseGroupAccountResponse.fromBuffer(value));
  static final _$buyInsurance =
      $grpc.ClientMethod<$19.BuyInsuranceRequest, $19.BuyInsuranceResponse>(
          '/financialproducts.FinancialProductsService/BuyInsurance',
          ($19.BuyInsuranceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.BuyInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePolicies = $grpc.ClientMethod<
          $19.GetInsurancePoliciesRequest, $19.GetInsurancePoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicies',
      ($19.GetInsurancePoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePoliciesResponse.fromBuffer(value));
  static final _$getInsurancePolicy = $grpc.ClientMethod<
          $19.GetInsurancePolicyRequest, $19.GetInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePolicy',
      ($19.GetInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePolicyResponse.fromBuffer(value));
  static final _$makeInsuranceClaim = $grpc.ClientMethod<
          $19.MakeInsuranceClaimRequest, $19.MakeInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/MakeInsuranceClaim',
      ($19.MakeInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.MakeInsuranceClaimResponse.fromBuffer(value));
  static final _$cancelInsurance = $grpc.ClientMethod<
          $19.CancelInsuranceRequest, $19.CancelInsuranceResponse>(
      '/financialproducts.FinancialProductsService/CancelInsurance',
      ($19.CancelInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CancelInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePlans = $grpc.ClientMethod<
          $19.GetInsurancePlansRequest, $19.GetInsurancePlansResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlans',
      ($19.GetInsurancePlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePlansResponse.fromBuffer(value));
  static final _$getInsuranceMarketplaceProducts = $grpc.ClientMethod<
          $19.GetInsuranceMarketplaceProductsRequest,
          $19.GetInsuranceMarketplaceProductsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceMarketplaceProducts',
      ($19.GetInsuranceMarketplaceProductsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceMarketplaceProductsResponse.fromBuffer(value));
  static final _$getInsuranceMarketplaceCategories = $grpc.ClientMethod<
          $19.GetInsuranceMarketplaceCategoriesRequest,
          $19.GetInsuranceMarketplaceCategoriesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceMarketplaceCategories',
      ($19.GetInsuranceMarketplaceCategoriesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceMarketplaceCategoriesResponse.fromBuffer(value));
  static final _$getInsuranceQuote = $grpc.ClientMethod<
          $19.GetInsuranceQuoteRequest, $19.GetInsuranceQuoteResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceQuote',
      ($19.GetInsuranceQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceQuoteResponse.fromBuffer(value));
  static final _$purchaseMarketplaceInsurance = $grpc.ClientMethod<
          $19.PurchaseMarketplaceInsuranceRequest,
          $19.PurchaseMarketplaceInsuranceResponse>(
      '/financialproducts.FinancialProductsService/PurchaseMarketplaceInsurance',
      ($19.PurchaseMarketplaceInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.PurchaseMarketplaceInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePurchaseStatus = $grpc.ClientMethod<
          $19.GetInsurancePurchaseStatusRequest,
          $19.GetInsurancePurchaseStatusResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePurchaseStatus',
      ($19.GetInsurancePurchaseStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePurchaseStatusResponse.fromBuffer(value));
  static final _$uploadInsuranceDocument = $grpc.ClientMethod<
          $19.UploadInsuranceDocumentRequest,
          $19.UploadInsuranceDocumentResponse>(
      '/financialproducts.FinancialProductsService/UploadInsuranceDocument',
      ($19.UploadInsuranceDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UploadInsuranceDocumentResponse.fromBuffer(value));
  static final _$getInsuranceDocumentUploadURL = $grpc.ClientMethod<
          $19.GetInsuranceDocumentUploadURLRequest,
          $19.GetInsuranceDocumentUploadURLResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceDocumentUploadURL',
      ($19.GetInsuranceDocumentUploadURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceDocumentUploadURLResponse.fromBuffer(value));
  static final _$getInsuranceAuxiliaryData = $grpc.ClientMethod<
          $19.GetInsuranceAuxiliaryDataRequest,
          $19.GetInsuranceAuxiliaryDataResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceAuxiliaryData',
      ($19.GetInsuranceAuxiliaryDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceAuxiliaryDataResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<
          $19.GetInsurancePaymentsRequest, $19.GetInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePayments',
      ($19.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserInsurancePayments = $grpc.ClientMethod<
          $19.GetUserInsurancePaymentsRequest,
          $19.GetUserInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsurancePayments',
      ($19.GetUserInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetUserInsurancePaymentsResponse.fromBuffer(value));
  static final _$createInsurancePayment = $grpc.ClientMethod<
          $19.CreateInsurancePaymentRequest,
          $19.CreateInsurancePaymentResponse>(
      '/financialproducts.FinancialProductsService/CreateInsurancePayment',
      ($19.CreateInsurancePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateInsurancePaymentResponse.fromBuffer(value));
  static final _$processInsurancePayment = $grpc.ClientMethod<
          $19.ProcessInsurancePaymentRequest,
          $19.ProcessInsurancePaymentResponse>(
      '/financialproducts.FinancialProductsService/ProcessInsurancePayment',
      ($19.ProcessInsurancePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ProcessInsurancePaymentResponse.fromBuffer(value));
  static final _$getInsurancePaymentById = $grpc.ClientMethod<
          $19.GetInsurancePaymentByIdRequest,
          $19.GetInsurancePaymentByIdResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePaymentById',
      ($19.GetInsurancePaymentByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePaymentByIdResponse.fromBuffer(value));
  static final _$getOverdueInsurancePayments = $grpc.ClientMethod<
          $19.GetOverdueInsurancePaymentsRequest,
          $19.GetOverdueInsurancePaymentsResponse>(
      '/financialproducts.FinancialProductsService/GetOverdueInsurancePayments',
      ($19.GetOverdueInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetOverdueInsurancePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<
          $19.GetInsuranceClaimsRequest, $19.GetInsuranceClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceClaims',
      ($19.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserInsuranceClaims = $grpc.ClientMethod<
          $19.GetUserInsuranceClaimsRequest,
          $19.GetUserInsuranceClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsuranceClaims',
      ($19.GetUserInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetUserInsuranceClaimsResponse.fromBuffer(value));
  static final _$updateInsuranceClaim = $grpc.ClientMethod<
          $19.UpdateInsuranceClaimRequest, $19.UpdateInsuranceClaimResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsuranceClaim',
      ($19.UpdateInsuranceClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateInsuranceClaimResponse.fromBuffer(value));
  static final _$getInsuranceClaimById = $grpc.ClientMethod<
          $19.GetInsuranceClaimByIdRequest, $19.GetInsuranceClaimByIdResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceClaimById',
      ($19.GetInsuranceClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceClaimByIdResponse.fromBuffer(value));
  static final _$updateInsurancePolicy = $grpc.ClientMethod<
          $19.UpdateInsurancePolicyRequest, $19.UpdateInsurancePolicyResponse>(
      '/financialproducts.FinancialProductsService/UpdateInsurancePolicy',
      ($19.UpdateInsurancePolicyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateInsurancePolicyResponse.fromBuffer(value));
  static final _$generateInsuranceReceipt = $grpc.ClientMethod<
          $19.GenerateInsuranceReceiptRequest,
          $19.GenerateInsuranceReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateInsuranceReceipt',
      ($19.GenerateInsuranceReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GenerateInsuranceReceiptResponse.fromBuffer(value));
  static final _$getUserInsuranceReceipts = $grpc.ClientMethod<
          $19.GetUserInsuranceReceiptsRequest,
          $19.GetUserInsuranceReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserInsuranceReceipts',
      ($19.GetUserInsuranceReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetUserInsuranceReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<
          $19.GetInsuranceStatisticsRequest,
          $19.GetInsuranceStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceStatistics',
      ($19.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getInsurancePaymentStatistics = $grpc.ClientMethod<
          $19.GetInsurancePaymentStatisticsRequest,
          $19.GetInsurancePaymentStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePaymentStatistics',
      ($19.GetInsurancePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePaymentStatisticsResponse.fromBuffer(value));
  static final _$getMyCoverCustomers = $grpc.ClientMethod<
          $19.GetMyCoverCustomersRequest, $19.GetMyCoverCustomersResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomers',
      ($19.GetMyCoverCustomersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverCustomersResponse.fromBuffer(value));
  static final _$getMyCoverCustomerById = $grpc.ClientMethod<
          $19.GetMyCoverCustomerByIdRequest,
          $19.GetMyCoverCustomerByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerById',
      ($19.GetMyCoverCustomerByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverCustomerByIdResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPolicies = $grpc.ClientMethod<
          $19.GetMyCoverCustomerPoliciesRequest,
          $19.GetMyCoverCustomerPoliciesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerPolicies',
      ($19.GetMyCoverCustomerPoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverCustomerPoliciesResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPurchases = $grpc.ClientMethod<
          $19.GetMyCoverCustomerPurchasesRequest,
          $19.GetMyCoverCustomerPurchasesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverCustomerPurchases',
      ($19.GetMyCoverCustomerPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverCustomerPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchases = $grpc.ClientMethod<
          $19.GetMyCoverPurchasesRequest, $19.GetMyCoverPurchasesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPurchases',
      ($19.GetMyCoverPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchaseById = $grpc.ClientMethod<
          $19.GetMyCoverPurchaseByIdRequest,
          $19.GetMyCoverPurchaseByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverPurchaseById',
      ($19.GetMyCoverPurchaseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverPurchaseByIdResponse.fromBuffer(value));
  static final _$getMyCoverClaims = $grpc.ClientMethod<
          $19.GetMyCoverClaimsRequest, $19.GetMyCoverClaimsResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverClaims',
      ($19.GetMyCoverClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverClaimsResponse.fromBuffer(value));
  static final _$getMyCoverClaimById = $grpc.ClientMethod<
          $19.GetMyCoverClaimByIdRequest, $19.GetMyCoverClaimByIdResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverClaimById',
      ($19.GetMyCoverClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverClaimByIdResponse.fromBuffer(value));
  static final _$fileCreditLifeClaim = $grpc.ClientMethod<
          $19.FileCreditLifeClaimRequest, $19.FileCreditLifeClaimResponse>(
      '/financialproducts.FinancialProductsService/FileCreditLifeClaim',
      ($19.FileCreditLifeClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.FileCreditLifeClaimResponse.fromBuffer(value));
  static final _$getInsuranceStates = $grpc.ClientMethod<
          $19.GetInsuranceStatesRequest, $19.GetInsuranceStatesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceStates',
      ($19.GetInsuranceStatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceStatesResponse.fromBuffer(value));
  static final _$getInsuranceVehicleMakes = $grpc.ClientMethod<
          $19.GetInsuranceVehicleMakesRequest,
          $19.GetInsuranceVehicleMakesResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceVehicleMakes',
      ($19.GetInsuranceVehicleMakesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceVehicleMakesResponse.fromBuffer(value));
  static final _$getMyCoverNotificationPreferences = $grpc.ClientMethod<
          $19.GetMyCoverNotificationPreferencesRequest,
          $19.GetMyCoverNotificationPreferencesResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverNotificationPreferences',
      ($19.GetMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$updateMyCoverNotificationPreferences = $grpc.ClientMethod<
          $19.UpdateMyCoverNotificationPreferencesRequest,
          $19.UpdateMyCoverNotificationPreferencesResponse>(
      '/financialproducts.FinancialProductsService/UpdateMyCoverNotificationPreferences',
      ($19.UpdateMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$getMyCoverWalletBalance = $grpc.ClientMethod<
          $19.GetMyCoverWalletBalanceRequest,
          $19.GetMyCoverWalletBalanceResponse>(
      '/financialproducts.FinancialProductsService/GetMyCoverWalletBalance',
      ($19.GetMyCoverWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetMyCoverWalletBalanceResponse.fromBuffer(value));
  static final _$requestInsuranceRefund = $grpc.ClientMethod<
          $19.RequestInsuranceRefundRequest,
          $19.RequestInsuranceRefundResponse>(
      '/financialproducts.FinancialProductsService/RequestInsuranceRefund',
      ($19.RequestInsuranceRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.RequestInsuranceRefundResponse.fromBuffer(value));
  static final _$getInsuranceRefundStatus = $grpc.ClientMethod<
          $19.GetInsuranceRefundStatusRequest,
          $19.GetInsuranceRefundStatusResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceRefundStatus',
      ($19.GetInsuranceRefundStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceRefundStatusResponse.fromBuffer(value));
  static final _$getInsuranceReconciliationOverview = $grpc.ClientMethod<
          $19.GetInsuranceReconciliationOverviewRequest,
          $19.GetInsuranceReconciliationOverviewResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceReconciliationOverview',
      ($19.GetInsuranceReconciliationOverviewRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceReconciliationOverviewResponse.fromBuffer(value));
  static final _$getOrphanedInsuranceTransactions = $grpc.ClientMethod<
          $19.GetOrphanedInsuranceTransactionsRequest,
          $19.GetOrphanedInsuranceTransactionsResponse>(
      '/financialproducts.FinancialProductsService/GetOrphanedInsuranceTransactions',
      ($19.GetOrphanedInsuranceTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetOrphanedInsuranceTransactionsResponse.fromBuffer(value));
  static final _$manualReconcilePurchase = $grpc.ClientMethod<
          $19.ManualReconcilePurchaseRequest,
          $19.ManualReconcilePurchaseResponse>(
      '/financialproducts.FinancialProductsService/ManualReconcilePurchase',
      ($19.ManualReconcilePurchaseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ManualReconcilePurchaseResponse.fromBuffer(value));
  static final _$adminTriggerRefund = $grpc.ClientMethod<
          $19.AdminTriggerRefundRequest, $19.AdminTriggerRefundResponse>(
      '/financialproducts.FinancialProductsService/AdminTriggerRefund',
      ($19.AdminTriggerRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.AdminTriggerRefundResponse.fromBuffer(value));
  static final _$getInsuranceWebhookEvents = $grpc.ClientMethod<
          $19.GetInsuranceWebhookEventsRequest,
          $19.GetInsuranceWebhookEventsResponse>(
      '/financialproducts.FinancialProductsService/GetInsuranceWebhookEvents',
      ($19.GetInsuranceWebhookEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsuranceWebhookEventsResponse.fromBuffer(value));
  static final _$retryFailedWebhookEvent = $grpc.ClientMethod<
          $19.RetryFailedWebhookEventRequest,
          $19.RetryFailedWebhookEventResponse>(
      '/financialproducts.FinancialProductsService/RetryFailedWebhookEvent',
      ($19.RetryFailedWebhookEventRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.RetryFailedWebhookEventResponse.fromBuffer(value));
  static final _$getFailedInsuranceTransactions = $grpc.ClientMethod<
          $19.GetFailedInsuranceTransactionsRequest,
          $19.GetFailedInsuranceTransactionsResponse>(
      '/financialproducts.FinancialProductsService/GetFailedInsuranceTransactions',
      ($19.GetFailedInsuranceTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetFailedInsuranceTransactionsResponse.fromBuffer(value));
  static final _$updateProductMargin = $grpc.ClientMethod<
          $19.UpdateProductMarginRequest, $19.UpdateProductMarginResponse>(
      '/financialproducts.FinancialProductsService/UpdateProductMargin',
      ($19.UpdateProductMarginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateProductMarginResponse.fromBuffer(value));
  static final _$getInsurancePlatformWallets = $grpc.ClientMethod<
          $19.GetInsurancePlatformWalletsRequest,
          $19.GetInsurancePlatformWalletsResponse>(
      '/financialproducts.FinancialProductsService/GetInsurancePlatformWallets',
      ($19.GetInsurancePlatformWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetInsurancePlatformWalletsResponse.fromBuffer(value));
  static final _$createCrowdfund = $grpc.ClientMethod<
          $19.CreateCrowdfundRequest, $19.CreateCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/CreateCrowdfund',
      ($19.CreateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfunds =
      $grpc.ClientMethod<$19.GetCrowdfundsRequest, $19.GetCrowdfundsResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfunds',
          ($19.GetCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetCrowdfundsResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$19.GetCrowdfundRequest, $19.GetCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/GetCrowdfund',
          ($19.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.GetCrowdfundResponse.fromBuffer(value));
  static final _$contributeToCrowdfund = $grpc.ClientMethod<
          $19.ContributeToCrowdfundRequest, $19.ContributeToCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ContributeToCrowdfund',
      ($19.ContributeToCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ContributeToCrowdfundResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<
          $19.WithdrawFromCrowdfundRequest, $19.WithdrawFromCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/WithdrawFromCrowdfund',
      ($19.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundWithdrawalFeeQuote = $grpc.ClientMethod<
          $19.GetCrowdfundWithdrawalFeeQuoteRequest,
          $19.GetCrowdfundWithdrawalFeeQuoteResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundWithdrawalFeeQuote',
      ($19.GetCrowdfundWithdrawalFeeQuoteRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetCrowdfundWithdrawalFeeQuoteResponse.fromBuffer(value));
  static final _$listCrowdfundCustomCategories = $grpc.ClientMethod<
          $19.ListCrowdfundCustomCategoriesRequest,
          $19.ListCrowdfundCustomCategoriesResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundCustomCategories',
      ($19.ListCrowdfundCustomCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ListCrowdfundCustomCategoriesResponse.fromBuffer(value));
  static final _$addCrowdfundCustomCategory = $grpc.ClientMethod<
          $19.AddCrowdfundCustomCategoryRequest,
          $19.AddCrowdfundCustomCategoryResponse>(
      '/financialproducts.FinancialProductsService/AddCrowdfundCustomCategory',
      ($19.AddCrowdfundCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.AddCrowdfundCustomCategoryResponse.fromBuffer(value));
  static final _$deleteCrowdfundCustomCategory = $grpc.ClientMethod<
          $19.DeleteCrowdfundCustomCategoryRequest,
          $19.DeleteCrowdfundCustomCategoryResponse>(
      '/financialproducts.FinancialProductsService/DeleteCrowdfundCustomCategory',
      ($19.DeleteCrowdfundCustomCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.DeleteCrowdfundCustomCategoryResponse.fromBuffer(value));
  static final _$listCrowdfundWithdrawals = $grpc.ClientMethod<
          $19.ListCrowdfundWithdrawalsRequest,
          $19.ListCrowdfundWithdrawalsResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundWithdrawals',
      ($19.ListCrowdfundWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ListCrowdfundWithdrawalsResponse.fromBuffer(value));
  static final _$closeCrowdfund =
      $grpc.ClientMethod<$19.CloseCrowdfundRequest, $19.CloseCrowdfundResponse>(
          '/financialproducts.FinancialProductsService/CloseCrowdfund',
          ($19.CloseCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.CloseCrowdfundResponse.fromBuffer(value));
  static final _$cancelCrowdfund = $grpc.ClientMethod<
          $19.CancelCrowdfundRequest, $19.CancelCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/CancelCrowdfund',
      ($19.CancelCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CancelCrowdfundResponse.fromBuffer(value));
  static final _$forceCompleteCrowdfund = $grpc.ClientMethod<
          $19.ForceCompleteCrowdfundRequest,
          $19.ForceCompleteCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/ForceCompleteCrowdfund',
      ($19.ForceCompleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ForceCompleteCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfundRefunds = $grpc.ClientMethod<
          $19.ListCrowdfundRefundsRequest, $19.ListCrowdfundRefundsResponse>(
      '/financialproducts.FinancialProductsService/ListCrowdfundRefunds',
      ($19.ListCrowdfundRefundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ListCrowdfundRefundsResponse.fromBuffer(value));
  static final _$retryCrowdfundRefund = $grpc.ClientMethod<
          $19.RetryCrowdfundRefundRequest, $19.RetryCrowdfundRefundResponse>(
      '/financialproducts.FinancialProductsService/RetryCrowdfundRefund',
      ($19.RetryCrowdfundRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.RetryCrowdfundRefundResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $19.GetCrowdfundStatisticsRequest,
          $19.GetCrowdfundStatisticsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundStatistics',
      ($19.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $19.SearchCrowdfundsRequest, $19.SearchCrowdfundsResponse>(
      '/financialproducts.FinancialProductsService/SearchCrowdfunds',
      ($19.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund = $grpc.ClientMethod<
          $19.UpdateCrowdfundRequest, $19.UpdateCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/UpdateCrowdfund',
      ($19.UpdateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund = $grpc.ClientMethod<
          $19.DeleteCrowdfundRequest, $19.DeleteCrowdfundResponse>(
      '/financialproducts.FinancialProductsService/DeleteCrowdfund',
      ($19.DeleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $19.GetCrowdfundDonationsRequest, $19.GetCrowdfundDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundDonations',
      ($19.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $19.GetUserDonationsRequest, $19.GetUserDonationsResponse>(
      '/financialproducts.FinancialProductsService/GetUserDonations',
      ($19.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $19.GenerateDonationReceiptRequest,
          $19.GenerateDonationReceiptResponse>(
      '/financialproducts.FinancialProductsService/GenerateDonationReceipt',
      ($19.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $19.GetUserCrowdfundReceiptsRequest,
          $19.GetUserCrowdfundReceiptsResponse>(
      '/financialproducts.FinancialProductsService/GetUserCrowdfundReceipts',
      ($19.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<
          $19.ConnectNotificationChannelRequest,
          $19.ConnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/ConnectNotificationChannel',
      ($19.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<
          $19.DisconnectNotificationChannelRequest,
          $19.DisconnectNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/DisconnectNotificationChannel',
      ($19.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<
          $19.GetNotificationChannelsRequest,
          $19.GetNotificationChannelsResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationChannels',
      ($19.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<
          $19.UpdateNotificationChannelRequest,
          $19.UpdateNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/UpdateNotificationChannel',
      ($19.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<
          $19.TestNotificationChannelRequest,
          $19.TestNotificationChannelResponse>(
      '/financialproducts.FinancialProductsService/TestNotificationChannel',
      ($19.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<
          $19.GetTelegramBotInfoRequest, $19.GetTelegramBotInfoResponse>(
      '/financialproducts.FinancialProductsService/GetTelegramBotInfo',
      ($19.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<
          $19.VerifyTelegramChannelRequest, $19.VerifyTelegramChannelResponse>(
      '/financialproducts.FinancialProductsService/VerifyTelegramChannel',
      ($19.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<
          $19.GetNotificationHistoryRequest,
          $19.GetNotificationHistoryResponse>(
      '/financialproducts.FinancialProductsService/GetNotificationHistory',
      ($19.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetNotificationHistoryResponse.fromBuffer(value));
  static final _$getCrowdfundLeaderboard = $grpc.ClientMethod<
          $19.GetCrowdfundLeaderboardRequest,
          $19.GetCrowdfundLeaderboardResponse>(
      '/financialproducts.FinancialProductsService/GetCrowdfundLeaderboard',
      ($19.GetCrowdfundLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetCrowdfundLeaderboardResponse.fromBuffer(value));
  static final _$createAutoSaveRule = $grpc.ClientMethod<
          $19.CreateAutoSaveRuleRequest2, $19.CreateAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/CreateAutoSaveRule',
      ($19.CreateAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateAutoSaveRuleResponse2.fromBuffer(value));
  static final _$getAutoSaveRules = $grpc.ClientMethod<
          $19.GetAutoSaveRulesRequest2, $19.GetAutoSaveRulesResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveRules',
      ($19.GetAutoSaveRulesRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetAutoSaveRulesResponse2.fromBuffer(value));
  static final _$updateAutoSaveRule = $grpc.ClientMethod<
          $19.UpdateAutoSaveRuleRequest2, $19.UpdateAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/UpdateAutoSaveRule',
      ($19.UpdateAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateAutoSaveRuleResponse2.fromBuffer(value));
  static final _$toggleAutoSaveRule = $grpc.ClientMethod<
          $19.ToggleAutoSaveRuleRequest2, $19.ToggleAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/ToggleAutoSaveRule',
      ($19.ToggleAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.ToggleAutoSaveRuleResponse2.fromBuffer(value));
  static final _$deleteAutoSaveRule = $grpc.ClientMethod<
          $19.DeleteAutoSaveRuleRequest2, $19.DeleteAutoSaveRuleResponse2>(
      '/financialproducts.FinancialProductsService/DeleteAutoSaveRule',
      ($19.DeleteAutoSaveRuleRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.DeleteAutoSaveRuleResponse2.fromBuffer(value));
  static final _$getAutoSaveTransactions = $grpc.ClientMethod<
          $19.GetAutoSaveTransactionsRequest2,
          $19.GetAutoSaveTransactionsResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveTransactions',
      ($19.GetAutoSaveTransactionsRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetAutoSaveTransactionsResponse2.fromBuffer(value));
  static final _$getAutoSaveStatistics = $grpc.ClientMethod<
          $19.GetAutoSaveStatisticsRequest2,
          $19.GetAutoSaveStatisticsResponse2>(
      '/financialproducts.FinancialProductsService/GetAutoSaveStatistics',
      ($19.GetAutoSaveStatisticsRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetAutoSaveStatisticsResponse2.fromBuffer(value));
  static final _$triggerAutoSave = $grpc.ClientMethod<
          $19.TriggerAutoSaveRequest2, $19.TriggerAutoSaveResponse2>(
      '/financialproducts.FinancialProductsService/TriggerAutoSave',
      ($19.TriggerAutoSaveRequest2 value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.TriggerAutoSaveResponse2.fromBuffer(value));

  FinancialProductsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$19.CreateGroupAccountResponse> createGroupAccount(
      $19.CreateGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetGroupAccountsResponse> getGroupAccounts(
      $19.GetGroupAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetGroupAccountResponse> getGroupAccount(
      $19.GetGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$19.AddGroupMemberResponse> addGroupMember(
      $19.AddGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$19.RemoveGroupMemberResponse> removeGroupMember(
      $19.RemoveGroupMemberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeGroupMember, request, options: options);
  }

  $grpc.ResponseFuture<$19.ContributeToGroupResponse> contributeToGroup(
      $19.ContributeToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$19.WithdrawFromGroupResponse> withdrawFromGroup(
      $19.WithdrawFromGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromGroup, request, options: options);
  }

  $grpc.ResponseFuture<$19.CloseGroupAccountResponse> closeGroupAccount(
      $19.CloseGroupAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeGroupAccount, request, options: options);
  }

  $grpc.ResponseFuture<$19.BuyInsuranceResponse> buyInsurance(
      $19.BuyInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePoliciesResponse> getInsurancePolicies(
      $19.GetInsurancePoliciesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicies, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePolicyResponse> getInsurancePolicy(
      $19.GetInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$19.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $19.MakeInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$19.CancelInsuranceResponse> cancelInsurance(
      $19.CancelInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePlansResponse> getInsurancePlans(
      $19.GetInsurancePlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlans, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts(
          $19.GetInsuranceMarketplaceProductsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceMarketplaceProducts, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories(
          $19.GetInsuranceMarketplaceCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceMarketplaceCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceQuoteResponse> getInsuranceQuote(
      $19.GetInsuranceQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceQuote, request, options: options);
  }

  $grpc.ResponseFuture<$19.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance(
          $19.PurchaseMarketplaceInsuranceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseMarketplaceInsurance, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($19.GetInsurancePurchaseStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePurchaseStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument($19.UploadInsuranceDocumentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInsuranceDocument, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL(
          $19.GetInsuranceDocumentUploadURLRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceDocumentUploadURL, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData($19.GetInsuranceAuxiliaryDataRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceAuxiliaryData, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePaymentsResponse> getInsurancePayments(
      $19.GetInsurancePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetUserInsurancePaymentsResponse>
      getUserInsurancePayments($19.GetUserInsurancePaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurancePayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.CreateInsurancePaymentResponse>
      createInsurancePayment($19.CreateInsurancePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurancePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.ProcessInsurancePaymentResponse>
      processInsurancePayment($19.ProcessInsurancePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInsurancePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePaymentByIdResponse>
      getInsurancePaymentById($19.GetInsurancePaymentByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePaymentById, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments(
          $19.GetOverdueInsurancePaymentsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueInsurancePayments, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceClaimsResponse> getInsuranceClaims(
      $19.GetInsuranceClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetUserInsuranceClaimsResponse>
      getUserInsuranceClaims($19.GetUserInsuranceClaimsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsuranceClaims, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.UpdateInsuranceClaimResponse> updateInsuranceClaim(
      $19.UpdateInsuranceClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsuranceClaim, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceClaimByIdResponse> getInsuranceClaimById(
      $19.GetInsuranceClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateInsurancePolicyResponse> updateInsurancePolicy(
      $19.UpdateInsurancePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurancePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$19.GenerateInsuranceReceiptResponse>
      generateInsuranceReceipt($19.GenerateInsuranceReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInsuranceReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetUserInsuranceReceiptsResponse>
      getUserInsuranceReceipts($19.GetUserInsuranceReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsuranceReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceStatisticsResponse>
      getInsuranceStatistics($19.GetInsuranceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics(
          $19.GetInsurancePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $19.GetMyCoverCustomersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomers, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverCustomerByIdResponse>
      getMyCoverCustomerById($19.GetMyCoverCustomerByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerById, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($19.GetMyCoverCustomerPoliciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPolicies, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases(
          $19.GetMyCoverCustomerPurchasesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPurchases, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $19.GetMyCoverPurchasesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchases, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverPurchaseByIdResponse>
      getMyCoverPurchaseById($19.GetMyCoverPurchaseByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchaseById, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverClaimsResponse> getMyCoverClaims(
      $19.GetMyCoverClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaims, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $19.GetMyCoverClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$19.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $19.FileCreditLifeClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fileCreditLifeClaim, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceStatesResponse> getInsuranceStates(
      $19.GetInsuranceStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStates, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes($19.GetInsuranceVehicleMakesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceVehicleMakes, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences(
          $19.GetMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences(
          $19.UpdateMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance($19.GetMyCoverWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.RequestInsuranceRefundResponse>
      requestInsuranceRefund($19.RequestInsuranceRefundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInsuranceRefund, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus($19.GetInsuranceRefundStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceRefundStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview(
          $19.GetInsuranceReconciliationOverviewRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceReconciliationOverview, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions(
          $19.GetOrphanedInsuranceTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrphanedInsuranceTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.ManualReconcilePurchaseResponse>
      manualReconcilePurchase($19.ManualReconcilePurchaseRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$manualReconcilePurchase, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.AdminTriggerRefundResponse> adminTriggerRefund(
      $19.AdminTriggerRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminTriggerRefund, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents($19.GetInsuranceWebhookEventsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceWebhookEvents, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.RetryFailedWebhookEventResponse>
      retryFailedWebhookEvent($19.RetryFailedWebhookEventRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryFailedWebhookEvent, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions(
          $19.GetFailedInsuranceTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFailedInsuranceTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.UpdateProductMarginResponse> updateProductMargin(
      $19.UpdateProductMarginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateProductMargin, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets(
          $19.GetInsurancePlatformWalletsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePlatformWallets, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.CreateCrowdfundResponse> createCrowdfund(
      $19.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetCrowdfundsResponse> getCrowdfunds(
      $19.GetCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetCrowdfundResponse> getCrowdfund(
      $19.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $19.ContributeToCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$contributeToCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $19.WithdrawFromCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote(
          $19.GetCrowdfundWithdrawalFeeQuoteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundWithdrawalFeeQuote, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories(
          $19.ListCrowdfundCustomCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundCustomCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory($19.AddCrowdfundCustomCategoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addCrowdfundCustomCategory, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory(
          $19.DeleteCrowdfundCustomCategoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfundCustomCategory, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.ListCrowdfundWithdrawalsResponse>
      listCrowdfundWithdrawals($19.ListCrowdfundWithdrawalsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundWithdrawals, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.CloseCrowdfundResponse> closeCrowdfund(
      $19.CloseCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.CancelCrowdfundResponse> cancelCrowdfund(
      $19.CancelCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.ForceCompleteCrowdfundResponse>
      forceCompleteCrowdfund($19.ForceCompleteCrowdfundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forceCompleteCrowdfund, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.ListCrowdfundRefundsResponse> listCrowdfundRefunds(
      $19.ListCrowdfundRefundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfundRefunds, request, options: options);
  }

  $grpc.ResponseFuture<$19.RetryCrowdfundRefundResponse> retryCrowdfundRefund(
      $19.RetryCrowdfundRefundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retryCrowdfundRefund, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($19.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.SearchCrowdfundsResponse> searchCrowdfunds(
      $19.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateCrowdfundResponse> updateCrowdfund(
      $19.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.DeleteCrowdfundResponse> deleteCrowdfund(
      $19.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $19.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetUserDonationsResponse> getUserDonations(
      $19.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$19.GenerateDonationReceiptResponse>
      generateDonationReceipt($19.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($19.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.ConnectNotificationChannelResponse>
      connectNotificationChannel($19.ConnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel(
          $19.DisconnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetNotificationChannelsResponse>
      getNotificationChannels($19.GetNotificationChannelsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.UpdateNotificationChannelResponse>
      updateNotificationChannel($19.UpdateNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.TestNotificationChannelResponse>
      testNotificationChannel($19.TestNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $19.GetTelegramBotInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$19.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $19.VerifyTelegramChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetNotificationHistoryResponse>
      getNotificationHistory($19.GetNotificationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetCrowdfundLeaderboardResponse>
      getCrowdfundLeaderboard($19.GetCrowdfundLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.CreateAutoSaveRuleResponse2> createAutoSaveRule(
      $19.CreateAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetAutoSaveRulesResponse2> getAutoSaveRules(
      $19.GetAutoSaveRulesRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveRules, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateAutoSaveRuleResponse2> updateAutoSaveRule(
      $19.UpdateAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$19.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule(
      $19.ToggleAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$19.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule(
      $19.DeleteAutoSaveRuleRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSaveRule, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetAutoSaveTransactionsResponse2>
      getAutoSaveTransactions($19.GetAutoSaveTransactionsRequest2 request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$19.GetAutoSaveStatisticsResponse2>
      getAutoSaveStatistics($19.GetAutoSaveStatisticsRequest2 request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaveStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$19.TriggerAutoSaveResponse2> triggerAutoSave(
      $19.TriggerAutoSaveRequest2 request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$triggerAutoSave, request, options: options);
  }
}

abstract class FinancialProductsServiceBase extends $grpc.Service {
  $core.String get $name => 'financialproducts.FinancialProductsService';

  FinancialProductsServiceBase() {
    $addMethod($grpc.ServiceMethod<$19.CreateGroupAccountRequest,
            $19.CreateGroupAccountResponse>(
        'CreateGroupAccount',
        createGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateGroupAccountRequest.fromBuffer(value),
        ($19.CreateGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetGroupAccountsRequest,
            $19.GetGroupAccountsResponse>(
        'GetGroupAccounts',
        getGroupAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetGroupAccountsRequest.fromBuffer(value),
        ($19.GetGroupAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetGroupAccountRequest,
            $19.GetGroupAccountResponse>(
        'GetGroupAccount',
        getGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetGroupAccountRequest.fromBuffer(value),
        ($19.GetGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.AddGroupMemberRequest,
            $19.AddGroupMemberResponse>(
        'AddGroupMember',
        addGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.AddGroupMemberRequest.fromBuffer(value),
        ($19.AddGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.RemoveGroupMemberRequest,
            $19.RemoveGroupMemberResponse>(
        'RemoveGroupMember',
        removeGroupMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.RemoveGroupMemberRequest.fromBuffer(value),
        ($19.RemoveGroupMemberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ContributeToGroupRequest,
            $19.ContributeToGroupResponse>(
        'ContributeToGroup',
        contributeToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ContributeToGroupRequest.fromBuffer(value),
        ($19.ContributeToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.WithdrawFromGroupRequest,
            $19.WithdrawFromGroupResponse>(
        'WithdrawFromGroup',
        withdrawFromGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.WithdrawFromGroupRequest.fromBuffer(value),
        ($19.WithdrawFromGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CloseGroupAccountRequest,
            $19.CloseGroupAccountResponse>(
        'CloseGroupAccount',
        closeGroupAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CloseGroupAccountRequest.fromBuffer(value),
        ($19.CloseGroupAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.BuyInsuranceRequest, $19.BuyInsuranceResponse>(
            'BuyInsurance',
            buyInsurance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.BuyInsuranceRequest.fromBuffer(value),
            ($19.BuyInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePoliciesRequest,
            $19.GetInsurancePoliciesResponse>(
        'GetInsurancePolicies',
        getInsurancePolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePoliciesRequest.fromBuffer(value),
        ($19.GetInsurancePoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePolicyRequest,
            $19.GetInsurancePolicyResponse>(
        'GetInsurancePolicy',
        getInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePolicyRequest.fromBuffer(value),
        ($19.GetInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.MakeInsuranceClaimRequest,
            $19.MakeInsuranceClaimResponse>(
        'MakeInsuranceClaim',
        makeInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.MakeInsuranceClaimRequest.fromBuffer(value),
        ($19.MakeInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CancelInsuranceRequest,
            $19.CancelInsuranceResponse>(
        'CancelInsurance',
        cancelInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CancelInsuranceRequest.fromBuffer(value),
        ($19.CancelInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePlansRequest,
            $19.GetInsurancePlansResponse>(
        'GetInsurancePlans',
        getInsurancePlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePlansRequest.fromBuffer(value),
        ($19.GetInsurancePlansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceMarketplaceProductsRequest,
            $19.GetInsuranceMarketplaceProductsResponse>(
        'GetInsuranceMarketplaceProducts',
        getInsuranceMarketplaceProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceMarketplaceProductsRequest.fromBuffer(value),
        ($19.GetInsuranceMarketplaceProductsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceMarketplaceCategoriesRequest,
            $19.GetInsuranceMarketplaceCategoriesResponse>(
        'GetInsuranceMarketplaceCategories',
        getInsuranceMarketplaceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceMarketplaceCategoriesRequest.fromBuffer(value),
        ($19.GetInsuranceMarketplaceCategoriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceQuoteRequest,
            $19.GetInsuranceQuoteResponse>(
        'GetInsuranceQuote',
        getInsuranceQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceQuoteRequest.fromBuffer(value),
        ($19.GetInsuranceQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.PurchaseMarketplaceInsuranceRequest,
            $19.PurchaseMarketplaceInsuranceResponse>(
        'PurchaseMarketplaceInsurance',
        purchaseMarketplaceInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.PurchaseMarketplaceInsuranceRequest.fromBuffer(value),
        ($19.PurchaseMarketplaceInsuranceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePurchaseStatusRequest,
            $19.GetInsurancePurchaseStatusResponse>(
        'GetInsurancePurchaseStatus',
        getInsurancePurchaseStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePurchaseStatusRequest.fromBuffer(value),
        ($19.GetInsurancePurchaseStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UploadInsuranceDocumentRequest,
            $19.UploadInsuranceDocumentResponse>(
        'UploadInsuranceDocument',
        uploadInsuranceDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UploadInsuranceDocumentRequest.fromBuffer(value),
        ($19.UploadInsuranceDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceDocumentUploadURLRequest,
            $19.GetInsuranceDocumentUploadURLResponse>(
        'GetInsuranceDocumentUploadURL',
        getInsuranceDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceDocumentUploadURLRequest.fromBuffer(value),
        ($19.GetInsuranceDocumentUploadURLResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceAuxiliaryDataRequest,
            $19.GetInsuranceAuxiliaryDataResponse>(
        'GetInsuranceAuxiliaryData',
        getInsuranceAuxiliaryData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceAuxiliaryDataRequest.fromBuffer(value),
        ($19.GetInsuranceAuxiliaryDataResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePaymentsRequest,
            $19.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePaymentsRequest.fromBuffer(value),
        ($19.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetUserInsurancePaymentsRequest,
            $19.GetUserInsurancePaymentsResponse>(
        'GetUserInsurancePayments',
        getUserInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetUserInsurancePaymentsRequest.fromBuffer(value),
        ($19.GetUserInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateInsurancePaymentRequest,
            $19.CreateInsurancePaymentResponse>(
        'CreateInsurancePayment',
        createInsurancePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateInsurancePaymentRequest.fromBuffer(value),
        ($19.CreateInsurancePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ProcessInsurancePaymentRequest,
            $19.ProcessInsurancePaymentResponse>(
        'ProcessInsurancePayment',
        processInsurancePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ProcessInsurancePaymentRequest.fromBuffer(value),
        ($19.ProcessInsurancePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePaymentByIdRequest,
            $19.GetInsurancePaymentByIdResponse>(
        'GetInsurancePaymentById',
        getInsurancePaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePaymentByIdRequest.fromBuffer(value),
        ($19.GetInsurancePaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetOverdueInsurancePaymentsRequest,
            $19.GetOverdueInsurancePaymentsResponse>(
        'GetOverdueInsurancePayments',
        getOverdueInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetOverdueInsurancePaymentsRequest.fromBuffer(value),
        ($19.GetOverdueInsurancePaymentsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceClaimsRequest,
            $19.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceClaimsRequest.fromBuffer(value),
        ($19.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetUserInsuranceClaimsRequest,
            $19.GetUserInsuranceClaimsResponse>(
        'GetUserInsuranceClaims',
        getUserInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetUserInsuranceClaimsRequest.fromBuffer(value),
        ($19.GetUserInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateInsuranceClaimRequest,
            $19.UpdateInsuranceClaimResponse>(
        'UpdateInsuranceClaim',
        updateInsuranceClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateInsuranceClaimRequest.fromBuffer(value),
        ($19.UpdateInsuranceClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceClaimByIdRequest,
            $19.GetInsuranceClaimByIdResponse>(
        'GetInsuranceClaimById',
        getInsuranceClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceClaimByIdRequest.fromBuffer(value),
        ($19.GetInsuranceClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateInsurancePolicyRequest,
            $19.UpdateInsurancePolicyResponse>(
        'UpdateInsurancePolicy',
        updateInsurancePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateInsurancePolicyRequest.fromBuffer(value),
        ($19.UpdateInsurancePolicyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GenerateInsuranceReceiptRequest,
            $19.GenerateInsuranceReceiptResponse>(
        'GenerateInsuranceReceipt',
        generateInsuranceReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GenerateInsuranceReceiptRequest.fromBuffer(value),
        ($19.GenerateInsuranceReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetUserInsuranceReceiptsRequest,
            $19.GetUserInsuranceReceiptsResponse>(
        'GetUserInsuranceReceipts',
        getUserInsuranceReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetUserInsuranceReceiptsRequest.fromBuffer(value),
        ($19.GetUserInsuranceReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceStatisticsRequest,
            $19.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($19.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePaymentStatisticsRequest,
            $19.GetInsurancePaymentStatisticsResponse>(
        'GetInsurancePaymentStatistics',
        getInsurancePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePaymentStatisticsRequest.fromBuffer(value),
        ($19.GetInsurancePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverCustomersRequest,
            $19.GetMyCoverCustomersResponse>(
        'GetMyCoverCustomers',
        getMyCoverCustomers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverCustomersRequest.fromBuffer(value),
        ($19.GetMyCoverCustomersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverCustomerByIdRequest,
            $19.GetMyCoverCustomerByIdResponse>(
        'GetMyCoverCustomerById',
        getMyCoverCustomerById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverCustomerByIdRequest.fromBuffer(value),
        ($19.GetMyCoverCustomerByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverCustomerPoliciesRequest,
            $19.GetMyCoverCustomerPoliciesResponse>(
        'GetMyCoverCustomerPolicies',
        getMyCoverCustomerPolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverCustomerPoliciesRequest.fromBuffer(value),
        ($19.GetMyCoverCustomerPoliciesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverCustomerPurchasesRequest,
            $19.GetMyCoverCustomerPurchasesResponse>(
        'GetMyCoverCustomerPurchases',
        getMyCoverCustomerPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverCustomerPurchasesRequest.fromBuffer(value),
        ($19.GetMyCoverCustomerPurchasesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverPurchasesRequest,
            $19.GetMyCoverPurchasesResponse>(
        'GetMyCoverPurchases',
        getMyCoverPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverPurchasesRequest.fromBuffer(value),
        ($19.GetMyCoverPurchasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverPurchaseByIdRequest,
            $19.GetMyCoverPurchaseByIdResponse>(
        'GetMyCoverPurchaseById',
        getMyCoverPurchaseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverPurchaseByIdRequest.fromBuffer(value),
        ($19.GetMyCoverPurchaseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverClaimsRequest,
            $19.GetMyCoverClaimsResponse>(
        'GetMyCoverClaims',
        getMyCoverClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverClaimsRequest.fromBuffer(value),
        ($19.GetMyCoverClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverClaimByIdRequest,
            $19.GetMyCoverClaimByIdResponse>(
        'GetMyCoverClaimById',
        getMyCoverClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverClaimByIdRequest.fromBuffer(value),
        ($19.GetMyCoverClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.FileCreditLifeClaimRequest,
            $19.FileCreditLifeClaimResponse>(
        'FileCreditLifeClaim',
        fileCreditLifeClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.FileCreditLifeClaimRequest.fromBuffer(value),
        ($19.FileCreditLifeClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceStatesRequest,
            $19.GetInsuranceStatesResponse>(
        'GetInsuranceStates',
        getInsuranceStates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceStatesRequest.fromBuffer(value),
        ($19.GetInsuranceStatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceVehicleMakesRequest,
            $19.GetInsuranceVehicleMakesResponse>(
        'GetInsuranceVehicleMakes',
        getInsuranceVehicleMakes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceVehicleMakesRequest.fromBuffer(value),
        ($19.GetInsuranceVehicleMakesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverNotificationPreferencesRequest,
            $19.GetMyCoverNotificationPreferencesResponse>(
        'GetMyCoverNotificationPreferences',
        getMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($19.GetMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $19.UpdateMyCoverNotificationPreferencesRequest,
            $19.UpdateMyCoverNotificationPreferencesResponse>(
        'UpdateMyCoverNotificationPreferences',
        updateMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($19.UpdateMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetMyCoverWalletBalanceRequest,
            $19.GetMyCoverWalletBalanceResponse>(
        'GetMyCoverWalletBalance',
        getMyCoverWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetMyCoverWalletBalanceRequest.fromBuffer(value),
        ($19.GetMyCoverWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.RequestInsuranceRefundRequest,
            $19.RequestInsuranceRefundResponse>(
        'RequestInsuranceRefund',
        requestInsuranceRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.RequestInsuranceRefundRequest.fromBuffer(value),
        ($19.RequestInsuranceRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceRefundStatusRequest,
            $19.GetInsuranceRefundStatusResponse>(
        'GetInsuranceRefundStatus',
        getInsuranceRefundStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceRefundStatusRequest.fromBuffer(value),
        ($19.GetInsuranceRefundStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $19.GetInsuranceReconciliationOverviewRequest,
            $19.GetInsuranceReconciliationOverviewResponse>(
        'GetInsuranceReconciliationOverview',
        getInsuranceReconciliationOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceReconciliationOverviewRequest.fromBuffer(value),
        ($19.GetInsuranceReconciliationOverviewResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetOrphanedInsuranceTransactionsRequest,
            $19.GetOrphanedInsuranceTransactionsResponse>(
        'GetOrphanedInsuranceTransactions',
        getOrphanedInsuranceTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetOrphanedInsuranceTransactionsRequest.fromBuffer(value),
        ($19.GetOrphanedInsuranceTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ManualReconcilePurchaseRequest,
            $19.ManualReconcilePurchaseResponse>(
        'ManualReconcilePurchase',
        manualReconcilePurchase_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ManualReconcilePurchaseRequest.fromBuffer(value),
        ($19.ManualReconcilePurchaseResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.AdminTriggerRefundRequest,
            $19.AdminTriggerRefundResponse>(
        'AdminTriggerRefund',
        adminTriggerRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.AdminTriggerRefundRequest.fromBuffer(value),
        ($19.AdminTriggerRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsuranceWebhookEventsRequest,
            $19.GetInsuranceWebhookEventsResponse>(
        'GetInsuranceWebhookEvents',
        getInsuranceWebhookEvents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsuranceWebhookEventsRequest.fromBuffer(value),
        ($19.GetInsuranceWebhookEventsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.RetryFailedWebhookEventRequest,
            $19.RetryFailedWebhookEventResponse>(
        'RetryFailedWebhookEvent',
        retryFailedWebhookEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.RetryFailedWebhookEventRequest.fromBuffer(value),
        ($19.RetryFailedWebhookEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetFailedInsuranceTransactionsRequest,
            $19.GetFailedInsuranceTransactionsResponse>(
        'GetFailedInsuranceTransactions',
        getFailedInsuranceTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetFailedInsuranceTransactionsRequest.fromBuffer(value),
        ($19.GetFailedInsuranceTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateProductMarginRequest,
            $19.UpdateProductMarginResponse>(
        'UpdateProductMargin',
        updateProductMargin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateProductMarginRequest.fromBuffer(value),
        ($19.UpdateProductMarginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetInsurancePlatformWalletsRequest,
            $19.GetInsurancePlatformWalletsResponse>(
        'GetInsurancePlatformWallets',
        getInsurancePlatformWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetInsurancePlatformWalletsRequest.fromBuffer(value),
        ($19.GetInsurancePlatformWalletsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateCrowdfundRequest,
            $19.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateCrowdfundRequest.fromBuffer(value),
        ($19.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetCrowdfundsRequest,
            $19.GetCrowdfundsResponse>(
        'GetCrowdfunds',
        getCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetCrowdfundsRequest.fromBuffer(value),
        ($19.GetCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.GetCrowdfundRequest, $19.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.GetCrowdfundRequest.fromBuffer(value),
            ($19.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ContributeToCrowdfundRequest,
            $19.ContributeToCrowdfundResponse>(
        'ContributeToCrowdfund',
        contributeToCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ContributeToCrowdfundRequest.fromBuffer(value),
        ($19.ContributeToCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.WithdrawFromCrowdfundRequest,
            $19.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($19.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetCrowdfundWithdrawalFeeQuoteRequest,
            $19.GetCrowdfundWithdrawalFeeQuoteResponse>(
        'GetCrowdfundWithdrawalFeeQuote',
        getCrowdfundWithdrawalFeeQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetCrowdfundWithdrawalFeeQuoteRequest.fromBuffer(value),
        ($19.GetCrowdfundWithdrawalFeeQuoteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListCrowdfundCustomCategoriesRequest,
            $19.ListCrowdfundCustomCategoriesResponse>(
        'ListCrowdfundCustomCategories',
        listCrowdfundCustomCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ListCrowdfundCustomCategoriesRequest.fromBuffer(value),
        ($19.ListCrowdfundCustomCategoriesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.AddCrowdfundCustomCategoryRequest,
            $19.AddCrowdfundCustomCategoryResponse>(
        'AddCrowdfundCustomCategory',
        addCrowdfundCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.AddCrowdfundCustomCategoryRequest.fromBuffer(value),
        ($19.AddCrowdfundCustomCategoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteCrowdfundCustomCategoryRequest,
            $19.DeleteCrowdfundCustomCategoryResponse>(
        'DeleteCrowdfundCustomCategory',
        deleteCrowdfundCustomCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteCrowdfundCustomCategoryRequest.fromBuffer(value),
        ($19.DeleteCrowdfundCustomCategoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListCrowdfundWithdrawalsRequest,
            $19.ListCrowdfundWithdrawalsResponse>(
        'ListCrowdfundWithdrawals',
        listCrowdfundWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ListCrowdfundWithdrawalsRequest.fromBuffer(value),
        ($19.ListCrowdfundWithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CloseCrowdfundRequest,
            $19.CloseCrowdfundResponse>(
        'CloseCrowdfund',
        closeCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CloseCrowdfundRequest.fromBuffer(value),
        ($19.CloseCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CancelCrowdfundRequest,
            $19.CancelCrowdfundResponse>(
        'CancelCrowdfund',
        cancelCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CancelCrowdfundRequest.fromBuffer(value),
        ($19.CancelCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ForceCompleteCrowdfundRequest,
            $19.ForceCompleteCrowdfundResponse>(
        'ForceCompleteCrowdfund',
        forceCompleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ForceCompleteCrowdfundRequest.fromBuffer(value),
        ($19.ForceCompleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListCrowdfundRefundsRequest,
            $19.ListCrowdfundRefundsResponse>(
        'ListCrowdfundRefunds',
        listCrowdfundRefunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ListCrowdfundRefundsRequest.fromBuffer(value),
        ($19.ListCrowdfundRefundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.RetryCrowdfundRefundRequest,
            $19.RetryCrowdfundRefundResponse>(
        'RetryCrowdfundRefund',
        retryCrowdfundRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.RetryCrowdfundRefundRequest.fromBuffer(value),
        ($19.RetryCrowdfundRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetCrowdfundStatisticsRequest,
            $19.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($19.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.SearchCrowdfundsRequest,
            $19.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.SearchCrowdfundsRequest.fromBuffer(value),
        ($19.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateCrowdfundRequest,
            $19.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateCrowdfundRequest.fromBuffer(value),
        ($19.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteCrowdfundRequest,
            $19.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteCrowdfundRequest.fromBuffer(value),
        ($19.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetCrowdfundDonationsRequest,
            $19.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($19.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetUserDonationsRequest,
            $19.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetUserDonationsRequest.fromBuffer(value),
        ($19.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GenerateDonationReceiptRequest,
            $19.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GenerateDonationReceiptRequest.fromBuffer(value),
        ($19.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetUserCrowdfundReceiptsRequest,
            $19.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($19.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ConnectNotificationChannelRequest,
            $19.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ConnectNotificationChannelRequest.fromBuffer(value),
        ($19.ConnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DisconnectNotificationChannelRequest,
            $19.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($19.DisconnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetNotificationChannelsRequest,
            $19.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetNotificationChannelsRequest.fromBuffer(value),
        ($19.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateNotificationChannelRequest,
            $19.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateNotificationChannelRequest.fromBuffer(value),
        ($19.UpdateNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.TestNotificationChannelRequest,
            $19.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.TestNotificationChannelRequest.fromBuffer(value),
        ($19.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetTelegramBotInfoRequest,
            $19.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetTelegramBotInfoRequest.fromBuffer(value),
        ($19.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.VerifyTelegramChannelRequest,
            $19.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.VerifyTelegramChannelRequest.fromBuffer(value),
        ($19.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetNotificationHistoryRequest,
            $19.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetNotificationHistoryRequest.fromBuffer(value),
        ($19.GetNotificationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetCrowdfundLeaderboardRequest,
            $19.GetCrowdfundLeaderboardResponse>(
        'GetCrowdfundLeaderboard',
        getCrowdfundLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetCrowdfundLeaderboardRequest.fromBuffer(value),
        ($19.GetCrowdfundLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateAutoSaveRuleRequest2,
            $19.CreateAutoSaveRuleResponse2>(
        'CreateAutoSaveRule',
        createAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateAutoSaveRuleRequest2.fromBuffer(value),
        ($19.CreateAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetAutoSaveRulesRequest2,
            $19.GetAutoSaveRulesResponse2>(
        'GetAutoSaveRules',
        getAutoSaveRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetAutoSaveRulesRequest2.fromBuffer(value),
        ($19.GetAutoSaveRulesResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateAutoSaveRuleRequest2,
            $19.UpdateAutoSaveRuleResponse2>(
        'UpdateAutoSaveRule',
        updateAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateAutoSaveRuleRequest2.fromBuffer(value),
        ($19.UpdateAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ToggleAutoSaveRuleRequest2,
            $19.ToggleAutoSaveRuleResponse2>(
        'ToggleAutoSaveRule',
        toggleAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ToggleAutoSaveRuleRequest2.fromBuffer(value),
        ($19.ToggleAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteAutoSaveRuleRequest2,
            $19.DeleteAutoSaveRuleResponse2>(
        'DeleteAutoSaveRule',
        deleteAutoSaveRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteAutoSaveRuleRequest2.fromBuffer(value),
        ($19.DeleteAutoSaveRuleResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetAutoSaveTransactionsRequest2,
            $19.GetAutoSaveTransactionsResponse2>(
        'GetAutoSaveTransactions',
        getAutoSaveTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetAutoSaveTransactionsRequest2.fromBuffer(value),
        ($19.GetAutoSaveTransactionsResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetAutoSaveStatisticsRequest2,
            $19.GetAutoSaveStatisticsResponse2>(
        'GetAutoSaveStatistics',
        getAutoSaveStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetAutoSaveStatisticsRequest2.fromBuffer(value),
        ($19.GetAutoSaveStatisticsResponse2 value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.TriggerAutoSaveRequest2,
            $19.TriggerAutoSaveResponse2>(
        'TriggerAutoSave',
        triggerAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.TriggerAutoSaveRequest2.fromBuffer(value),
        ($19.TriggerAutoSaveResponse2 value) => value.writeToBuffer()));
  }

  $async.Future<$19.CreateGroupAccountResponse> createGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateGroupAccountRequest> request) async {
    return createGroupAccount(call, await request);
  }

  $async.Future<$19.GetGroupAccountsResponse> getGroupAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetGroupAccountsRequest> request) async {
    return getGroupAccounts(call, await request);
  }

  $async.Future<$19.GetGroupAccountResponse> getGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetGroupAccountRequest> request) async {
    return getGroupAccount(call, await request);
  }

  $async.Future<$19.AddGroupMemberResponse> addGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.AddGroupMemberRequest> request) async {
    return addGroupMember(call, await request);
  }

  $async.Future<$19.RemoveGroupMemberResponse> removeGroupMember_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.RemoveGroupMemberRequest> request) async {
    return removeGroupMember(call, await request);
  }

  $async.Future<$19.ContributeToGroupResponse> contributeToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.ContributeToGroupRequest> request) async {
    return contributeToGroup(call, await request);
  }

  $async.Future<$19.WithdrawFromGroupResponse> withdrawFromGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.WithdrawFromGroupRequest> request) async {
    return withdrawFromGroup(call, await request);
  }

  $async.Future<$19.CloseGroupAccountResponse> closeGroupAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CloseGroupAccountRequest> request) async {
    return closeGroupAccount(call, await request);
  }

  $async.Future<$19.BuyInsuranceResponse> buyInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.BuyInsuranceRequest> request) async {
    return buyInsurance(call, await request);
  }

  $async.Future<$19.GetInsurancePoliciesResponse> getInsurancePolicies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsurancePoliciesRequest> request) async {
    return getInsurancePolicies(call, await request);
  }

  $async.Future<$19.GetInsurancePolicyResponse> getInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsurancePolicyRequest> request) async {
    return getInsurancePolicy(call, await request);
  }

  $async.Future<$19.MakeInsuranceClaimResponse> makeInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.MakeInsuranceClaimRequest> request) async {
    return makeInsuranceClaim(call, await request);
  }

  $async.Future<$19.CancelInsuranceResponse> cancelInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CancelInsuranceRequest> request) async {
    return cancelInsurance(call, await request);
  }

  $async.Future<$19.GetInsurancePlansResponse> getInsurancePlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsurancePlansRequest> request) async {
    return getInsurancePlans(call, await request);
  }

  $async.Future<$19.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceMarketplaceProductsRequest>
              request) async {
    return getInsuranceMarketplaceProducts(call, await request);
  }

  $async.Future<$19.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceMarketplaceCategoriesRequest>
              request) async {
    return getInsuranceMarketplaceCategories(call, await request);
  }

  $async.Future<$19.GetInsuranceQuoteResponse> getInsuranceQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsuranceQuoteRequest> request) async {
    return getInsuranceQuote(call, await request);
  }

  $async.Future<$19.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.PurchaseMarketplaceInsuranceRequest>
              request) async {
    return purchaseMarketplaceInsurance(call, await request);
  }

  $async.Future<$19.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsurancePurchaseStatusRequest> request) async {
    return getInsurancePurchaseStatus(call, await request);
  }

  $async.Future<$19.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument_Pre($grpc.ServiceCall call,
          $async.Future<$19.UploadInsuranceDocumentRequest> request) async {
    return uploadInsuranceDocument(call, await request);
  }

  $async.Future<$19.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceDocumentUploadURLRequest>
              request) async {
    return getInsuranceDocumentUploadURL(call, await request);
  }

  $async.Future<$19.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceAuxiliaryDataRequest> request) async {
    return getInsuranceAuxiliaryData(call, await request);
  }

  $async.Future<$19.GetInsurancePaymentsResponse> getInsurancePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$19.GetUserInsurancePaymentsResponse>
      getUserInsurancePayments_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetUserInsurancePaymentsRequest> request) async {
    return getUserInsurancePayments(call, await request);
  }

  $async.Future<$19.CreateInsurancePaymentResponse> createInsurancePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateInsurancePaymentRequest> request) async {
    return createInsurancePayment(call, await request);
  }

  $async.Future<$19.ProcessInsurancePaymentResponse>
      processInsurancePayment_Pre($grpc.ServiceCall call,
          $async.Future<$19.ProcessInsurancePaymentRequest> request) async {
    return processInsurancePayment(call, await request);
  }

  $async.Future<$19.GetInsurancePaymentByIdResponse>
      getInsurancePaymentById_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsurancePaymentByIdRequest> request) async {
    return getInsurancePaymentById(call, await request);
  }

  $async.Future<$19.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetOverdueInsurancePaymentsRequest> request) async {
    return getOverdueInsurancePayments(call, await request);
  }

  $async.Future<$19.GetInsuranceClaimsResponse> getInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$19.GetUserInsuranceClaimsResponse> getUserInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetUserInsuranceClaimsRequest> request) async {
    return getUserInsuranceClaims(call, await request);
  }

  $async.Future<$19.UpdateInsuranceClaimResponse> updateInsuranceClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateInsuranceClaimRequest> request) async {
    return updateInsuranceClaim(call, await request);
  }

  $async.Future<$19.GetInsuranceClaimByIdResponse> getInsuranceClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsuranceClaimByIdRequest> request) async {
    return getInsuranceClaimById(call, await request);
  }

  $async.Future<$19.UpdateInsurancePolicyResponse> updateInsurancePolicy_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateInsurancePolicyRequest> request) async {
    return updateInsurancePolicy(call, await request);
  }

  $async.Future<$19.GenerateInsuranceReceiptResponse>
      generateInsuranceReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$19.GenerateInsuranceReceiptRequest> request) async {
    return generateInsuranceReceipt(call, await request);
  }

  $async.Future<$19.GetUserInsuranceReceiptsResponse>
      getUserInsuranceReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetUserInsuranceReceiptsRequest> request) async {
    return getUserInsuranceReceipts(call, await request);
  }

  $async.Future<$19.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$19.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetInsurancePaymentStatisticsRequest>
              request) async {
    return getInsurancePaymentStatistics(call, await request);
  }

  $async.Future<$19.GetMyCoverCustomersResponse> getMyCoverCustomers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyCoverCustomersRequest> request) async {
    return getMyCoverCustomers(call, await request);
  }

  $async.Future<$19.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyCoverCustomerByIdRequest> request) async {
    return getMyCoverCustomerById(call, await request);
  }

  $async.Future<$19.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetMyCoverCustomerPoliciesRequest> request) async {
    return getMyCoverCustomerPolicies(call, await request);
  }

  $async.Future<$19.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetMyCoverCustomerPurchasesRequest> request) async {
    return getMyCoverCustomerPurchases(call, await request);
  }

  $async.Future<$19.GetMyCoverPurchasesResponse> getMyCoverPurchases_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyCoverPurchasesRequest> request) async {
    return getMyCoverPurchases(call, await request);
  }

  $async.Future<$19.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyCoverPurchaseByIdRequest> request) async {
    return getMyCoverPurchaseById(call, await request);
  }

  $async.Future<$19.GetMyCoverClaimsResponse> getMyCoverClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyCoverClaimsRequest> request) async {
    return getMyCoverClaims(call, await request);
  }

  $async.Future<$19.GetMyCoverClaimByIdResponse> getMyCoverClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetMyCoverClaimByIdRequest> request) async {
    return getMyCoverClaimById(call, await request);
  }

  $async.Future<$19.FileCreditLifeClaimResponse> fileCreditLifeClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.FileCreditLifeClaimRequest> request) async {
    return fileCreditLifeClaim(call, await request);
  }

  $async.Future<$19.GetInsuranceStatesResponse> getInsuranceStates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetInsuranceStatesRequest> request) async {
    return getInsuranceStates(call, await request);
  }

  $async.Future<$19.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceVehicleMakesRequest> request) async {
    return getInsuranceVehicleMakes(call, await request);
  }

  $async.Future<$19.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetMyCoverNotificationPreferencesRequest>
              request) async {
    return getMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$19.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.UpdateMyCoverNotificationPreferencesRequest>
              request) async {
    return updateMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$19.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetMyCoverWalletBalanceRequest> request) async {
    return getMyCoverWalletBalance(call, await request);
  }

  $async.Future<$19.RequestInsuranceRefundResponse> requestInsuranceRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.RequestInsuranceRefundRequest> request) async {
    return requestInsuranceRefund(call, await request);
  }

  $async.Future<$19.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceRefundStatusRequest> request) async {
    return getInsuranceRefundStatus(call, await request);
  }

  $async.Future<$19.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceReconciliationOverviewRequest>
              request) async {
    return getInsuranceReconciliationOverview(call, await request);
  }

  $async.Future<$19.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetOrphanedInsuranceTransactionsRequest>
              request) async {
    return getOrphanedInsuranceTransactions(call, await request);
  }

  $async.Future<$19.ManualReconcilePurchaseResponse>
      manualReconcilePurchase_Pre($grpc.ServiceCall call,
          $async.Future<$19.ManualReconcilePurchaseRequest> request) async {
    return manualReconcilePurchase(call, await request);
  }

  $async.Future<$19.AdminTriggerRefundResponse> adminTriggerRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.AdminTriggerRefundRequest> request) async {
    return adminTriggerRefund(call, await request);
  }

  $async.Future<$19.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsuranceWebhookEventsRequest> request) async {
    return getInsuranceWebhookEvents(call, await request);
  }

  $async.Future<$19.RetryFailedWebhookEventResponse>
      retryFailedWebhookEvent_Pre($grpc.ServiceCall call,
          $async.Future<$19.RetryFailedWebhookEventRequest> request) async {
    return retryFailedWebhookEvent(call, await request);
  }

  $async.Future<$19.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetFailedInsuranceTransactionsRequest>
              request) async {
    return getFailedInsuranceTransactions(call, await request);
  }

  $async.Future<$19.UpdateProductMarginResponse> updateProductMargin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateProductMarginRequest> request) async {
    return updateProductMargin(call, await request);
  }

  $async.Future<$19.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetInsurancePlatformWalletsRequest> request) async {
    return getInsurancePlatformWallets(call, await request);
  }

  $async.Future<$19.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$19.GetCrowdfundsResponse> getCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetCrowdfundsRequest> request) async {
    return getCrowdfunds(call, await request);
  }

  $async.Future<$19.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$19.ContributeToCrowdfundResponse> contributeToCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.ContributeToCrowdfundRequest> request) async {
    return contributeToCrowdfund(call, await request);
  }

  $async.Future<$19.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$19.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.GetCrowdfundWithdrawalFeeQuoteRequest>
              request) async {
    return getCrowdfundWithdrawalFeeQuote(call, await request);
  }

  $async.Future<$19.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.ListCrowdfundCustomCategoriesRequest>
              request) async {
    return listCrowdfundCustomCategories(call, await request);
  }

  $async.Future<$19.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory_Pre($grpc.ServiceCall call,
          $async.Future<$19.AddCrowdfundCustomCategoryRequest> request) async {
    return addCrowdfundCustomCategory(call, await request);
  }

  $async.Future<$19.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.DeleteCrowdfundCustomCategoryRequest>
              request) async {
    return deleteCrowdfundCustomCategory(call, await request);
  }

  $async.Future<$19.ListCrowdfundWithdrawalsResponse>
      listCrowdfundWithdrawals_Pre($grpc.ServiceCall call,
          $async.Future<$19.ListCrowdfundWithdrawalsRequest> request) async {
    return listCrowdfundWithdrawals(call, await request);
  }

  $async.Future<$19.CloseCrowdfundResponse> closeCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CloseCrowdfundRequest> request) async {
    return closeCrowdfund(call, await request);
  }

  $async.Future<$19.CancelCrowdfundResponse> cancelCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CancelCrowdfundRequest> request) async {
    return cancelCrowdfund(call, await request);
  }

  $async.Future<$19.ForceCompleteCrowdfundResponse> forceCompleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.ForceCompleteCrowdfundRequest> request) async {
    return forceCompleteCrowdfund(call, await request);
  }

  $async.Future<$19.ListCrowdfundRefundsResponse> listCrowdfundRefunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.ListCrowdfundRefundsRequest> request) async {
    return listCrowdfundRefunds(call, await request);
  }

  $async.Future<$19.RetryCrowdfundRefundResponse> retryCrowdfundRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.RetryCrowdfundRefundRequest> request) async {
    return retryCrowdfundRefund(call, await request);
  }

  $async.Future<$19.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$19.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$19.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$19.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$19.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$19.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$19.GenerateDonationReceiptResponse>
      generateDonationReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$19.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$19.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$19.ConnectNotificationChannelResponse>
      connectNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$19.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$19.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel_Pre(
          $grpc.ServiceCall call,
          $async.Future<$19.DisconnectNotificationChannelRequest>
              request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$19.GetNotificationChannelsResponse>
      getNotificationChannels_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$19.UpdateNotificationChannelResponse>
      updateNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$19.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$19.TestNotificationChannelResponse>
      testNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$19.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$19.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$19.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$19.GetNotificationHistoryResponse> getNotificationHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$19.GetCrowdfundLeaderboardResponse>
      getCrowdfundLeaderboard_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetCrowdfundLeaderboardRequest> request) async {
    return getCrowdfundLeaderboard(call, await request);
  }

  $async.Future<$19.CreateAutoSaveRuleResponse2> createAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateAutoSaveRuleRequest2> request) async {
    return createAutoSaveRule(call, await request);
  }

  $async.Future<$19.GetAutoSaveRulesResponse2> getAutoSaveRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetAutoSaveRulesRequest2> request) async {
    return getAutoSaveRules(call, await request);
  }

  $async.Future<$19.UpdateAutoSaveRuleResponse2> updateAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateAutoSaveRuleRequest2> request) async {
    return updateAutoSaveRule(call, await request);
  }

  $async.Future<$19.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.ToggleAutoSaveRuleRequest2> request) async {
    return toggleAutoSaveRule(call, await request);
  }

  $async.Future<$19.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.DeleteAutoSaveRuleRequest2> request) async {
    return deleteAutoSaveRule(call, await request);
  }

  $async.Future<$19.GetAutoSaveTransactionsResponse2>
      getAutoSaveTransactions_Pre($grpc.ServiceCall call,
          $async.Future<$19.GetAutoSaveTransactionsRequest2> request) async {
    return getAutoSaveTransactions(call, await request);
  }

  $async.Future<$19.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetAutoSaveStatisticsRequest2> request) async {
    return getAutoSaveStatistics(call, await request);
  }

  $async.Future<$19.TriggerAutoSaveResponse2> triggerAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.TriggerAutoSaveRequest2> request) async {
    return triggerAutoSave(call, await request);
  }

  $async.Future<$19.CreateGroupAccountResponse> createGroupAccount(
      $grpc.ServiceCall call, $19.CreateGroupAccountRequest request);
  $async.Future<$19.GetGroupAccountsResponse> getGroupAccounts(
      $grpc.ServiceCall call, $19.GetGroupAccountsRequest request);
  $async.Future<$19.GetGroupAccountResponse> getGroupAccount(
      $grpc.ServiceCall call, $19.GetGroupAccountRequest request);
  $async.Future<$19.AddGroupMemberResponse> addGroupMember(
      $grpc.ServiceCall call, $19.AddGroupMemberRequest request);
  $async.Future<$19.RemoveGroupMemberResponse> removeGroupMember(
      $grpc.ServiceCall call, $19.RemoveGroupMemberRequest request);
  $async.Future<$19.ContributeToGroupResponse> contributeToGroup(
      $grpc.ServiceCall call, $19.ContributeToGroupRequest request);
  $async.Future<$19.WithdrawFromGroupResponse> withdrawFromGroup(
      $grpc.ServiceCall call, $19.WithdrawFromGroupRequest request);
  $async.Future<$19.CloseGroupAccountResponse> closeGroupAccount(
      $grpc.ServiceCall call, $19.CloseGroupAccountRequest request);
  $async.Future<$19.BuyInsuranceResponse> buyInsurance(
      $grpc.ServiceCall call, $19.BuyInsuranceRequest request);
  $async.Future<$19.GetInsurancePoliciesResponse> getInsurancePolicies(
      $grpc.ServiceCall call, $19.GetInsurancePoliciesRequest request);
  $async.Future<$19.GetInsurancePolicyResponse> getInsurancePolicy(
      $grpc.ServiceCall call, $19.GetInsurancePolicyRequest request);
  $async.Future<$19.MakeInsuranceClaimResponse> makeInsuranceClaim(
      $grpc.ServiceCall call, $19.MakeInsuranceClaimRequest request);
  $async.Future<$19.CancelInsuranceResponse> cancelInsurance(
      $grpc.ServiceCall call, $19.CancelInsuranceRequest request);
  $async.Future<$19.GetInsurancePlansResponse> getInsurancePlans(
      $grpc.ServiceCall call, $19.GetInsurancePlansRequest request);
  $async.Future<$19.GetInsuranceMarketplaceProductsResponse>
      getInsuranceMarketplaceProducts($grpc.ServiceCall call,
          $19.GetInsuranceMarketplaceProductsRequest request);
  $async.Future<$19.GetInsuranceMarketplaceCategoriesResponse>
      getInsuranceMarketplaceCategories($grpc.ServiceCall call,
          $19.GetInsuranceMarketplaceCategoriesRequest request);
  $async.Future<$19.GetInsuranceQuoteResponse> getInsuranceQuote(
      $grpc.ServiceCall call, $19.GetInsuranceQuoteRequest request);
  $async.Future<$19.PurchaseMarketplaceInsuranceResponse>
      purchaseMarketplaceInsurance($grpc.ServiceCall call,
          $19.PurchaseMarketplaceInsuranceRequest request);
  $async.Future<$19.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($grpc.ServiceCall call,
          $19.GetInsurancePurchaseStatusRequest request);
  $async.Future<$19.UploadInsuranceDocumentResponse> uploadInsuranceDocument(
      $grpc.ServiceCall call, $19.UploadInsuranceDocumentRequest request);
  $async.Future<$19.GetInsuranceDocumentUploadURLResponse>
      getInsuranceDocumentUploadURL($grpc.ServiceCall call,
          $19.GetInsuranceDocumentUploadURLRequest request);
  $async.Future<$19.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData(
          $grpc.ServiceCall call, $19.GetInsuranceAuxiliaryDataRequest request);
  $async.Future<$19.GetInsurancePaymentsResponse> getInsurancePayments(
      $grpc.ServiceCall call, $19.GetInsurancePaymentsRequest request);
  $async.Future<$19.GetUserInsurancePaymentsResponse> getUserInsurancePayments(
      $grpc.ServiceCall call, $19.GetUserInsurancePaymentsRequest request);
  $async.Future<$19.CreateInsurancePaymentResponse> createInsurancePayment(
      $grpc.ServiceCall call, $19.CreateInsurancePaymentRequest request);
  $async.Future<$19.ProcessInsurancePaymentResponse> processInsurancePayment(
      $grpc.ServiceCall call, $19.ProcessInsurancePaymentRequest request);
  $async.Future<$19.GetInsurancePaymentByIdResponse> getInsurancePaymentById(
      $grpc.ServiceCall call, $19.GetInsurancePaymentByIdRequest request);
  $async.Future<$19.GetOverdueInsurancePaymentsResponse>
      getOverdueInsurancePayments($grpc.ServiceCall call,
          $19.GetOverdueInsurancePaymentsRequest request);
  $async.Future<$19.GetInsuranceClaimsResponse> getInsuranceClaims(
      $grpc.ServiceCall call, $19.GetInsuranceClaimsRequest request);
  $async.Future<$19.GetUserInsuranceClaimsResponse> getUserInsuranceClaims(
      $grpc.ServiceCall call, $19.GetUserInsuranceClaimsRequest request);
  $async.Future<$19.UpdateInsuranceClaimResponse> updateInsuranceClaim(
      $grpc.ServiceCall call, $19.UpdateInsuranceClaimRequest request);
  $async.Future<$19.GetInsuranceClaimByIdResponse> getInsuranceClaimById(
      $grpc.ServiceCall call, $19.GetInsuranceClaimByIdRequest request);
  $async.Future<$19.UpdateInsurancePolicyResponse> updateInsurancePolicy(
      $grpc.ServiceCall call, $19.UpdateInsurancePolicyRequest request);
  $async.Future<$19.GenerateInsuranceReceiptResponse> generateInsuranceReceipt(
      $grpc.ServiceCall call, $19.GenerateInsuranceReceiptRequest request);
  $async.Future<$19.GetUserInsuranceReceiptsResponse> getUserInsuranceReceipts(
      $grpc.ServiceCall call, $19.GetUserInsuranceReceiptsRequest request);
  $async.Future<$19.GetInsuranceStatisticsResponse> getInsuranceStatistics(
      $grpc.ServiceCall call, $19.GetInsuranceStatisticsRequest request);
  $async.Future<$19.GetInsurancePaymentStatisticsResponse>
      getInsurancePaymentStatistics($grpc.ServiceCall call,
          $19.GetInsurancePaymentStatisticsRequest request);
  $async.Future<$19.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $grpc.ServiceCall call, $19.GetMyCoverCustomersRequest request);
  $async.Future<$19.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById(
      $grpc.ServiceCall call, $19.GetMyCoverCustomerByIdRequest request);
  $async.Future<$19.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($grpc.ServiceCall call,
          $19.GetMyCoverCustomerPoliciesRequest request);
  $async.Future<$19.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($grpc.ServiceCall call,
          $19.GetMyCoverCustomerPurchasesRequest request);
  $async.Future<$19.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $grpc.ServiceCall call, $19.GetMyCoverPurchasesRequest request);
  $async.Future<$19.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById(
      $grpc.ServiceCall call, $19.GetMyCoverPurchaseByIdRequest request);
  $async.Future<$19.GetMyCoverClaimsResponse> getMyCoverClaims(
      $grpc.ServiceCall call, $19.GetMyCoverClaimsRequest request);
  $async.Future<$19.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $grpc.ServiceCall call, $19.GetMyCoverClaimByIdRequest request);
  $async.Future<$19.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $grpc.ServiceCall call, $19.FileCreditLifeClaimRequest request);
  $async.Future<$19.GetInsuranceStatesResponse> getInsuranceStates(
      $grpc.ServiceCall call, $19.GetInsuranceStatesRequest request);
  $async.Future<$19.GetInsuranceVehicleMakesResponse> getInsuranceVehicleMakes(
      $grpc.ServiceCall call, $19.GetInsuranceVehicleMakesRequest request);
  $async.Future<$19.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences($grpc.ServiceCall call,
          $19.GetMyCoverNotificationPreferencesRequest request);
  $async.Future<$19.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences($grpc.ServiceCall call,
          $19.UpdateMyCoverNotificationPreferencesRequest request);
  $async.Future<$19.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance(
      $grpc.ServiceCall call, $19.GetMyCoverWalletBalanceRequest request);
  $async.Future<$19.RequestInsuranceRefundResponse> requestInsuranceRefund(
      $grpc.ServiceCall call, $19.RequestInsuranceRefundRequest request);
  $async.Future<$19.GetInsuranceRefundStatusResponse> getInsuranceRefundStatus(
      $grpc.ServiceCall call, $19.GetInsuranceRefundStatusRequest request);
  $async.Future<$19.GetInsuranceReconciliationOverviewResponse>
      getInsuranceReconciliationOverview($grpc.ServiceCall call,
          $19.GetInsuranceReconciliationOverviewRequest request);
  $async.Future<$19.GetOrphanedInsuranceTransactionsResponse>
      getOrphanedInsuranceTransactions($grpc.ServiceCall call,
          $19.GetOrphanedInsuranceTransactionsRequest request);
  $async.Future<$19.ManualReconcilePurchaseResponse> manualReconcilePurchase(
      $grpc.ServiceCall call, $19.ManualReconcilePurchaseRequest request);
  $async.Future<$19.AdminTriggerRefundResponse> adminTriggerRefund(
      $grpc.ServiceCall call, $19.AdminTriggerRefundRequest request);
  $async.Future<$19.GetInsuranceWebhookEventsResponse>
      getInsuranceWebhookEvents(
          $grpc.ServiceCall call, $19.GetInsuranceWebhookEventsRequest request);
  $async.Future<$19.RetryFailedWebhookEventResponse> retryFailedWebhookEvent(
      $grpc.ServiceCall call, $19.RetryFailedWebhookEventRequest request);
  $async.Future<$19.GetFailedInsuranceTransactionsResponse>
      getFailedInsuranceTransactions($grpc.ServiceCall call,
          $19.GetFailedInsuranceTransactionsRequest request);
  $async.Future<$19.UpdateProductMarginResponse> updateProductMargin(
      $grpc.ServiceCall call, $19.UpdateProductMarginRequest request);
  $async.Future<$19.GetInsurancePlatformWalletsResponse>
      getInsurancePlatformWallets($grpc.ServiceCall call,
          $19.GetInsurancePlatformWalletsRequest request);
  $async.Future<$19.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $19.CreateCrowdfundRequest request);
  $async.Future<$19.GetCrowdfundsResponse> getCrowdfunds(
      $grpc.ServiceCall call, $19.GetCrowdfundsRequest request);
  $async.Future<$19.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $19.GetCrowdfundRequest request);
  $async.Future<$19.ContributeToCrowdfundResponse> contributeToCrowdfund(
      $grpc.ServiceCall call, $19.ContributeToCrowdfundRequest request);
  $async.Future<$19.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $grpc.ServiceCall call, $19.WithdrawFromCrowdfundRequest request);
  $async.Future<$19.GetCrowdfundWithdrawalFeeQuoteResponse>
      getCrowdfundWithdrawalFeeQuote($grpc.ServiceCall call,
          $19.GetCrowdfundWithdrawalFeeQuoteRequest request);
  $async.Future<$19.ListCrowdfundCustomCategoriesResponse>
      listCrowdfundCustomCategories($grpc.ServiceCall call,
          $19.ListCrowdfundCustomCategoriesRequest request);
  $async.Future<$19.AddCrowdfundCustomCategoryResponse>
      addCrowdfundCustomCategory($grpc.ServiceCall call,
          $19.AddCrowdfundCustomCategoryRequest request);
  $async.Future<$19.DeleteCrowdfundCustomCategoryResponse>
      deleteCrowdfundCustomCategory($grpc.ServiceCall call,
          $19.DeleteCrowdfundCustomCategoryRequest request);
  $async.Future<$19.ListCrowdfundWithdrawalsResponse> listCrowdfundWithdrawals(
      $grpc.ServiceCall call, $19.ListCrowdfundWithdrawalsRequest request);
  $async.Future<$19.CloseCrowdfundResponse> closeCrowdfund(
      $grpc.ServiceCall call, $19.CloseCrowdfundRequest request);
  $async.Future<$19.CancelCrowdfundResponse> cancelCrowdfund(
      $grpc.ServiceCall call, $19.CancelCrowdfundRequest request);
  $async.Future<$19.ForceCompleteCrowdfundResponse> forceCompleteCrowdfund(
      $grpc.ServiceCall call, $19.ForceCompleteCrowdfundRequest request);
  $async.Future<$19.ListCrowdfundRefundsResponse> listCrowdfundRefunds(
      $grpc.ServiceCall call, $19.ListCrowdfundRefundsRequest request);
  $async.Future<$19.RetryCrowdfundRefundResponse> retryCrowdfundRefund(
      $grpc.ServiceCall call, $19.RetryCrowdfundRefundRequest request);
  $async.Future<$19.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $19.GetCrowdfundStatisticsRequest request);
  $async.Future<$19.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $19.SearchCrowdfundsRequest request);
  $async.Future<$19.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $19.UpdateCrowdfundRequest request);
  $async.Future<$19.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $19.DeleteCrowdfundRequest request);
  $async.Future<$19.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $19.GetCrowdfundDonationsRequest request);
  $async.Future<$19.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $19.GetUserDonationsRequest request);
  $async.Future<$19.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $19.GenerateDonationReceiptRequest request);
  $async.Future<$19.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $19.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$19.ConnectNotificationChannelResponse>
      connectNotificationChannel($grpc.ServiceCall call,
          $19.ConnectNotificationChannelRequest request);
  $async.Future<$19.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel($grpc.ServiceCall call,
          $19.DisconnectNotificationChannelRequest request);
  $async.Future<$19.GetNotificationChannelsResponse> getNotificationChannels(
      $grpc.ServiceCall call, $19.GetNotificationChannelsRequest request);
  $async.Future<$19.UpdateNotificationChannelResponse>
      updateNotificationChannel(
          $grpc.ServiceCall call, $19.UpdateNotificationChannelRequest request);
  $async.Future<$19.TestNotificationChannelResponse> testNotificationChannel(
      $grpc.ServiceCall call, $19.TestNotificationChannelRequest request);
  $async.Future<$19.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $grpc.ServiceCall call, $19.GetTelegramBotInfoRequest request);
  $async.Future<$19.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $grpc.ServiceCall call, $19.VerifyTelegramChannelRequest request);
  $async.Future<$19.GetNotificationHistoryResponse> getNotificationHistory(
      $grpc.ServiceCall call, $19.GetNotificationHistoryRequest request);
  $async.Future<$19.GetCrowdfundLeaderboardResponse> getCrowdfundLeaderboard(
      $grpc.ServiceCall call, $19.GetCrowdfundLeaderboardRequest request);
  $async.Future<$19.CreateAutoSaveRuleResponse2> createAutoSaveRule(
      $grpc.ServiceCall call, $19.CreateAutoSaveRuleRequest2 request);
  $async.Future<$19.GetAutoSaveRulesResponse2> getAutoSaveRules(
      $grpc.ServiceCall call, $19.GetAutoSaveRulesRequest2 request);
  $async.Future<$19.UpdateAutoSaveRuleResponse2> updateAutoSaveRule(
      $grpc.ServiceCall call, $19.UpdateAutoSaveRuleRequest2 request);
  $async.Future<$19.ToggleAutoSaveRuleResponse2> toggleAutoSaveRule(
      $grpc.ServiceCall call, $19.ToggleAutoSaveRuleRequest2 request);
  $async.Future<$19.DeleteAutoSaveRuleResponse2> deleteAutoSaveRule(
      $grpc.ServiceCall call, $19.DeleteAutoSaveRuleRequest2 request);
  $async.Future<$19.GetAutoSaveTransactionsResponse2> getAutoSaveTransactions(
      $grpc.ServiceCall call, $19.GetAutoSaveTransactionsRequest2 request);
  $async.Future<$19.GetAutoSaveStatisticsResponse2> getAutoSaveStatistics(
      $grpc.ServiceCall call, $19.GetAutoSaveStatisticsRequest2 request);
  $async.Future<$19.TriggerAutoSaveResponse2> triggerAutoSave(
      $grpc.ServiceCall call, $19.TriggerAutoSaveRequest2 request);
}
