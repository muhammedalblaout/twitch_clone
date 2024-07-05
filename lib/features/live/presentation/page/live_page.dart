import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/commen/widget/loader.dart';
import 'package:twitch_clone/core/commen/widget/show_snack_bar.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';
import 'package:twitch_clone/core/utils/custom_button.dart';
import 'package:twitch_clone/features/live/presentation/bloc/live_stream/live_stream_bloc.dart';
import 'package:twitch_clone/features/live/presentation/widget/text_field.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/utils/pick_image.dart';
import 'broadcast_page.dart';

class LivePage extends StatefulWidget {

  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key:formKey ,
        child: BlocConsumer<LiveStreamBloc, LiveStreamState>(
          listener: (context, state) {
            if (state is LiveStreamFail) {
              ErrorShowSnackBar(context, state.Massage);
            }
            if (state is LiveStreamSuccess) {
              Navigator.push(context,BroadcastPage.route(state.liveStreamData));
            }
          },
          builder: (context, state) {
            if (state is LiveStreamLoading) {
              return Center(
                child: Loader(
                  color: AppPallete.purple,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    img != null
                        ? GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: SizedBox(
                              height: 1.sw,
                              width: 1.sw,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  img!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: Container(
                              width: 1.sw,
                              height: 1.sw,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DottedBorder(
                                    color: AppPallete.lightPurple,
                                    radius: const Radius.circular(16),
                                    dashPattern: const [10, 4],
                                    borderType: BorderType.RRect,
                                    strokeCap: StrokeCap.round,
                                    child: SizedBox(
                                      width: 120.sp,
                                      height: 120.sp,
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 40.sp,
                                        color: AppPallete.lightPurple,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Upload\nThumbnail ",
                                    style: GoogleFonts.notoSans().copyWith(
                                        color: AppPallete.lightPurple,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24.sp),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 50.sp,
                    ),
                    TwitchTextField(
                        hintText: 'Title', controller: titleController),
                    SizedBox(
                      height: 20.sp,
                    ),
                    TwitchTextField(
                      hintText: 'Description',
                      controller: descriptionController,
                      minLine: 3,
                      maxLine: 10,
                      textInputType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 50.sp,
                    ),
                    CustomButton(
                        text: "Go Live",
                        onTap: () {
                          if (formKey.currentState!.validate() && img != null) {
                            final user = (context.read<AppUserCubit>().state
                                    as AppUserLoggin)
                                .user;
                            print(user.name);
                
                            context.read<LiveStreamBloc>().add(
                                UploadLiveStreamEvent(
                                    image: img!,
                                    title: titleController.text.trim(),
                                    description:
                                        descriptionController.text.trim(),
                                    uid: user.id,
                                    name: user.name));
                          }
                        },
                        color: AppPallete.purple,
                        textColor: AppPallete.white)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  void selectImage() async {
    final pickedImage = await PickImage();
    if (pickedImage != null) {
      setState(() {
        img = pickedImage;
      });
    }
  }
}
