import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/live_repository.dart';

class EndStreamUsecase implements Usecase<void, EndStreamParams> {
  final LiveRepository liveRepository;

  EndStreamUsecase(this.liveRepository);

  @override
  Future<Either<Failures, void>> call(EndStreamParams params) async {
    return await liveRepository.endLiveStream(channelId: params.channelId);
  }
}

class EndStreamParams {
  final String channelId;

  const EndStreamParams({
    required this.channelId,
  });
}
