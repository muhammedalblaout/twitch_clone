import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domin/entites/chat.dart';
import '../../../domin/usecase/get_chat_comment_stream_usecase.dart';
import '../../../domin/usecase/upload_chat_comment_usecase.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UploadChatCommentUsecase _uploadChatCommentUsecase;
  final GetChatCommentStreamUsecase _getChatCommentStreamUsecase;

  ChatBloc(
      {required UploadChatCommentUsecase uploadChatCommentUsecase,
      required GetChatCommentStreamUsecase getChatCommentStreamUsecase})
      : _uploadChatCommentUsecase = uploadChatCommentUsecase,
        _getChatCommentStreamUsecase = getChatCommentStreamUsecase,
        super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<UploadChatCommendEvent>((event, emit) async {
      final res = await _uploadChatCommentUsecase(UploadChatCommentParams(
          message: event.message,
          uid: event.uid,
          username: event.username,
          channelId: event.channelId));
      res.fold((l) => emit(Chatfail(l.massage)), (r) {
        emit(ChatSuccess());
      });
    });

    on<GetAllChatCommendEvent>((event, emit) async {
      final res =  _getChatCommentStreamUsecase(GetChatCommentStreamParams(channelId: event.channelId));
      await emit.onEach<List<Chat>>(res,
          onData: (list) => add(AllChatLoadedCommendEvent(list: list)));
    });

    on<AllChatLoadedCommendEvent>(
            (event, emit) => emit(GetAllChatComment(event.list)));
  }
  }

