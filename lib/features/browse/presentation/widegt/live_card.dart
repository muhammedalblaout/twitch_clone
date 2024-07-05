import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/entites/live_stream_data.dart';

import '../../../../core/theme/app_pallete.dart';

class LiveCard extends StatefulWidget {
  final LiveStreamData liveStreamData;

  const LiveCard({super.key, required this.liveStreamData});

  @override
  State<LiveCard> createState() => _LiveCardState();
}

class _LiveCardState extends State<LiveCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: AppPallete.darkGray),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 120.sp,
              height: 80.sp,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 120.sp,
                      height: 80.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppPallete.darkGray),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Image.network(
                          widget.liveStreamData.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppPallete.live,
                            size: 12.sp,
                          ),
                          SizedBox(
                            width: 4.sp,
                          ),
                          Text(widget.liveStreamData.viewers.toString(),
                              style: GoogleFonts.notoSans().copyWith(
                                  color: AppPallete.white,
                                  fontSize: 12.sp,
                                  shadows: [
                                    Shadow(
                                        color: AppPallete.black,
                                        blurRadius: 10.sp)
                                  ],
                                  fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            width: 16.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: AppPallete.white,
                    size: 30.sp,
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  Text(widget.liveStreamData.username,
                      style: GoogleFonts.notoSans().copyWith(
                          color: AppPallete.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 4.sp,
              ),
              Text(widget.liveStreamData.title,
                  style: GoogleFonts.notoSans().copyWith(
                      color: AppPallete.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
