import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/live_repository.dart';

class UploadChatCommentUsecase
    implements Usecase<void, UploadChatCommentParams> {
  final LiveRepository liveRepository;

  UploadChatCommentUsecase(this.liveRepository);

  @override
  Future<Either<Failures, void>> call(UploadChatCommentParams params) async {
    return await liveRepository.uploadChatComment(message: params.message,
        uid: params.uid,
        username: params.username,
        channelId: params.channelId);
  }
}

class UploadChatCommentParams {
  final String message;
  final String uid;
  final String username;
  final String channelId;


  UploadChatCommentParams({
    required this.message,
    required this.uid,
    required this.username,
    required this.channelId,


  });
}
