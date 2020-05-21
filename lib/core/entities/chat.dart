import 'message.dart';

class Chat {
  final String id;
  final String name;

  final List<Message> messages;

  const Chat({
    this.id,
    this.name,
    this.messages,
  });
}
