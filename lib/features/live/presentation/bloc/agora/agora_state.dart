part of 'agora_bloc.dart';

@immutable
sealed class AgoraState {}

final class AgoraInitial extends AgoraState {}

class StartedBroadcastSuccess extends AgoraState{
  final RtcEngine rtcEngine;

  StartedBroadcastSuccess(this.rtcEngine);
}

class JoindBroadcastSuccess extends AgoraState{
  final RtcEngine rtcEngine;

  JoindBroadcastSuccess(this.rtcEngine);
}

final class AgoraFail extends AgoraState {
  final String massage;

  AgoraFail(this.massage);
}

final class UserJoindState extends AgoraState {
  final int uuid;

  UserJoindState(this.uuid);
}

class UpdateDurationTimeState extends AgoraState {
  final int? duration;

  UpdateDurationTimeState(this.duration);
}

