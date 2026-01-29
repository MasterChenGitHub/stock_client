import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/isolate_worker.dart';
import '../core/probuf_decoder.dart';
import '../core/proto/market.pb.dart' as MarketProto;
import '../core/socket_client.dart';
import '../core/proto/market.pb.dart';
import '../models/StockModel.dart';

class MarketProvider extends ChangeNotifier {
  final Map<String, StockModel> stocks = {};
  late final SocketClient _client;

  late final TickIsolate _worker;

  MarketProvider() {

    _client = SocketClient(
      host: "192.168.194.64",
      port: 8888,
      onData: _onData,
    );

    // 延迟连接
    Future.delayed(Duration(seconds: 1), () {
      _client.connect();
      _client.initNetworkListener();
    });

    _worker = TickIsolate();
    _worker.start();
  }

  /// 订阅多股票
  void subscribe(List<String> codes) {
    _client.subscribe(codes);
  }

  final _decoder = ProtobufFrameDecoder();

  void _onData(Uint8List data) async {
    final messages = _decoder.feed(data);
    if (messages.isEmpty) return;

    final result = await _worker.process(messages);

    result.forEach((code, incoming) {
      final existing = stocks.putIfAbsent(
        code,
            () => StockModel(code: code),
      );

      // 只在有值时才更新
      if (incoming.preClose > 0) {
        existing.preClose = incoming.preClose;
      }

      if (incoming.lastPrice > 0) {
        existing.lastPrice = incoming.lastPrice;
      }
    });

    notifyListeners();
  }
  /// TCP 长度前缀解码成 protobuf 消息
  List<MarketProto.MarketMessage> _decodeMessages(Uint8List data) {
    final messages = <MarketProto.MarketMessage>[];
    int offset = 0;
    print("decoded messages: ${messages.map((e) => e.type).toList()}");
    while (offset + 4 <= data.length) {
      final len = _readInt32(data.sublist(offset, offset + 4));
      if (offset + 4 + len > data.length) break;

      final msgBytes = data.sublist(offset + 4, offset + 4 + len);
      try {
        final msg = MarketProto.MarketMessage.fromBuffer(msgBytes);
        messages.add(msg);
      } catch (_) {}
      offset += 4 + len;
    }

    return messages;
  }

  /// 读取 4 字节 int32（大端）
  int _readInt32(Uint8List bytes) {
    return (bytes[0] << 24) |
    (bytes[1] << 16) |
    (bytes[2] << 8) |
    bytes[3];
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}
