import 'dart:typed_data';
import 'proto/market.pb.dart' as MarketProto;

class ProtobufFrameDecoder {
  final BytesBuilder _buffer = BytesBuilder();

  List<MarketProto.MarketMessage> feed(Uint8List data) {
    _buffer.add(data);
    final bytes = _buffer.toBytes();

    final messages = <MarketProto.MarketMessage>[];
    int offset = 0;

    while (offset + 4 <= bytes.length) {
      final len = _readInt32(bytes, offset);
      if (offset + 4 + len > bytes.length) break;

      final body = bytes.sublist(offset + 4, offset + 4 + len);
      try {
        messages.add(MarketProto.MarketMessage.fromBuffer(body));
      } catch (_) {}

      offset += 4 + len;
    }

    // 保留未消费的数据
    if (offset > 0) {
      _buffer.clear();
      _buffer.add(bytes.sublist(offset));
    }

    return messages;
  }

  int _readInt32(Uint8List b, int o) =>
      (b[o] << 24) | (b[o + 1] << 16) | (b[o + 2] << 8) | b[o + 3];
}
