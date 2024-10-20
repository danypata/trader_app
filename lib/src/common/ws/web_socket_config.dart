import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/gen/app_config.gen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'web_socket_config.g.dart';

@Riverpod()
WebSocketChannel webSocketChannel(WebSocketChannelRef ref, int id) {
  const url = '${AppConfig.finhubSocketUrl}?token=${AppConfig.finhubToken}';
  return WebSocketChannel.connect(Uri.parse(url));
}
