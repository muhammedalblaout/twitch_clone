import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';

import '../../../../core/entites/live_stream_data.dart';

class LiveCard2 extends StatefulWidget {
  final LiveStreamData liveStreamData;

  const LiveCard2({super.key, required this.liveStreamData});

  @override
  State<LiveCard2> createState() => _LiveCard2State();
}

class _LiveCard2State extends State<LiveCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.sp),
      width: double.infinity,
      height: 220.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sp),
        color: AppPallete.darkGray,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 150.sp,
            child: Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150.sp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.sp),
                      child: Image.network(
                        widget.liveStreamData.image,
                        fit: BoxFit.cover,
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
              ),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: AppPallete.white,
                size: 40.sp,
              ),
              SizedBox(
                width: 4.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        widget.liveStreamData.title,
                        style: GoogleFonts.notoSans().copyWith(
                            color: AppPallete.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.liveStreamData.username,
                       style: GoogleFonts.notoSans().copyWith(
                        color: AppPallete.lightGray,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
