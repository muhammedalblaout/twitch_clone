import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';
import 'package:twitch_clone/core/error/failures.dart';
import 'package:twitch_clone/features/live/domin/entites/chat.dart';

import '../../../../core/utils/enum.dart';

abstract interface class LiveRepository {
  Future<Either<Failures, LiveStreamData>> uploadLiveStreamData(
      {required File image,
      required String title,
      required String description,
      required String uid,
      required String name});

  Future<Either<Failures, String>> getToken(
      {required String channelId,
      required String uid,
      required AgoraRole role});

  Future<Either<Failures, void>> endLiveStream({
    required String channelId,
  });

  Future<Either<Failures, void>> updateViewCount({
    required String id,
    required bool isIncrease,
  });

  Future<Either<Failures, void>> uploadChatComment(
      {required String message,
      required String uid,
      required String username,
      required String channelId});

  Stream<List<Chat>> getChatCommentStream(String channelId);

}
