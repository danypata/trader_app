import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Generate a mock class for UserService
@GenerateNiceMocks([MockSpec<WebSocketSink>(), MockSpec<WebSocketChannel>()])
void main() {}
