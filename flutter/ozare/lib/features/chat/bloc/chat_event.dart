part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatStreamRequested extends ChatEvent {
  final String eventId;

  const ChatStreamRequested({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class ChatChanged extends ChatEvent {
  final List<Chat> chat;

  const ChatChanged({required this.chat});

  @override
  List<Object> get props => [chat];
}

class ChatSend extends ChatEvent {
  final Chat chat;

  const ChatSend({required this.chat});

  @override
  List<Object> get props => [chat];
}

class ChatSubscriptionRequested extends ChatEvent {}
