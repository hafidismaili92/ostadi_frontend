part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class InitializingChat extends ChatState {

}



final class ChatMessagesUpdate extends ChatState{
  final List<String> messages;

  ChatMessagesUpdate({required this.messages});

@override
  List<Object> get props => [messages];
}


