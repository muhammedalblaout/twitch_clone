part of 'live_stream_bloc.dart';

@immutable
sealed class LiveStreamState {}

final class LiveStreamInitial extends LiveStreamState {}

class LiveStreamLoading extends LiveStreamState {}

class LiveStreamSuccess extends LiveStreamState {
  final LiveStreamData liveStreamData;

  LiveStreamSuccess(this.liveStreamData);
}

class LiveStreamFail extends LiveStreamState {
  final String Massage;

  LiveStreamFail(this.Massage);
}

