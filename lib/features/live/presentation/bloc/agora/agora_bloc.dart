
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twitch_clone/core/secrets/app_secret.dart';
import 'package:twitch_clone/core/utils/enum.dart';

import '../../../domin/usecase/end_live_stream_usecase.dart';
import '../../../domin/usecase/get_token_usecase.dart';
import '../../../domin/usecase/update_viewer_number_usecase.dart';

part 'agora_event.dart';

part 'agora_state.dart';

class AgoraBloc extends Bloc<AgoraEvent, AgoraState> {
  final GetTokenUsecase _getTokenUsecase;
  final EndStreamUsecase _endStreamUsecase;
  final  UpdateViewerNumberUsecase _updateViewerNumberUsecase;

  AgoraBloc(
      {
      required GetTokenUsecase getTokenUsecase,
      required EndStreamUsecase endStreamUsecase,
      required UpdateViewerNumberUsecase updateViewerNumberUsecase})
      :
        _getTokenUsecase = getTokenUsecase,
        _endStreamUsecase = endStreamUsecase,
        _updateViewerNumberUsecase=updateViewerNumberUsecase,
        super(AgoraInitial()) {
    RtcEngine _engine = createAgoraRtcEngine();

    on<AgoraEvent>((event, emit) {});

    on<StartBroadcast>((event, emit) async {
      await _engine.initialize(RtcEngineContext(
        appId: AppSecret.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));
      await _engine.registerLocalUserAccount(
          appId: AppSecret.agoraAppId, userAccount: event.userId);

      await [Permission.microphone, Permission.camera].request();
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await _engine.enableVideo();
      await _engine.startPreview();

      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint("local user ${connection.localUid} joined");
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint("remote user $remoteUid joined");
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            debugPrint("remote user $remoteUid left channel");
          },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            debugPrint(
                '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
          onRtcStats: (RtcConnection connection, RtcStats stats){
            if(!isClosed){
              add(UpdateDurationTimeEvent(stats.duration));
            }
          }
        ),
      );
      String? token;

      final res = await _getTokenUsecase(TokenServerParams(
          channelId: event.channelId,
          uid: event.userId,
          role: AgoraRole.publisher));
      res.fold((l) => emit(AgoraFail(l.massage)), (r) {
        token = r;

      });
      await _engine.joinChannelWithUserAccount(
        token: token!,
        channelId: event.channelId,
        options: const ChannelMediaOptions(),
        userAccount: event.userId,
      );
      emit(StartedBroadcastSuccess(_engine));
    });

    on<JoinBroadcast>((event, emit) async {
      await _updateViewerNumberUsecase(UpdateViewerNumberParams(channelId: event.channelId, isIncrease: true));
      await [Permission.microphone, Permission.camera].request();

      await _engine.initialize(RtcEngineContext(
        appId: AppSecret.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));
      await _engine.registerLocalUserAccount(
          appId: AppSecret.agoraAppId, userAccount: event.userId );

      await _engine.setClientRole(role: ClientRoleType.clientRoleAudience);
      await _engine.enableVideo();
      await _engine.startPreview();

      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint("local user ${connection.localUid} joined");
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint("remote user $remoteUid joined");
            if (!isClosed) {
              add(UserJoindEvent(remoteUid));

            }
            },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            debugPrint("remote user $remoteUid left channel");

          },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            debugPrint(
                '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
            onRtcStats: (RtcConnection connection, RtcStats stats){
              if(!isClosed){
                add(UpdateDurationTimeEvent(stats.duration));
              }
            },

        ),
      );

      String? token;

      final res = await _getTokenUsecase(TokenServerParams(
          channelId: event.channelId,
          uid: event.userId,
          role: AgoraRole.subscriber));
      res.fold((l) => emit(AgoraFail(l.massage)), (r) {
        token = r;

      });
      await _engine.joinChannelWithUserAccount(
        token: token!,
        channelId: event.channelId,
        options: const ChannelMediaOptions(),
        userAccount: event.userId,
      );
      emit(JoindBroadcastSuccess(_engine));
    });

    on<EndStreamlEvent>((event, emit) async {
      await _endStreamUsecase(EndStreamParams(channelId: event.channelId));
      await _engine.leaveChannel();
    });
    on<LeaveChannelEvent>((event, emit) async {
      await _updateViewerNumberUsecase(UpdateViewerNumberParams(channelId: event.channelId, isIncrease: false));
      await _engine.leaveChannel();


    });
    on<UserJoindEvent>((event, emit) async {
      emit(UserJoindState(event.uuid));
    });

    on<UpdateDurationTimeEvent>((event, emit) async {
      emit(UpdateDurationTimeState(event.duration));
    });

  }
}
