part of 'agora_bloc.dart';

@immutable
sealed class AgoraEvent {}

class StartBroadcast extends AgoraEvent {
  final String userId;

  final String channelId;

  StartBroadcast(this.userId, this.channelId);
}

class JoinBroadcast extends AgoraEvent {
  final String userId;

  final String channelId;

  JoinBroadcast(this.userId, this.channelId);
}

class EndStreamlEvent extends AgoraEvent {
  final String channelId;

  EndStreamlEvent(this.channelId);
}

class LeaveChannelEvent extends AgoraEvent {
  final String channelId;

  LeaveChannelEvent(this.channelId);
}
class UserJoindEvent extends AgoraEvent {
  final int uuid;

  UserJoindEvent(this.uuid);
}

class UpdateDurationTimeEvent extends AgoraEvent {
  final int? duration;

  UpdateDurationTimeEvent(this.duration);
}
