import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:twitch_clone/core/commen/widget/loader.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';
import 'package:twitch_clone/features/live/presentation/bloc/chat/chat_bloc.dart';
import 'package:twitch_clone/features/live/presentation/widget/chat_widget.dart';
import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../int_dep.dart';
import '../bloc/agora/agora_bloc.dart';

class BroadcastPage extends StatefulWidget {
  final LiveStreamData liveStreamData;

  const BroadcastPage({super.key, required this.liveStreamData});

  static route(LiveStreamData liveStreamData) =>
      MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<AgoraBloc>()),
          ],
          child: BroadcastPage(
            liveStreamData: liveStreamData,
          ),
        );
      });

  @override
  State<BroadcastPage> createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  bool isChatVisable = false;
  bool isStarted = false;
  int? time;


  late RtcEngine rtcEngine;

  @override
  void initState() {
    final user = (context.read<AppUserCubit>().state as AppUserLoggin).user;
    context
        .read<AgoraBloc>()
        .add(StartBroadcast(user.id, widget.liveStreamData.channelId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppUserCubit>().state as AppUserLoggin).user;

    return WillPopScope(
      onWillPop: () async {
        context
            .read<AgoraBloc>()
            .add(EndStreamlEvent(widget.liveStreamData.channelId));
        return true;
      },
      child: Scaffold(
        backgroundColor: AppPallete.white,
        body: SafeArea(
          child: Stack(
            children: [
              BlocConsumer<AgoraBloc, AgoraState>(
                listener: (context, state) {
                  if (state is StartedBroadcastSuccess) {
                    rtcEngine = state.rtcEngine;
                    setState(() {
                      isStarted = true;
                    });
                  }
                },
                builder: (context, state) {
                  return isStarted
                      ? Center(
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: rtcEngine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          ),
                        )
                      : const Center(
                          child: Loader(
                            color: AppPallete.purple,
                          ),
                        );
                },
              ),
              isStarted
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.account_circle_outlined,
                                  color: AppPallete.white,
                                  size: 50.sp,
                                  shadows: [
                                    Shadow(
                                        color: AppPallete.black,
                                        blurRadius: 2.sp)
                                  ]),
                              SizedBox(
                                width: 4.sp,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.liveStreamData.username,
                                    style: GoogleFonts.notoSans().copyWith(
                                        color: AppPallete.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                        shadows: [
                                          Shadow(
                                              color: AppPallete.black,
                                              blurRadius: 2.sp)
                                        ]),
                                    textAlign: TextAlign.start,
                                  ),
                                  BlocBuilder<AgoraBloc, AgoraState>(
                                    builder: (context, state) {
                                      if (state is UpdateDurationTimeState) {
                                        return Text(
                                          state.duration == null
                                              ? ""
                                              : convertSecondToTime(
                                                  state.duration!),
                                          style: GoogleFonts.notoSans()
                                              .copyWith(
                                                  color: AppPallete.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  shadows: [
                                                Shadow(
                                                    color: AppPallete.black,
                                                    blurRadius: 2.sp)
                                              ]),
                                          textAlign: TextAlign.start,
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChatVisable = !isChatVisable;
                            });
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 0.30.sh,
                            child: isChatVisable
                                ? Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          AppPallete.black.withOpacity(0.0),
                                          AppPallete.black.withOpacity(0.2),
                                          AppPallete.black.withOpacity(0.3),
                                          AppPallete.black.withOpacity(0.4),
                                          AppPallete.black.withOpacity(0.6),
                                          AppPallete.black.withOpacity(0.6)
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.liveStreamData.title,
                                            style: GoogleFonts.notoSans()
                                                .copyWith(
                                                    color: AppPallete.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.sp,
                                                    shadows: [
                                                  Shadow(
                                                      color: AppPallete.black,
                                                      blurRadius: 3.sp)
                                                ]),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height: 4.sp,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: ReadMoreText(
                                                widget
                                                    .liveStreamData.description,
                                                trimMode: TrimMode.Line,
                                                trimLines: 4,
                                                colorClickableText:
                                                    AppPallete.lightPurple,
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: 'Show less',
                                                moreStyle:
                                                    GoogleFonts.notoSans()
                                                        .copyWith(
                                                  color: AppPallete.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                ),
                                                style: GoogleFonts.notoSans()
                                                    .copyWith(
                                                        color: AppPallete.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                        shadows: [
                                                      Shadow(
                                                          color:
                                                              AppPallete.black,
                                                          blurRadius: 3.sp)
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : BlocProvider(
                                    create: (context) =>
                                        serviceLocator<ChatBloc>(),
                                    child: ChatWidget(
                                      user: user,
                                      liveStreamData: widget.liveStreamData,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
