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
