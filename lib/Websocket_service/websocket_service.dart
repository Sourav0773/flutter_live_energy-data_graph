import 'package:web_socket_channel/web_socket_channel.dart';

final webSocket = WebSocketChannel.connect(
  Uri.parse('wss://sourav-iot-energy-data-backend.onrender.com'),
);
