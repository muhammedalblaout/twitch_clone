import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/enum.dart';
import '../repository/live_repository.dart';

class GetTokenUsecase implements Usecase<String, TokenServerParams> {
  final LiveRepository liveRepository;

  GetTokenUsecase(this.liveRepository);

  @override
  Future<Either<Failures, String>> call(TokenServerParams params) async {
    return await liveRepository.getToken(
        channelId: params.channelId, uid: params.uid, role: params.role);
  }
}

class TokenServerParams {
  final String channelId;
  final String uid;
  final AgoraRole role;

  const TokenServerParams({
    required this.channelId,
    required this.uid,
    required this.role,
  });
}
