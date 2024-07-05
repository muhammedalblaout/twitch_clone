part of 'browse_bloc.dart';

@immutable
sealed class BrowseEvent {}
class GetAllCurrentLiveEvent extends BrowseEvent  {}
class CurrentLiveLoadedEvent extends BrowseEvent  {
  List<LiveStreamData> list;

  CurrentLiveLoadedEvent(this.list);
}
