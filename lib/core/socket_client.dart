import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef DataCallback = void Function(Uint8List data);

class SocketClient {
  final String host;
  final int port;
  final DataCallback onData;

  Socket? _socket;
  Timer? _reconnectTimer;
  StreamSubscription? _netSub;

  bool _manualClose = false;
  bool _connecting = false;

  final Set<String> _subscribedCodes = {};

  SocketClient({
    required  this.host,
    required this.port,
    required this.onData,
  });

  /// 初始化网络变化监听
  void initNetworkListener() {
    _netSub =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> r) {

          if (r.first != ConnectivityResult.none) {
            if (_socket == null && !_connecting) {
              _scheduleReconnect();
            }
          }
        });
  }

  /// 建立连接（防并发）
  void connect() async {
    print("connecting");
    if (_connecting) return;
    _connecting = true;

    try {
      _manualClose = false;
      _socket?.destroy();

      _socket = await Socket.connect(
        host,
        port,
        timeout: const Duration(seconds: 5),
      );

      _socket!.listen(
        onData,
        onDone: _onDisconnect,
        onError: (_) => _onDisconnect(),
        cancelOnError: true,
      );

      _reconnectTimer?.cancel();
      _resubscribe();
    } catch (_) {
      _scheduleReconnect();
    } finally {
      _connecting = false;
    }
  }

  /// 订阅股票
  void subscribe(List<String> codes) {
    _subscribedCodes.addAll(codes);
    if (_socket == null) return;

    for (final c in codes) {
      _socket!.write("SUB $c\n");
    }

  }

  /// 重连后恢复订阅
  void _resubscribe() {
    if (_socket == null) return;
    for (final c in _subscribedCodes) {
      _socket!.write("SUB $c\n");
    }
  }

  /// 断线处理
  void _onDisconnect() {
    if (_manualClose) return;
    _socket?.destroy();
    _socket = null;
    _scheduleReconnect();
  }

  /// 短线重连（3 秒一次，防抖）
  void _scheduleReconnect() {
    if (_reconnectTimer?.isActive == true) return;

    _reconnectTimer =
        Timer.periodic(const Duration(seconds: 3), (_) {
          if (_socket == null && !_connecting) {
            connect();
          }
        });
  }

  void close() {
    _manualClose = true;
    _reconnectTimer?.cancel();
    _netSub?.cancel();
    _socket?.destroy();
  }
}
