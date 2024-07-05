part of 'browse_bloc.dart';

@immutable
sealed class BrowseState {}

final class BrowseInitial extends BrowseState {}
final class BrowseLoading extends BrowseState {}

final class BrowseSuccess extends BrowseState {
  final List<LiveStreamData> list;

  BrowseSuccess(this.list);
}
final class BrowseFail extends BrowseState {
  final String massage ;

  BrowseFail(this.massage);
}
