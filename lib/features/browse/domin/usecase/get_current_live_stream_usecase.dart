import 'package:twitch_clone/core/entites/live_stream_data.dart';
import 'package:twitch_clone/features/browse/domin/repository/browse_repository.dart';

class GetCurrentLiveStreamUsecase{
  final BrowseRepository browseRepository;

  GetCurrentLiveStreamUsecase(this.browseRepository);

   Stream<List<LiveStreamData>> call() {
    return browseRepository.getCurrentLiveStream();
  }

}