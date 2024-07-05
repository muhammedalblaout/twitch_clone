import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';
import 'package:twitch_clone/features/live/presentation/bloc/chat/chat_bloc.dart';
import 'package:twitch_clone/features/live/presentation/widget/chat_list_card.dart';

import '../../../../core/entites/user.dart';
import '../../domin/entites/chat.dart';

class ChatWidget extends StatefulWidget {
  final User user;

  final LiveStreamData liveStreamData;

  const ChatWidget(
      {super.key, required this.user, required this.liveStreamData});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<Chat> list = [];

  @override
  void initState() {
    context.read<ChatBloc>().add(
        GetAllChatCommendEvent(channelId: widget.liveStreamData.channelId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: SizedBox(
              width: 0.7.sw,
          child: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is GetAllChatComment) {
                list = state.list;
              }
            },
            builder: (context, state) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ChatListCard(chat: list[index]);
                },
                itemCount: list.length,
              );
            },
          ),
        )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.sp),
          width: double.infinity,
          height: 60.sp,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.sp),
                  height: 40.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppPallete.white,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your message ...',
                            hintStyle: GoogleFonts.notoSans().copyWith(
                              color: AppPallete.darkGray,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                            ),
                          ),
                          style: GoogleFonts.notoSans().copyWith(
                            color: AppPallete.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                          keyboardType: TextInputType.multiline,
                          controller: commentController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () {
                  if (commentController.text.trim() != '') {
                    context.read<ChatBloc>().add(UploadChatCommendEvent(
                        username: widget.user.name,
                        message: commentController.text.trim(),
                        uid: widget.user.id,
                        channelId: widget.liveStreamData.channelId));
                    commentController.text='';
                  }
                },
                child: const CircleAvatar(
                  backgroundColor: AppPallete.purple,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
