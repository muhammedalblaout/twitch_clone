part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetAllChatComment extends ChatState {
  final List<Chat> list;

  GetAllChatComment(this.list);
}

final class ChatSuccess extends ChatState {}

final class Chatfail extends ChatState {
  final String massage;

  Chatfail(this.massage);
}
