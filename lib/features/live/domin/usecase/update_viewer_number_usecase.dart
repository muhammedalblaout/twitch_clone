import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/live_repository.dart';

class UpdateViewerNumberUsecase implements Usecase<void, UpdateViewerNumberParams> {
  final LiveRepository liveRepository;

  UpdateViewerNumberUsecase(this.liveRepository);

  @override
  Future<Either<Failures, void>> call(UpdateViewerNumberParams params) async {
    return await liveRepository.updateViewCount(id: params.channelId, isIncrease: params.isIncrease, );
  }
}

class UpdateViewerNumberParams {
  final String channelId;
  final bool isIncrease;


  const UpdateViewerNumberParams({
    required this.channelId,
    required this.isIncrease,

  });
}
