part of 'live_stream_bloc.dart';

@immutable
sealed class LiveStreamEvent {}
class UploadLiveStreamEvent extends LiveStreamEvent{
  final File image;
  final String title;
  final String description;
  final String uid;
  final String name;

   UploadLiveStreamEvent({
    required this.image,
    required this.title,
    required this.description,
    required this.uid,
    required this.name,
  });
}
