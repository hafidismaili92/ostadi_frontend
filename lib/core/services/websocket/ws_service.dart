import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  
  WebSocketChannel? _channel;

  
  Future<void> connect(String url) async {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    if(_channel != null) {await _channel!.ready;}
  }

Stream<dynamic> get messages => _channel!.stream;

void sendMessage(String message) {
  if(_channel != null){
     _channel!.sink.add(message);
  }


   
  }
}