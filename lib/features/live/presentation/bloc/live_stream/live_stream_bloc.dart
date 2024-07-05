import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';

import '../../../domin/usecase/live_stream_data_upload_usecase.dart';

part 'live_stream_event.dart';

part 'live_stream_state.dart';

class LiveStreamBloc extends Bloc<LiveStreamEvent, LiveStreamState> {
  final LiveStreamDataUploadUsecase _liveStreamDataUploadUsecase;

  LiveStreamBloc(
      {required LiveStreamDataUploadUsecase liveStreamDataUploadUsecase})
      : _liveStreamDataUploadUsecase = liveStreamDataUploadUsecase,
        super(LiveStreamInitial()) {
    on<LiveStreamEvent>((event, emit) {});
    on<UploadLiveStreamEvent>((event, emit) async {
      emit(LiveStreamLoading());
      final res = await _liveStreamDataUploadUsecase(LiveStreamDataParams(
          image: event.image,
          title: event.title,
          description: event.description,
          uid: event.uid,
          name: event.name));
      res.fold((l) => emit(LiveStreamFail(l.massage)),
              (r) {
        emit(LiveStreamSuccess(r));
      });
    });
  }
}
