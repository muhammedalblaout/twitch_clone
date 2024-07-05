import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';
import 'package:twitch_clone/core/error/exceptions.dart';
import 'package:twitch_clone/core/error/failures.dart';
import 'package:twitch_clone/core/utils/enum.dart';
import 'package:twitch_clone/features/live/data/datasource/live_datasource.dart';
import 'package:twitch_clone/features/live/data/model/chat_model.dart';
import 'package:twitch_clone/features/live/domin/repository/live_repository.dart';

class LiveRepositoryImp implements LiveRepository {
  final LiveDatasource liveDatasource;

  LiveRepositoryImp(this.liveDatasource);

  @override
  Future<Either<Failures, LiveStreamData>> uploadLiveStreamData(
      {required File image,
      required String title,
      required String description,
      required String uid,
      required String name}) async {
    try {
      final imageUrl = await liveDatasource.uploadImage(
          image: image, uuid: uid, childname: name);

      final liveStreamData = await liveDatasource.uploadLiveStreamData(
          title, description, imageUrl, uid, name);
      return right(liveStreamData);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, String>> getToken(
      {required String channelId,
      required String uid,
      required AgoraRole role}) async {
    try {
      final token = await liveDatasource.getToken(channelId, uid, role);

      return right(token);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> endLiveStream(
      {required String channelId}) async {
    try {
      await liveDatasource.endLiveStream(channelId);

      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> updateViewCount(
      {required String id, required bool isIncrease}) async {
    try {
      await liveDatasource.updateViewCount(id, isIncrease);

      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> uploadChatComment(
      {required String message,
      required String uid,
      required String username,
      required String channelId}) async {
    try {
      await liveDatasource.uploadChatComment(message, uid, username, channelId);

      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Stream<List<ChatModel>> getChatCommentStream(String channelId) {
    final data = liveDatasource.getChatCommentsive(channelId);

    return data;
  }
}
