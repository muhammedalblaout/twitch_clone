
import '../../../../core/entites/live_stream_data.dart';

abstract interface class BrowseRepository{
  Stream<List<LiveStreamData>> getCurrentLiveStream();
}