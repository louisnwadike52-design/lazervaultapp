//
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use generateUserTxDataFileRequestDescriptor instead')
const GenerateUserTxDataFileRequest$json = {
  '1': 'GenerateUserTxDataFileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GenerateUserTxDataFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateUserTxDataFileRequestDescriptor = $convert.base64Decode(
    'Ch1HZW5lcmF0ZVVzZXJUeERhdGFGaWxlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySW'
    'Q=');

@$core.Deprecated('Use generateUserTxDataFileResponseDescriptor instead')
const GenerateUserTxDataFileResponse$json = {
  '1': 'GenerateUserTxDataFileResponse',
  '2': [
    {'1': 'file_gcs_url', '3': 1, '4': 1, '5': 9, '10': 'fileGcsUrl'},
  ],
};

/// Descriptor for `GenerateUserTxDataFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateUserTxDataFileResponseDescriptor = $convert.base64Decode(
    'Ch5HZW5lcmF0ZVVzZXJUeERhdGFGaWxlUmVzcG9uc2USIAoMZmlsZV9nY3NfdXJsGAEgASgJUg'
    'pmaWxlR2NzVXJs');

