import 'package:twitch_clone/core/model/live_stream_data_model.dart';
import 'package:twitch_clone/features/browse/data/datasource/browse_datasource.dart';
import 'package:twitch_clone/features/browse/domin/repository/browse_repository.dart';

class BrowseRepositoryImp implements BrowseRepository {
  final BrowseDatasource browseDatasource;

  BrowseRepositoryImp(this.browseDatasource);

  @override
  Stream<List<LiveStreamDataModel>> getCurrentLiveStream() {
    final data = browseDatasource.getCurrentLive();

    return data;
  }
}
