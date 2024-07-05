
import '../entites/chat.dart';
import '../repository/live_repository.dart';

class GetChatCommentStreamUsecase{
  final LiveRepository liveRepository;

  GetChatCommentStreamUsecase(this.liveRepository);

   Stream<List<Chat>> call(GetChatCommentStreamParams params) {
    return liveRepository.getChatCommentStream(params.channelId);
  }


}
class GetChatCommentStreamParams{
final String channelId;

const GetChatCommentStreamParams({
    required this.channelId,
  });
}