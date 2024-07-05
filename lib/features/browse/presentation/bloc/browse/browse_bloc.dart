import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:twitch_clone/core/usecase/usecase.dart';

import '../../../../../core/entites/live_stream_data.dart';
import '../../../domin/usecase/get_current_live_stream_usecase.dart';

part 'browse_event.dart';

part 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final GetCurrentLiveStreamUsecase _getCurrentLiveStreamUsecase;

  BrowseBloc({required GetCurrentLiveStreamUsecase getCurrentLiveStreamUsecase})
      : _getCurrentLiveStreamUsecase = getCurrentLiveStreamUsecase,
        super(BrowseInitial()) {
    on<BrowseEvent>((event, emit) {});

    on<GetAllCurrentLiveEvent>((event, emit) async {
      final res = await _getCurrentLiveStreamUsecase();
      await emit.onEach<List<LiveStreamData>>(res,
          onData: (list) => add(CurrentLiveLoadedEvent(list)));
    });
    on<CurrentLiveLoadedEvent>(
        (event, emit) => emit(BrowseSuccess(event.list)));
  }
}
