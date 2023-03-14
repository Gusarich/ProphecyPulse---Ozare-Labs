part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.chats = const [],
  });

  final ChatStatus status;
  final List<Chat> chats;

  ChatState copyWith({
    ChatStatus? status,
    List<Chat>? chats,
  }) {
    return ChatState(
      status: status ?? this.status,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object> get props => [status, chats];
}
