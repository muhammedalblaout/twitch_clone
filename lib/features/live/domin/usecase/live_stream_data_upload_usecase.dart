import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';
import 'package:twitch_clone/features/live/domin/repository/live_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class LiveStreamDataUploadUsecase
    implements Usecase<LiveStreamData, LiveStreamDataParams> {
  final LiveRepository liveRepository;

  LiveStreamDataUploadUsecase(this.liveRepository);

  @override
  Future<Either<Failures, LiveStreamData>> call(
      LiveStreamDataParams params) async {
    return await liveRepository.uploadLiveStreamData(
        image: params.image,
        title: params.title,
        description: params.description,
        uid: params.uid,
        name: params.name);
  }
}

class LiveStreamDataParams {
  final File image;
  final String title;
  final String description;
  final String uid;
  final String name;

  const LiveStreamDataParams({
    required this.image,
    required this.title,
    required this.description,
    required this.uid,
    required this.name,
  });
}
