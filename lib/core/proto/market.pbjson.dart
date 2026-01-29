// This is a generated file - do not edit.
//
// Generated from market.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = {
  '1': 'MessageType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'SNAPSHOT', '2': 1},
    {'1': 'TICK', '2': 2},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlVHlwZRILCgdVTktOT1dOEAASDAoIU05BUFNIT1QQARIICgRUSUNLEAI=');

@$core.Deprecated('Use marketMessageDescriptor instead')
const MarketMessage$json = {
  '1': 'MarketMessage',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.market.MessageType',
      '10': 'type'
    },
    {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
  ],
};

/// Descriptor for `MarketMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketMessageDescriptor = $convert.base64Decode(
    'Cg1NYXJrZXRNZXNzYWdlEicKBHR5cGUYASABKA4yEy5tYXJrZXQuTWVzc2FnZVR5cGVSBHR5cG'
    'USGAoHcGF5bG9hZBgCIAEoDFIHcGF5bG9hZA==');

@$core.Deprecated('Use snapshotDescriptor instead')
const Snapshot$json = {
  '1': 'Snapshot',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'preClose', '3': 2, '4': 1, '5': 1, '10': 'preClose'},
  ],
};

/// Descriptor for `Snapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List snapshotDescriptor = $convert.base64Decode(
    'CghTbmFwc2hvdBISCgRjb2RlGAEgASgJUgRjb2RlEhoKCHByZUNsb3NlGAIgASgBUghwcmVDbG'
    '9zZQ==');

@$core.Deprecated('Use tickDescriptor instead')
const Tick$json = {
  '1': 'Tick',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'price', '3': 2, '4': 1, '5': 1, '10': 'price'},
    {'1': 'ts', '3': 3, '4': 1, '5': 3, '10': 'ts'},
  ],
};

/// Descriptor for `Tick`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tickDescriptor = $convert.base64Decode(
    'CgRUaWNrEhIKBGNvZGUYASABKAlSBGNvZGUSFAoFcHJpY2UYAiABKAFSBXByaWNlEg4KAnRzGA'
    'MgASgDUgJ0cw==');
