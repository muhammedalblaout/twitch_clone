part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}
class UploadChatCommendEvent extends ChatEvent
{
  final String username;
  final String message;
  final String uid;
  final String channelId;

   UploadChatCommendEvent({
    required this.username,
    required this.message,
    required this.uid,
    required this.channelId,
  });
}

class GetAllChatCommendEvent extends ChatEvent
{

  final String channelId;

  GetAllChatCommendEvent({

    required this.channelId,
  });
}

class AllChatLoadedCommendEvent extends ChatEvent
{
final List<Chat> list;

AllChatLoadedCommendEvent({

  required this.list,
});
}