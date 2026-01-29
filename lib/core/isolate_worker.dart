import 'dart:async';
import 'dart:isolate';

import 'package:stock_client/core/proto/market.pb.dart' as MarketProto;

import '../models/StockModel.dart';

class TickIsolate {
  late Isolate _isolate;
  late SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();

  final _ready = Completer<void>();

  Future<void> start() async {
    _isolate = await Isolate.spawn(_entry, _receivePort.sendPort);

    _sendPort = await _receivePort.first as SendPort;
    _ready.complete();
  }

  Future<Map<String, StockModel>> process(
      List<MarketProto.MarketMessage> messages) async {
    await _ready.future;

    final rp = ReceivePort();
    _sendPort.send([messages, rp.sendPort]);
    return await rp.first as Map<String, StockModel>;
  }

  static void _entry(SendPort mainPort) {
    final port = ReceivePort();
    mainPort.send(port.sendPort);

    port.listen((msg) {
      final List<MarketProto.MarketMessage> messages = msg[0];
      final SendPort reply = msg[1];

      final result = <String, StockModel>{};

      for (final m in messages) {
        switch (m.type) {
          case MarketProto.MessageType.SNAPSHOT:
            final s = MarketProto.Snapshot.fromBuffer(m.payload);
            result.putIfAbsent(s.code, () => StockModel(code: s.code))
              ..preClose = s.preClose;
            break;

          case MarketProto.MessageType.TICK:
            final t = MarketProto.Tick.fromBuffer(m.payload);
            result.putIfAbsent(t.code, () => StockModel(code: t.code))
              ..lastPrice = t.price;
            break;

          default:
            break;
        }
      }

      reply.send(result);
    });
  }
}
