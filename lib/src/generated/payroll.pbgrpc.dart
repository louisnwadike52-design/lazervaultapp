//
//  Generated code. Do not modify.
//  source: payroll.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'payroll.pb.dart' as $0;

export 'payroll.pb.dart';

@$pb.GrpcServiceName('pb.PayrollService')
class PayrollServiceClient extends $grpc.Client {
  static final _$addEmployee = $grpc.ClientMethod<$0.AddEmployeeRequest, $0.AddEmployeeResponse>(
      '/pb.PayrollService/AddEmployee',
      ($0.AddEmployeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddEmployeeResponse.fromBuffer(value));
  static final _$updateEmployee = $grpc.ClientMethod<$0.UpdateEmployeeRequest, $0.UpdateEmployeeResponse>(
      '/pb.PayrollService/UpdateEmployee',
      ($0.UpdateEmployeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateEmployeeResponse.fromBuffer(value));
  static final _$removeEmployee = $grpc.ClientMethod<$0.RemoveEmployeeRequest, $0.RemoveEmployeeResponse>(
      '/pb.PayrollService/RemoveEmployee',
      ($0.RemoveEmployeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RemoveEmployeeResponse.fromBuffer(value));
  static final _$getEmployee = $grpc.ClientMethod<$0.GetEmployeeRequest, $0.GetEmployeeResponse>(
      '/pb.PayrollService/GetEmployee',
      ($0.GetEmployeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetEmployeeResponse.fromBuffer(value));
  static final _$listEmployees = $grpc.ClientMethod<$0.ListEmployeesRequest, $0.ListEmployeesResponse>(
      '/pb.PayrollService/ListEmployees',
      ($0.ListEmployeesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListEmployeesResponse.fromBuffer(value));
  static final _$createPayRun = $grpc.ClientMethod<$0.CreatePayRunRequest, $0.CreatePayRunResponse>(
      '/pb.PayrollService/CreatePayRun',
      ($0.CreatePayRunRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreatePayRunResponse.fromBuffer(value));
  static final _$calculatePayRun = $grpc.ClientMethod<$0.CalculatePayRunRequest, $0.CalculatePayRunResponse>(
      '/pb.PayrollService/CalculatePayRun',
      ($0.CalculatePayRunRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CalculatePayRunResponse.fromBuffer(value));
  static final _$approvePayRun = $grpc.ClientMethod<$0.ApprovePayRunRequest, $0.ApprovePayRunResponse>(
      '/pb.PayrollService/ApprovePayRun',
      ($0.ApprovePayRunRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ApprovePayRunResponse.fromBuffer(value));
  static final _$processPayRun = $grpc.ClientMethod<$0.ProcessPayRunRequest, $0.ProcessPayRunResponse>(
      '/pb.PayrollService/ProcessPayRun',
      ($0.ProcessPayRunRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ProcessPayRunResponse.fromBuffer(value));
  static final _$getPayRun = $grpc.ClientMethod<$0.GetPayRunRequest, $0.GetPayRunResponse>(
      '/pb.PayrollService/GetPayRun',
      ($0.GetPayRunRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPayRunResponse.fromBuffer(value));
  static final _$listPayRuns = $grpc.ClientMethod<$0.ListPayRunsRequest, $0.ListPayRunsResponse>(
      '/pb.PayrollService/ListPayRuns',
      ($0.ListPayRunsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListPayRunsResponse.fromBuffer(value));
  static final _$getPaySlip = $grpc.ClientMethod<$0.GetPaySlipRequest, $0.GetPaySlipResponse>(
      '/pb.PayrollService/GetPaySlip',
      ($0.GetPaySlipRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPaySlipResponse.fromBuffer(value));
  static final _$listPaySlips = $grpc.ClientMethod<$0.ListPaySlipsRequest, $0.ListPaySlipsResponse>(
      '/pb.PayrollService/ListPaySlips',
      ($0.ListPaySlipsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListPaySlipsResponse.fromBuffer(value));
  static final _$getPayrollSummary = $grpc.ClientMethod<$0.GetPayrollSummaryRequest, $0.GetPayrollSummaryResponse>(
      '/pb.PayrollService/GetPayrollSummary',
      ($0.GetPayrollSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPayrollSummaryResponse.fromBuffer(value));
  static final _$getTaxReport = $grpc.ClientMethod<$0.GetTaxReportRequest, $0.GetTaxReportResponse>(
      '/pb.PayrollService/GetTaxReport',
      ($0.GetTaxReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaxReportResponse.fromBuffer(value));

  PayrollServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.AddEmployeeResponse> addEmployee($0.AddEmployeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addEmployee, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateEmployeeResponse> updateEmployee($0.UpdateEmployeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEmployee, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveEmployeeResponse> removeEmployee($0.RemoveEmployeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeEmployee, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEmployeeResponse> getEmployee($0.GetEmployeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEmployee, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListEmployeesResponse> listEmployees($0.ListEmployeesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listEmployees, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreatePayRunResponse> createPayRun($0.CreatePayRunRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPayRun, request, options: options);
  }

  $grpc.ResponseFuture<$0.CalculatePayRunResponse> calculatePayRun($0.CalculatePayRunRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculatePayRun, request, options: options);
  }

  $grpc.ResponseFuture<$0.ApprovePayRunResponse> approvePayRun($0.ApprovePayRunRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approvePayRun, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessPayRunResponse> processPayRun($0.ProcessPayRunRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayRun, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPayRunResponse> getPayRun($0.GetPayRunRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayRun, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPayRunsResponse> listPayRuns($0.ListPayRunsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPayRuns, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaySlipResponse> getPaySlip($0.GetPaySlipRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaySlip, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPaySlipsResponse> listPaySlips($0.ListPaySlipsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPaySlips, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPayrollSummaryResponse> getPayrollSummary($0.GetPayrollSummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPayrollSummary, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTaxReportResponse> getTaxReport($0.GetTaxReportRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaxReport, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.PayrollService')
abstract class PayrollServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.PayrollService';

  PayrollServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AddEmployeeRequest, $0.AddEmployeeResponse>(
        'AddEmployee',
        addEmployee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddEmployeeRequest.fromBuffer(value),
        ($0.AddEmployeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateEmployeeRequest, $0.UpdateEmployeeResponse>(
        'UpdateEmployee',
        updateEmployee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateEmployeeRequest.fromBuffer(value),
        ($0.UpdateEmployeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveEmployeeRequest, $0.RemoveEmployeeResponse>(
        'RemoveEmployee',
        removeEmployee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RemoveEmployeeRequest.fromBuffer(value),
        ($0.RemoveEmployeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEmployeeRequest, $0.GetEmployeeResponse>(
        'GetEmployee',
        getEmployee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetEmployeeRequest.fromBuffer(value),
        ($0.GetEmployeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListEmployeesRequest, $0.ListEmployeesResponse>(
        'ListEmployees',
        listEmployees_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListEmployeesRequest.fromBuffer(value),
        ($0.ListEmployeesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreatePayRunRequest, $0.CreatePayRunResponse>(
        'CreatePayRun',
        createPayRun_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreatePayRunRequest.fromBuffer(value),
        ($0.CreatePayRunResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CalculatePayRunRequest, $0.CalculatePayRunResponse>(
        'CalculatePayRun',
        calculatePayRun_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CalculatePayRunRequest.fromBuffer(value),
        ($0.CalculatePayRunResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ApprovePayRunRequest, $0.ApprovePayRunResponse>(
        'ApprovePayRun',
        approvePayRun_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ApprovePayRunRequest.fromBuffer(value),
        ($0.ApprovePayRunResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessPayRunRequest, $0.ProcessPayRunResponse>(
        'ProcessPayRun',
        processPayRun_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProcessPayRunRequest.fromBuffer(value),
        ($0.ProcessPayRunResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPayRunRequest, $0.GetPayRunResponse>(
        'GetPayRun',
        getPayRun_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPayRunRequest.fromBuffer(value),
        ($0.GetPayRunResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListPayRunsRequest, $0.ListPayRunsResponse>(
        'ListPayRuns',
        listPayRuns_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListPayRunsRequest.fromBuffer(value),
        ($0.ListPayRunsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaySlipRequest, $0.GetPaySlipResponse>(
        'GetPaySlip',
        getPaySlip_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPaySlipRequest.fromBuffer(value),
        ($0.GetPaySlipResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListPaySlipsRequest, $0.ListPaySlipsResponse>(
        'ListPaySlips',
        listPaySlips_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListPaySlipsRequest.fromBuffer(value),
        ($0.ListPaySlipsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPayrollSummaryRequest, $0.GetPayrollSummaryResponse>(
        'GetPayrollSummary',
        getPayrollSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPayrollSummaryRequest.fromBuffer(value),
        ($0.GetPayrollSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTaxReportRequest, $0.GetTaxReportResponse>(
        'GetTaxReport',
        getTaxReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaxReportRequest.fromBuffer(value),
        ($0.GetTaxReportResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.AddEmployeeResponse> addEmployee_Pre($grpc.ServiceCall call, $async.Future<$0.AddEmployeeRequest> request) async {
    return addEmployee(call, await request);
  }

  $async.Future<$0.UpdateEmployeeResponse> updateEmployee_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateEmployeeRequest> request) async {
    return updateEmployee(call, await request);
  }

  $async.Future<$0.RemoveEmployeeResponse> removeEmployee_Pre($grpc.ServiceCall call, $async.Future<$0.RemoveEmployeeRequest> request) async {
    return removeEmployee(call, await request);
  }

  $async.Future<$0.GetEmployeeResponse> getEmployee_Pre($grpc.ServiceCall call, $async.Future<$0.GetEmployeeRequest> request) async {
    return getEmployee(call, await request);
  }

  $async.Future<$0.ListEmployeesResponse> listEmployees_Pre($grpc.ServiceCall call, $async.Future<$0.ListEmployeesRequest> request) async {
    return listEmployees(call, await request);
  }

  $async.Future<$0.CreatePayRunResponse> createPayRun_Pre($grpc.ServiceCall call, $async.Future<$0.CreatePayRunRequest> request) async {
    return createPayRun(call, await request);
  }

  $async.Future<$0.CalculatePayRunResponse> calculatePayRun_Pre($grpc.ServiceCall call, $async.Future<$0.CalculatePayRunRequest> request) async {
    return calculatePayRun(call, await request);
  }

  $async.Future<$0.ApprovePayRunResponse> approvePayRun_Pre($grpc.ServiceCall call, $async.Future<$0.ApprovePayRunRequest> request) async {
    return approvePayRun(call, await request);
  }

  $async.Future<$0.ProcessPayRunResponse> processPayRun_Pre($grpc.ServiceCall call, $async.Future<$0.ProcessPayRunRequest> request) async {
    return processPayRun(call, await request);
  }

  $async.Future<$0.GetPayRunResponse> getPayRun_Pre($grpc.ServiceCall call, $async.Future<$0.GetPayRunRequest> request) async {
    return getPayRun(call, await request);
  }

  $async.Future<$0.ListPayRunsResponse> listPayRuns_Pre($grpc.ServiceCall call, $async.Future<$0.ListPayRunsRequest> request) async {
    return listPayRuns(call, await request);
  }

  $async.Future<$0.GetPaySlipResponse> getPaySlip_Pre($grpc.ServiceCall call, $async.Future<$0.GetPaySlipRequest> request) async {
    return getPaySlip(call, await request);
  }

  $async.Future<$0.ListPaySlipsResponse> listPaySlips_Pre($grpc.ServiceCall call, $async.Future<$0.ListPaySlipsRequest> request) async {
    return listPaySlips(call, await request);
  }

  $async.Future<$0.GetPayrollSummaryResponse> getPayrollSummary_Pre($grpc.ServiceCall call, $async.Future<$0.GetPayrollSummaryRequest> request) async {
    return getPayrollSummary(call, await request);
  }

  $async.Future<$0.GetTaxReportResponse> getTaxReport_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaxReportRequest> request) async {
    return getTaxReport(call, await request);
  }

  $async.Future<$0.AddEmployeeResponse> addEmployee($grpc.ServiceCall call, $0.AddEmployeeRequest request);
  $async.Future<$0.UpdateEmployeeResponse> updateEmployee($grpc.ServiceCall call, $0.UpdateEmployeeRequest request);
  $async.Future<$0.RemoveEmployeeResponse> removeEmployee($grpc.ServiceCall call, $0.RemoveEmployeeRequest request);
  $async.Future<$0.GetEmployeeResponse> getEmployee($grpc.ServiceCall call, $0.GetEmployeeRequest request);
  $async.Future<$0.ListEmployeesResponse> listEmployees($grpc.ServiceCall call, $0.ListEmployeesRequest request);
  $async.Future<$0.CreatePayRunResponse> createPayRun($grpc.ServiceCall call, $0.CreatePayRunRequest request);
  $async.Future<$0.CalculatePayRunResponse> calculatePayRun($grpc.ServiceCall call, $0.CalculatePayRunRequest request);
  $async.Future<$0.ApprovePayRunResponse> approvePayRun($grpc.ServiceCall call, $0.ApprovePayRunRequest request);
  $async.Future<$0.ProcessPayRunResponse> processPayRun($grpc.ServiceCall call, $0.ProcessPayRunRequest request);
  $async.Future<$0.GetPayRunResponse> getPayRun($grpc.ServiceCall call, $0.GetPayRunRequest request);
  $async.Future<$0.ListPayRunsResponse> listPayRuns($grpc.ServiceCall call, $0.ListPayRunsRequest request);
  $async.Future<$0.GetPaySlipResponse> getPaySlip($grpc.ServiceCall call, $0.GetPaySlipRequest request);
  $async.Future<$0.ListPaySlipsResponse> listPaySlips($grpc.ServiceCall call, $0.ListPaySlipsRequest request);
  $async.Future<$0.GetPayrollSummaryResponse> getPayrollSummary($grpc.ServiceCall call, $0.GetPayrollSummaryRequest request);
  $async.Future<$0.GetTaxReportResponse> getTaxReport($grpc.ServiceCall call, $0.GetTaxReportRequest request);
}
@$pb.GrpcServiceName('pb.InventoryService')
class InventoryServiceClient extends $grpc.Client {
  static final _$createInventoryItem = $grpc.ClientMethod<$0.CreateInventoryItemRequest, $0.CreateInventoryItemResponse>(
      '/pb.InventoryService/CreateInventoryItem',
      ($0.CreateInventoryItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateInventoryItemResponse.fromBuffer(value));
  static final _$updateInventoryItem = $grpc.ClientMethod<$0.UpdateInventoryItemRequest, $0.UpdateInventoryItemResponse>(
      '/pb.InventoryService/UpdateInventoryItem',
      ($0.UpdateInventoryItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateInventoryItemResponse.fromBuffer(value));
  static final _$deleteInventoryItem = $grpc.ClientMethod<$0.DeleteInventoryItemRequest, $0.DeleteInventoryItemResponse>(
      '/pb.InventoryService/DeleteInventoryItem',
      ($0.DeleteInventoryItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteInventoryItemResponse.fromBuffer(value));
  static final _$getInventoryItem = $grpc.ClientMethod<$0.GetInventoryItemRequest, $0.GetInventoryItemResponse>(
      '/pb.InventoryService/GetInventoryItem',
      ($0.GetInventoryItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInventoryItemResponse.fromBuffer(value));
  static final _$listInventoryItems = $grpc.ClientMethod<$0.ListInventoryItemsRequest, $0.ListInventoryItemsResponse>(
      '/pb.InventoryService/ListInventoryItems',
      ($0.ListInventoryItemsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListInventoryItemsResponse.fromBuffer(value));
  static final _$adjustInventoryQuantity = $grpc.ClientMethod<$0.AdjustInventoryQuantityRequest, $0.AdjustInventoryQuantityResponse>(
      '/pb.InventoryService/AdjustInventoryQuantity',
      ($0.AdjustInventoryQuantityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdjustInventoryQuantityResponse.fromBuffer(value));
  static final _$getInventoryHistory = $grpc.ClientMethod<$0.GetInventoryHistoryRequest, $0.GetInventoryHistoryResponse>(
      '/pb.InventoryService/GetInventoryHistory',
      ($0.GetInventoryHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInventoryHistoryResponse.fromBuffer(value));
  static final _$getInventorySummary = $grpc.ClientMethod<$0.GetInventorySummaryRequest, $0.GetInventorySummaryResponse>(
      '/pb.InventoryService/GetInventorySummary',
      ($0.GetInventorySummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInventorySummaryResponse.fromBuffer(value));

  InventoryServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateInventoryItemResponse> createInventoryItem($0.CreateInventoryItemRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInventoryItem, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInventoryItemResponse> updateInventoryItem($0.UpdateInventoryItemRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInventoryItem, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteInventoryItemResponse> deleteInventoryItem($0.DeleteInventoryItemRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInventoryItem, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInventoryItemResponse> getInventoryItem($0.GetInventoryItemRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInventoryItem, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListInventoryItemsResponse> listInventoryItems($0.ListInventoryItemsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInventoryItems, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdjustInventoryQuantityResponse> adjustInventoryQuantity($0.AdjustInventoryQuantityRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adjustInventoryQuantity, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInventoryHistoryResponse> getInventoryHistory($0.GetInventoryHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInventoryHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInventorySummaryResponse> getInventorySummary($0.GetInventorySummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInventorySummary, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.InventoryService')
abstract class InventoryServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InventoryService';

  InventoryServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateInventoryItemRequest, $0.CreateInventoryItemResponse>(
        'CreateInventoryItem',
        createInventoryItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateInventoryItemRequest.fromBuffer(value),
        ($0.CreateInventoryItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInventoryItemRequest, $0.UpdateInventoryItemResponse>(
        'UpdateInventoryItem',
        updateInventoryItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateInventoryItemRequest.fromBuffer(value),
        ($0.UpdateInventoryItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteInventoryItemRequest, $0.DeleteInventoryItemResponse>(
        'DeleteInventoryItem',
        deleteInventoryItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteInventoryItemRequest.fromBuffer(value),
        ($0.DeleteInventoryItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInventoryItemRequest, $0.GetInventoryItemResponse>(
        'GetInventoryItem',
        getInventoryItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInventoryItemRequest.fromBuffer(value),
        ($0.GetInventoryItemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListInventoryItemsRequest, $0.ListInventoryItemsResponse>(
        'ListInventoryItems',
        listInventoryItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListInventoryItemsRequest.fromBuffer(value),
        ($0.ListInventoryItemsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdjustInventoryQuantityRequest, $0.AdjustInventoryQuantityResponse>(
        'AdjustInventoryQuantity',
        adjustInventoryQuantity_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdjustInventoryQuantityRequest.fromBuffer(value),
        ($0.AdjustInventoryQuantityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInventoryHistoryRequest, $0.GetInventoryHistoryResponse>(
        'GetInventoryHistory',
        getInventoryHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInventoryHistoryRequest.fromBuffer(value),
        ($0.GetInventoryHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInventorySummaryRequest, $0.GetInventorySummaryResponse>(
        'GetInventorySummary',
        getInventorySummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInventorySummaryRequest.fromBuffer(value),
        ($0.GetInventorySummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateInventoryItemResponse> createInventoryItem_Pre($grpc.ServiceCall call, $async.Future<$0.CreateInventoryItemRequest> request) async {
    return createInventoryItem(call, await request);
  }

  $async.Future<$0.UpdateInventoryItemResponse> updateInventoryItem_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateInventoryItemRequest> request) async {
    return updateInventoryItem(call, await request);
  }

  $async.Future<$0.DeleteInventoryItemResponse> deleteInventoryItem_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteInventoryItemRequest> request) async {
    return deleteInventoryItem(call, await request);
  }

  $async.Future<$0.GetInventoryItemResponse> getInventoryItem_Pre($grpc.ServiceCall call, $async.Future<$0.GetInventoryItemRequest> request) async {
    return getInventoryItem(call, await request);
  }

  $async.Future<$0.ListInventoryItemsResponse> listInventoryItems_Pre($grpc.ServiceCall call, $async.Future<$0.ListInventoryItemsRequest> request) async {
    return listInventoryItems(call, await request);
  }

  $async.Future<$0.AdjustInventoryQuantityResponse> adjustInventoryQuantity_Pre($grpc.ServiceCall call, $async.Future<$0.AdjustInventoryQuantityRequest> request) async {
    return adjustInventoryQuantity(call, await request);
  }

  $async.Future<$0.GetInventoryHistoryResponse> getInventoryHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetInventoryHistoryRequest> request) async {
    return getInventoryHistory(call, await request);
  }

  $async.Future<$0.GetInventorySummaryResponse> getInventorySummary_Pre($grpc.ServiceCall call, $async.Future<$0.GetInventorySummaryRequest> request) async {
    return getInventorySummary(call, await request);
  }

  $async.Future<$0.CreateInventoryItemResponse> createInventoryItem($grpc.ServiceCall call, $0.CreateInventoryItemRequest request);
  $async.Future<$0.UpdateInventoryItemResponse> updateInventoryItem($grpc.ServiceCall call, $0.UpdateInventoryItemRequest request);
  $async.Future<$0.DeleteInventoryItemResponse> deleteInventoryItem($grpc.ServiceCall call, $0.DeleteInventoryItemRequest request);
  $async.Future<$0.GetInventoryItemResponse> getInventoryItem($grpc.ServiceCall call, $0.GetInventoryItemRequest request);
  $async.Future<$0.ListInventoryItemsResponse> listInventoryItems($grpc.ServiceCall call, $0.ListInventoryItemsRequest request);
  $async.Future<$0.AdjustInventoryQuantityResponse> adjustInventoryQuantity($grpc.ServiceCall call, $0.AdjustInventoryQuantityRequest request);
  $async.Future<$0.GetInventoryHistoryResponse> getInventoryHistory($grpc.ServiceCall call, $0.GetInventoryHistoryRequest request);
  $async.Future<$0.GetInventorySummaryResponse> getInventorySummary($grpc.ServiceCall call, $0.GetInventorySummaryRequest request);
}
@$pb.GrpcServiceName('pb.CustomerService')
class CustomerServiceClient extends $grpc.Client {
  static final _$createCustomer = $grpc.ClientMethod<$0.CreateCustomerRequest, $0.CreateCustomerResponse>(
      '/pb.CustomerService/CreateCustomer',
      ($0.CreateCustomerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateCustomerResponse.fromBuffer(value));
  static final _$updateCustomer = $grpc.ClientMethod<$0.UpdateCustomerRequest, $0.UpdateCustomerResponse>(
      '/pb.CustomerService/UpdateCustomer',
      ($0.UpdateCustomerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateCustomerResponse.fromBuffer(value));
  static final _$deleteCustomer = $grpc.ClientMethod<$0.DeleteCustomerRequest, $0.DeleteCustomerResponse>(
      '/pb.CustomerService/DeleteCustomer',
      ($0.DeleteCustomerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteCustomerResponse.fromBuffer(value));
  static final _$getCustomer = $grpc.ClientMethod<$0.GetCustomerRequest, $0.GetCustomerResponse>(
      '/pb.CustomerService/GetCustomer',
      ($0.GetCustomerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCustomerResponse.fromBuffer(value));
  static final _$listCustomers = $grpc.ClientMethod<$0.ListCustomersRequest, $0.ListCustomersResponse>(
      '/pb.CustomerService/ListCustomers',
      ($0.ListCustomersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListCustomersResponse.fromBuffer(value));
  static final _$getCustomerFinancialProfile = $grpc.ClientMethod<$0.GetCustomerFinancialProfileRequest, $0.GetCustomerFinancialProfileResponse>(
      '/pb.CustomerService/GetCustomerFinancialProfile',
      ($0.GetCustomerFinancialProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCustomerFinancialProfileResponse.fromBuffer(value));
  static final _$getCustomerSummary = $grpc.ClientMethod<$0.GetCustomerSummaryRequest, $0.GetCustomerSummaryResponse>(
      '/pb.CustomerService/GetCustomerSummary',
      ($0.GetCustomerSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCustomerSummaryResponse.fromBuffer(value));
  static final _$addCustomerNote = $grpc.ClientMethod<$0.AddCustomerNoteRequest, $0.AddCustomerNoteResponse>(
      '/pb.CustomerService/AddCustomerNote',
      ($0.AddCustomerNoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddCustomerNoteResponse.fromBuffer(value));
  static final _$listCustomerNotes = $grpc.ClientMethod<$0.ListCustomerNotesRequest, $0.ListCustomerNotesResponse>(
      '/pb.CustomerService/ListCustomerNotes',
      ($0.ListCustomerNotesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListCustomerNotesResponse.fromBuffer(value));
  static final _$getCustomerStatement = $grpc.ClientMethod<$0.GetCustomerStatementRequest, $0.GetCustomerStatementResponse>(
      '/pb.CustomerService/GetCustomerStatement',
      ($0.GetCustomerStatementRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCustomerStatementResponse.fromBuffer(value));

  CustomerServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateCustomerResponse> createCustomer($0.CreateCustomerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCustomer, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCustomerResponse> updateCustomer($0.UpdateCustomerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCustomer, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCustomerResponse> deleteCustomer($0.DeleteCustomerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCustomer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCustomerResponse> getCustomer($0.GetCustomerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomer, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListCustomersResponse> listCustomers($0.ListCustomersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCustomers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCustomerFinancialProfileResponse> getCustomerFinancialProfile($0.GetCustomerFinancialProfileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomerFinancialProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCustomerSummaryResponse> getCustomerSummary($0.GetCustomerSummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomerSummary, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddCustomerNoteResponse> addCustomerNote($0.AddCustomerNoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addCustomerNote, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListCustomerNotesResponse> listCustomerNotes($0.ListCustomerNotesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCustomerNotes, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCustomerStatementResponse> getCustomerStatement($0.GetCustomerStatementRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCustomerStatement, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.CustomerService')
abstract class CustomerServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CustomerService';

  CustomerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateCustomerRequest, $0.CreateCustomerResponse>(
        'CreateCustomer',
        createCustomer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateCustomerRequest.fromBuffer(value),
        ($0.CreateCustomerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCustomerRequest, $0.UpdateCustomerResponse>(
        'UpdateCustomer',
        updateCustomer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateCustomerRequest.fromBuffer(value),
        ($0.UpdateCustomerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCustomerRequest, $0.DeleteCustomerResponse>(
        'DeleteCustomer',
        deleteCustomer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteCustomerRequest.fromBuffer(value),
        ($0.DeleteCustomerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCustomerRequest, $0.GetCustomerResponse>(
        'GetCustomer',
        getCustomer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCustomerRequest.fromBuffer(value),
        ($0.GetCustomerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCustomersRequest, $0.ListCustomersResponse>(
        'ListCustomers',
        listCustomers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListCustomersRequest.fromBuffer(value),
        ($0.ListCustomersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCustomerFinancialProfileRequest, $0.GetCustomerFinancialProfileResponse>(
        'GetCustomerFinancialProfile',
        getCustomerFinancialProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCustomerFinancialProfileRequest.fromBuffer(value),
        ($0.GetCustomerFinancialProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCustomerSummaryRequest, $0.GetCustomerSummaryResponse>(
        'GetCustomerSummary',
        getCustomerSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCustomerSummaryRequest.fromBuffer(value),
        ($0.GetCustomerSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddCustomerNoteRequest, $0.AddCustomerNoteResponse>(
        'AddCustomerNote',
        addCustomerNote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddCustomerNoteRequest.fromBuffer(value),
        ($0.AddCustomerNoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCustomerNotesRequest, $0.ListCustomerNotesResponse>(
        'ListCustomerNotes',
        listCustomerNotes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListCustomerNotesRequest.fromBuffer(value),
        ($0.ListCustomerNotesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCustomerStatementRequest, $0.GetCustomerStatementResponse>(
        'GetCustomerStatement',
        getCustomerStatement_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCustomerStatementRequest.fromBuffer(value),
        ($0.GetCustomerStatementResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateCustomerResponse> createCustomer_Pre($grpc.ServiceCall call, $async.Future<$0.CreateCustomerRequest> request) async {
    return createCustomer(call, await request);
  }

  $async.Future<$0.UpdateCustomerResponse> updateCustomer_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateCustomerRequest> request) async {
    return updateCustomer(call, await request);
  }

  $async.Future<$0.DeleteCustomerResponse> deleteCustomer_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteCustomerRequest> request) async {
    return deleteCustomer(call, await request);
  }

  $async.Future<$0.GetCustomerResponse> getCustomer_Pre($grpc.ServiceCall call, $async.Future<$0.GetCustomerRequest> request) async {
    return getCustomer(call, await request);
  }

  $async.Future<$0.ListCustomersResponse> listCustomers_Pre($grpc.ServiceCall call, $async.Future<$0.ListCustomersRequest> request) async {
    return listCustomers(call, await request);
  }

  $async.Future<$0.GetCustomerFinancialProfileResponse> getCustomerFinancialProfile_Pre($grpc.ServiceCall call, $async.Future<$0.GetCustomerFinancialProfileRequest> request) async {
    return getCustomerFinancialProfile(call, await request);
  }

  $async.Future<$0.GetCustomerSummaryResponse> getCustomerSummary_Pre($grpc.ServiceCall call, $async.Future<$0.GetCustomerSummaryRequest> request) async {
    return getCustomerSummary(call, await request);
  }

  $async.Future<$0.AddCustomerNoteResponse> addCustomerNote_Pre($grpc.ServiceCall call, $async.Future<$0.AddCustomerNoteRequest> request) async {
    return addCustomerNote(call, await request);
  }

  $async.Future<$0.ListCustomerNotesResponse> listCustomerNotes_Pre($grpc.ServiceCall call, $async.Future<$0.ListCustomerNotesRequest> request) async {
    return listCustomerNotes(call, await request);
  }

  $async.Future<$0.GetCustomerStatementResponse> getCustomerStatement_Pre($grpc.ServiceCall call, $async.Future<$0.GetCustomerStatementRequest> request) async {
    return getCustomerStatement(call, await request);
  }

  $async.Future<$0.CreateCustomerResponse> createCustomer($grpc.ServiceCall call, $0.CreateCustomerRequest request);
  $async.Future<$0.UpdateCustomerResponse> updateCustomer($grpc.ServiceCall call, $0.UpdateCustomerRequest request);
  $async.Future<$0.DeleteCustomerResponse> deleteCustomer($grpc.ServiceCall call, $0.DeleteCustomerRequest request);
  $async.Future<$0.GetCustomerResponse> getCustomer($grpc.ServiceCall call, $0.GetCustomerRequest request);
  $async.Future<$0.ListCustomersResponse> listCustomers($grpc.ServiceCall call, $0.ListCustomersRequest request);
  $async.Future<$0.GetCustomerFinancialProfileResponse> getCustomerFinancialProfile($grpc.ServiceCall call, $0.GetCustomerFinancialProfileRequest request);
  $async.Future<$0.GetCustomerSummaryResponse> getCustomerSummary($grpc.ServiceCall call, $0.GetCustomerSummaryRequest request);
  $async.Future<$0.AddCustomerNoteResponse> addCustomerNote($grpc.ServiceCall call, $0.AddCustomerNoteRequest request);
  $async.Future<$0.ListCustomerNotesResponse> listCustomerNotes($grpc.ServiceCall call, $0.ListCustomerNotesRequest request);
  $async.Future<$0.GetCustomerStatementResponse> getCustomerStatement($grpc.ServiceCall call, $0.GetCustomerStatementRequest request);
}
@$pb.GrpcServiceName('pb.TaxService')
class TaxServiceClient extends $grpc.Client {
  static final _$getTaxDashboard = $grpc.ClientMethod<$0.GetTaxDashboardRequest, $0.GetTaxDashboardResponse>(
      '/pb.TaxService/GetTaxDashboard',
      ($0.GetTaxDashboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaxDashboardResponse.fromBuffer(value));
  static final _$getTaxCalendar = $grpc.ClientMethod<$0.GetTaxCalendarRequest, $0.GetTaxCalendarResponse>(
      '/pb.TaxService/GetTaxCalendar',
      ($0.GetTaxCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaxCalendarResponse.fromBuffer(value));
  static final _$createTaxObligation = $grpc.ClientMethod<$0.CreateTaxObligationRequest, $0.CreateTaxObligationResponse>(
      '/pb.TaxService/CreateTaxObligation',
      ($0.CreateTaxObligationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateTaxObligationResponse.fromBuffer(value));
  static final _$updateTaxObligation = $grpc.ClientMethod<$0.UpdateTaxObligationRequest, $0.UpdateTaxObligationResponse>(
      '/pb.TaxService/UpdateTaxObligation',
      ($0.UpdateTaxObligationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateTaxObligationResponse.fromBuffer(value));
  static final _$listTaxObligations = $grpc.ClientMethod<$0.ListTaxObligationsRequest, $0.ListTaxObligationsResponse>(
      '/pb.TaxService/ListTaxObligations',
      ($0.ListTaxObligationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListTaxObligationsResponse.fromBuffer(value));
  static final _$uploadTaxDocument = $grpc.ClientMethod<$0.UploadTaxDocumentRequest, $0.UploadTaxDocumentResponse>(
      '/pb.TaxService/UploadTaxDocument',
      ($0.UploadTaxDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UploadTaxDocumentResponse.fromBuffer(value));
  static final _$listTaxDocuments = $grpc.ClientMethod<$0.ListTaxDocumentsRequest, $0.ListTaxDocumentsResponse>(
      '/pb.TaxService/ListTaxDocuments',
      ($0.ListTaxDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListTaxDocumentsResponse.fromBuffer(value));
  static final _$deleteTaxDocument = $grpc.ClientMethod<$0.DeleteTaxDocumentRequest, $0.DeleteTaxDocumentResponse>(
      '/pb.TaxService/DeleteTaxDocument',
      ($0.DeleteTaxDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteTaxDocumentResponse.fromBuffer(value));
  static final _$getVATSchedule = $grpc.ClientMethod<$0.GetVATScheduleRequest, $0.GetVATScheduleResponse>(
      '/pb.TaxService/GetVATSchedule',
      ($0.GetVATScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetVATScheduleResponse.fromBuffer(value));
  static final _$recordVATTransaction = $grpc.ClientMethod<$0.RecordVATTransactionRequest, $0.RecordVATTransactionResponse>(
      '/pb.TaxService/RecordVATTransaction',
      ($0.RecordVATTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RecordVATTransactionResponse.fromBuffer(value));
  static final _$getWHTSchedule = $grpc.ClientMethod<$0.GetWHTScheduleRequest, $0.GetWHTScheduleResponse>(
      '/pb.TaxService/GetWHTSchedule',
      ($0.GetWHTScheduleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetWHTScheduleResponse.fromBuffer(value));
  static final _$recordWHTDeduction = $grpc.ClientMethod<$0.RecordWHTDeductionRequest, $0.RecordWHTDeductionResponse>(
      '/pb.TaxService/RecordWHTDeduction',
      ($0.RecordWHTDeductionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RecordWHTDeductionResponse.fromBuffer(value));
  static final _$getPAYESummary = $grpc.ClientMethod<$0.GetPAYESummaryRequest, $0.GetPAYESummaryResponse>(
      '/pb.TaxService/GetPAYESummary',
      ($0.GetPAYESummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPAYESummaryResponse.fromBuffer(value));
  static final _$getCITEstimation = $grpc.ClientMethod<$0.GetCITEstimationRequest, $0.GetCITEstimationResponse>(
      '/pb.TaxService/GetCITEstimation',
      ($0.GetCITEstimationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCITEstimationResponse.fromBuffer(value));

  TaxServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetTaxDashboardResponse> getTaxDashboard($0.GetTaxDashboardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaxDashboard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTaxCalendarResponse> getTaxCalendar($0.GetTaxCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaxCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateTaxObligationResponse> createTaxObligation($0.CreateTaxObligationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTaxObligation, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateTaxObligationResponse> updateTaxObligation($0.UpdateTaxObligationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaxObligation, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListTaxObligationsResponse> listTaxObligations($0.ListTaxObligationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTaxObligations, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadTaxDocumentResponse> uploadTaxDocument($0.UploadTaxDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadTaxDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListTaxDocumentsResponse> listTaxDocuments($0.ListTaxDocumentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTaxDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteTaxDocumentResponse> deleteTaxDocument($0.DeleteTaxDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaxDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetVATScheduleResponse> getVATSchedule($0.GetVATScheduleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVATSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecordVATTransactionResponse> recordVATTransaction($0.RecordVATTransactionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordVATTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWHTScheduleResponse> getWHTSchedule($0.GetWHTScheduleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWHTSchedule, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecordWHTDeductionResponse> recordWHTDeduction($0.RecordWHTDeductionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordWHTDeduction, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPAYESummaryResponse> getPAYESummary($0.GetPAYESummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPAYESummary, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCITEstimationResponse> getCITEstimation($0.GetCITEstimationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCITEstimation, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TaxService')
abstract class TaxServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaxService';

  TaxServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetTaxDashboardRequest, $0.GetTaxDashboardResponse>(
        'GetTaxDashboard',
        getTaxDashboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaxDashboardRequest.fromBuffer(value),
        ($0.GetTaxDashboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTaxCalendarRequest, $0.GetTaxCalendarResponse>(
        'GetTaxCalendar',
        getTaxCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaxCalendarRequest.fromBuffer(value),
        ($0.GetTaxCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateTaxObligationRequest, $0.CreateTaxObligationResponse>(
        'CreateTaxObligation',
        createTaxObligation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateTaxObligationRequest.fromBuffer(value),
        ($0.CreateTaxObligationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTaxObligationRequest, $0.UpdateTaxObligationResponse>(
        'UpdateTaxObligation',
        updateTaxObligation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateTaxObligationRequest.fromBuffer(value),
        ($0.UpdateTaxObligationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListTaxObligationsRequest, $0.ListTaxObligationsResponse>(
        'ListTaxObligations',
        listTaxObligations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListTaxObligationsRequest.fromBuffer(value),
        ($0.ListTaxObligationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadTaxDocumentRequest, $0.UploadTaxDocumentResponse>(
        'UploadTaxDocument',
        uploadTaxDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadTaxDocumentRequest.fromBuffer(value),
        ($0.UploadTaxDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListTaxDocumentsRequest, $0.ListTaxDocumentsResponse>(
        'ListTaxDocuments',
        listTaxDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListTaxDocumentsRequest.fromBuffer(value),
        ($0.ListTaxDocumentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteTaxDocumentRequest, $0.DeleteTaxDocumentResponse>(
        'DeleteTaxDocument',
        deleteTaxDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteTaxDocumentRequest.fromBuffer(value),
        ($0.DeleteTaxDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVATScheduleRequest, $0.GetVATScheduleResponse>(
        'GetVATSchedule',
        getVATSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetVATScheduleRequest.fromBuffer(value),
        ($0.GetVATScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecordVATTransactionRequest, $0.RecordVATTransactionResponse>(
        'RecordVATTransaction',
        recordVATTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RecordVATTransactionRequest.fromBuffer(value),
        ($0.RecordVATTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWHTScheduleRequest, $0.GetWHTScheduleResponse>(
        'GetWHTSchedule',
        getWHTSchedule_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetWHTScheduleRequest.fromBuffer(value),
        ($0.GetWHTScheduleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecordWHTDeductionRequest, $0.RecordWHTDeductionResponse>(
        'RecordWHTDeduction',
        recordWHTDeduction_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RecordWHTDeductionRequest.fromBuffer(value),
        ($0.RecordWHTDeductionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPAYESummaryRequest, $0.GetPAYESummaryResponse>(
        'GetPAYESummary',
        getPAYESummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPAYESummaryRequest.fromBuffer(value),
        ($0.GetPAYESummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCITEstimationRequest, $0.GetCITEstimationResponse>(
        'GetCITEstimation',
        getCITEstimation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCITEstimationRequest.fromBuffer(value),
        ($0.GetCITEstimationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetTaxDashboardResponse> getTaxDashboard_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaxDashboardRequest> request) async {
    return getTaxDashboard(call, await request);
  }

  $async.Future<$0.GetTaxCalendarResponse> getTaxCalendar_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaxCalendarRequest> request) async {
    return getTaxCalendar(call, await request);
  }

  $async.Future<$0.CreateTaxObligationResponse> createTaxObligation_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTaxObligationRequest> request) async {
    return createTaxObligation(call, await request);
  }

  $async.Future<$0.UpdateTaxObligationResponse> updateTaxObligation_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateTaxObligationRequest> request) async {
    return updateTaxObligation(call, await request);
  }

  $async.Future<$0.ListTaxObligationsResponse> listTaxObligations_Pre($grpc.ServiceCall call, $async.Future<$0.ListTaxObligationsRequest> request) async {
    return listTaxObligations(call, await request);
  }

  $async.Future<$0.UploadTaxDocumentResponse> uploadTaxDocument_Pre($grpc.ServiceCall call, $async.Future<$0.UploadTaxDocumentRequest> request) async {
    return uploadTaxDocument(call, await request);
  }

  $async.Future<$0.ListTaxDocumentsResponse> listTaxDocuments_Pre($grpc.ServiceCall call, $async.Future<$0.ListTaxDocumentsRequest> request) async {
    return listTaxDocuments(call, await request);
  }

  $async.Future<$0.DeleteTaxDocumentResponse> deleteTaxDocument_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteTaxDocumentRequest> request) async {
    return deleteTaxDocument(call, await request);
  }

  $async.Future<$0.GetVATScheduleResponse> getVATSchedule_Pre($grpc.ServiceCall call, $async.Future<$0.GetVATScheduleRequest> request) async {
    return getVATSchedule(call, await request);
  }

  $async.Future<$0.RecordVATTransactionResponse> recordVATTransaction_Pre($grpc.ServiceCall call, $async.Future<$0.RecordVATTransactionRequest> request) async {
    return recordVATTransaction(call, await request);
  }

  $async.Future<$0.GetWHTScheduleResponse> getWHTSchedule_Pre($grpc.ServiceCall call, $async.Future<$0.GetWHTScheduleRequest> request) async {
    return getWHTSchedule(call, await request);
  }

  $async.Future<$0.RecordWHTDeductionResponse> recordWHTDeduction_Pre($grpc.ServiceCall call, $async.Future<$0.RecordWHTDeductionRequest> request) async {
    return recordWHTDeduction(call, await request);
  }

  $async.Future<$0.GetPAYESummaryResponse> getPAYESummary_Pre($grpc.ServiceCall call, $async.Future<$0.GetPAYESummaryRequest> request) async {
    return getPAYESummary(call, await request);
  }

  $async.Future<$0.GetCITEstimationResponse> getCITEstimation_Pre($grpc.ServiceCall call, $async.Future<$0.GetCITEstimationRequest> request) async {
    return getCITEstimation(call, await request);
  }

  $async.Future<$0.GetTaxDashboardResponse> getTaxDashboard($grpc.ServiceCall call, $0.GetTaxDashboardRequest request);
  $async.Future<$0.GetTaxCalendarResponse> getTaxCalendar($grpc.ServiceCall call, $0.GetTaxCalendarRequest request);
  $async.Future<$0.CreateTaxObligationResponse> createTaxObligation($grpc.ServiceCall call, $0.CreateTaxObligationRequest request);
  $async.Future<$0.UpdateTaxObligationResponse> updateTaxObligation($grpc.ServiceCall call, $0.UpdateTaxObligationRequest request);
  $async.Future<$0.ListTaxObligationsResponse> listTaxObligations($grpc.ServiceCall call, $0.ListTaxObligationsRequest request);
  $async.Future<$0.UploadTaxDocumentResponse> uploadTaxDocument($grpc.ServiceCall call, $0.UploadTaxDocumentRequest request);
  $async.Future<$0.ListTaxDocumentsResponse> listTaxDocuments($grpc.ServiceCall call, $0.ListTaxDocumentsRequest request);
  $async.Future<$0.DeleteTaxDocumentResponse> deleteTaxDocument($grpc.ServiceCall call, $0.DeleteTaxDocumentRequest request);
  $async.Future<$0.GetVATScheduleResponse> getVATSchedule($grpc.ServiceCall call, $0.GetVATScheduleRequest request);
  $async.Future<$0.RecordVATTransactionResponse> recordVATTransaction($grpc.ServiceCall call, $0.RecordVATTransactionRequest request);
  $async.Future<$0.GetWHTScheduleResponse> getWHTSchedule($grpc.ServiceCall call, $0.GetWHTScheduleRequest request);
  $async.Future<$0.RecordWHTDeductionResponse> recordWHTDeduction($grpc.ServiceCall call, $0.RecordWHTDeductionRequest request);
  $async.Future<$0.GetPAYESummaryResponse> getPAYESummary($grpc.ServiceCall call, $0.GetPAYESummaryRequest request);
  $async.Future<$0.GetCITEstimationResponse> getCITEstimation($grpc.ServiceCall call, $0.GetCITEstimationRequest request);
}
@$pb.GrpcServiceName('pb.InventoryEnhancedService')
class InventoryEnhancedServiceClient extends $grpc.Client {
  static final _$createSupplier = $grpc.ClientMethod<$0.CreateSupplierRequest, $0.CreateSupplierResponse>(
      '/pb.InventoryEnhancedService/CreateSupplier',
      ($0.CreateSupplierRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateSupplierResponse.fromBuffer(value));
  static final _$updateSupplier = $grpc.ClientMethod<$0.UpdateSupplierRequest, $0.UpdateSupplierResponse>(
      '/pb.InventoryEnhancedService/UpdateSupplier',
      ($0.UpdateSupplierRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateSupplierResponse.fromBuffer(value));
  static final _$deleteSupplier = $grpc.ClientMethod<$0.DeleteSupplierRequest, $0.DeleteSupplierResponse>(
      '/pb.InventoryEnhancedService/DeleteSupplier',
      ($0.DeleteSupplierRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteSupplierResponse.fromBuffer(value));
  static final _$listSuppliers = $grpc.ClientMethod<$0.ListSuppliersRequest, $0.ListSuppliersResponse>(
      '/pb.InventoryEnhancedService/ListSuppliers',
      ($0.ListSuppliersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListSuppliersResponse.fromBuffer(value));
  static final _$createPurchaseOrder = $grpc.ClientMethod<$0.CreatePurchaseOrderRequest, $0.CreatePurchaseOrderResponse>(
      '/pb.InventoryEnhancedService/CreatePurchaseOrder',
      ($0.CreatePurchaseOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreatePurchaseOrderResponse.fromBuffer(value));
  static final _$getPurchaseOrder = $grpc.ClientMethod<$0.GetPurchaseOrderRequest, $0.GetPurchaseOrderResponse>(
      '/pb.InventoryEnhancedService/GetPurchaseOrder',
      ($0.GetPurchaseOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPurchaseOrderResponse.fromBuffer(value));
  static final _$listPurchaseOrders = $grpc.ClientMethod<$0.ListPurchaseOrdersRequest, $0.ListPurchaseOrdersResponse>(
      '/pb.InventoryEnhancedService/ListPurchaseOrders',
      ($0.ListPurchaseOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListPurchaseOrdersResponse.fromBuffer(value));
  static final _$receivePurchaseOrder = $grpc.ClientMethod<$0.ReceivePurchaseOrderRequest, $0.ReceivePurchaseOrderResponse>(
      '/pb.InventoryEnhancedService/ReceivePurchaseOrder',
      ($0.ReceivePurchaseOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ReceivePurchaseOrderResponse.fromBuffer(value));
  static final _$getInventoryValuation = $grpc.ClientMethod<$0.GetInventoryValuationRequest, $0.GetInventoryValuationResponse>(
      '/pb.InventoryEnhancedService/GetInventoryValuation',
      ($0.GetInventoryValuationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInventoryValuationResponse.fromBuffer(value));
  static final _$getExpiryAlerts = $grpc.ClientMethod<$0.GetExpiryAlertsRequest, $0.GetExpiryAlertsResponse>(
      '/pb.InventoryEnhancedService/GetExpiryAlerts',
      ($0.GetExpiryAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetExpiryAlertsResponse.fromBuffer(value));

  InventoryEnhancedServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateSupplierResponse> createSupplier($0.CreateSupplierRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupplier, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSupplierResponse> updateSupplier($0.UpdateSupplierRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSupplier, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteSupplierResponse> deleteSupplier($0.DeleteSupplierRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSupplier, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListSuppliersResponse> listSuppliers($0.ListSuppliersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSuppliers, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreatePurchaseOrderResponse> createPurchaseOrder($0.CreatePurchaseOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPurchaseOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPurchaseOrderResponse> getPurchaseOrder($0.GetPurchaseOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPurchaseOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPurchaseOrdersResponse> listPurchaseOrders($0.ListPurchaseOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPurchaseOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReceivePurchaseOrderResponse> receivePurchaseOrder($0.ReceivePurchaseOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$receivePurchaseOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInventoryValuationResponse> getInventoryValuation($0.GetInventoryValuationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInventoryValuation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExpiryAlertsResponse> getExpiryAlerts($0.GetExpiryAlertsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpiryAlerts, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.InventoryEnhancedService')
abstract class InventoryEnhancedServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InventoryEnhancedService';

  InventoryEnhancedServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateSupplierRequest, $0.CreateSupplierResponse>(
        'CreateSupplier',
        createSupplier_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateSupplierRequest.fromBuffer(value),
        ($0.CreateSupplierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSupplierRequest, $0.UpdateSupplierResponse>(
        'UpdateSupplier',
        updateSupplier_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateSupplierRequest.fromBuffer(value),
        ($0.UpdateSupplierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteSupplierRequest, $0.DeleteSupplierResponse>(
        'DeleteSupplier',
        deleteSupplier_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteSupplierRequest.fromBuffer(value),
        ($0.DeleteSupplierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSuppliersRequest, $0.ListSuppliersResponse>(
        'ListSuppliers',
        listSuppliers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListSuppliersRequest.fromBuffer(value),
        ($0.ListSuppliersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreatePurchaseOrderRequest, $0.CreatePurchaseOrderResponse>(
        'CreatePurchaseOrder',
        createPurchaseOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreatePurchaseOrderRequest.fromBuffer(value),
        ($0.CreatePurchaseOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPurchaseOrderRequest, $0.GetPurchaseOrderResponse>(
        'GetPurchaseOrder',
        getPurchaseOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPurchaseOrderRequest.fromBuffer(value),
        ($0.GetPurchaseOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListPurchaseOrdersRequest, $0.ListPurchaseOrdersResponse>(
        'ListPurchaseOrders',
        listPurchaseOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListPurchaseOrdersRequest.fromBuffer(value),
        ($0.ListPurchaseOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReceivePurchaseOrderRequest, $0.ReceivePurchaseOrderResponse>(
        'ReceivePurchaseOrder',
        receivePurchaseOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReceivePurchaseOrderRequest.fromBuffer(value),
        ($0.ReceivePurchaseOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInventoryValuationRequest, $0.GetInventoryValuationResponse>(
        'GetInventoryValuation',
        getInventoryValuation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInventoryValuationRequest.fromBuffer(value),
        ($0.GetInventoryValuationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExpiryAlertsRequest, $0.GetExpiryAlertsResponse>(
        'GetExpiryAlerts',
        getExpiryAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetExpiryAlertsRequest.fromBuffer(value),
        ($0.GetExpiryAlertsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateSupplierResponse> createSupplier_Pre($grpc.ServiceCall call, $async.Future<$0.CreateSupplierRequest> request) async {
    return createSupplier(call, await request);
  }

  $async.Future<$0.UpdateSupplierResponse> updateSupplier_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateSupplierRequest> request) async {
    return updateSupplier(call, await request);
  }

  $async.Future<$0.DeleteSupplierResponse> deleteSupplier_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteSupplierRequest> request) async {
    return deleteSupplier(call, await request);
  }

  $async.Future<$0.ListSuppliersResponse> listSuppliers_Pre($grpc.ServiceCall call, $async.Future<$0.ListSuppliersRequest> request) async {
    return listSuppliers(call, await request);
  }

  $async.Future<$0.CreatePurchaseOrderResponse> createPurchaseOrder_Pre($grpc.ServiceCall call, $async.Future<$0.CreatePurchaseOrderRequest> request) async {
    return createPurchaseOrder(call, await request);
  }

  $async.Future<$0.GetPurchaseOrderResponse> getPurchaseOrder_Pre($grpc.ServiceCall call, $async.Future<$0.GetPurchaseOrderRequest> request) async {
    return getPurchaseOrder(call, await request);
  }

  $async.Future<$0.ListPurchaseOrdersResponse> listPurchaseOrders_Pre($grpc.ServiceCall call, $async.Future<$0.ListPurchaseOrdersRequest> request) async {
    return listPurchaseOrders(call, await request);
  }

  $async.Future<$0.ReceivePurchaseOrderResponse> receivePurchaseOrder_Pre($grpc.ServiceCall call, $async.Future<$0.ReceivePurchaseOrderRequest> request) async {
    return receivePurchaseOrder(call, await request);
  }

  $async.Future<$0.GetInventoryValuationResponse> getInventoryValuation_Pre($grpc.ServiceCall call, $async.Future<$0.GetInventoryValuationRequest> request) async {
    return getInventoryValuation(call, await request);
  }

  $async.Future<$0.GetExpiryAlertsResponse> getExpiryAlerts_Pre($grpc.ServiceCall call, $async.Future<$0.GetExpiryAlertsRequest> request) async {
    return getExpiryAlerts(call, await request);
  }

  $async.Future<$0.CreateSupplierResponse> createSupplier($grpc.ServiceCall call, $0.CreateSupplierRequest request);
  $async.Future<$0.UpdateSupplierResponse> updateSupplier($grpc.ServiceCall call, $0.UpdateSupplierRequest request);
  $async.Future<$0.DeleteSupplierResponse> deleteSupplier($grpc.ServiceCall call, $0.DeleteSupplierRequest request);
  $async.Future<$0.ListSuppliersResponse> listSuppliers($grpc.ServiceCall call, $0.ListSuppliersRequest request);
  $async.Future<$0.CreatePurchaseOrderResponse> createPurchaseOrder($grpc.ServiceCall call, $0.CreatePurchaseOrderRequest request);
  $async.Future<$0.GetPurchaseOrderResponse> getPurchaseOrder($grpc.ServiceCall call, $0.GetPurchaseOrderRequest request);
  $async.Future<$0.ListPurchaseOrdersResponse> listPurchaseOrders($grpc.ServiceCall call, $0.ListPurchaseOrdersRequest request);
  $async.Future<$0.ReceivePurchaseOrderResponse> receivePurchaseOrder($grpc.ServiceCall call, $0.ReceivePurchaseOrderRequest request);
  $async.Future<$0.GetInventoryValuationResponse> getInventoryValuation($grpc.ServiceCall call, $0.GetInventoryValuationRequest request);
  $async.Future<$0.GetExpiryAlertsResponse> getExpiryAlerts($grpc.ServiceCall call, $0.GetExpiryAlertsRequest request);
}
