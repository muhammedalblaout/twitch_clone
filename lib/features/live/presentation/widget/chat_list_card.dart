import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../domin/entites/chat.dart';

class ChatListCard extends StatelessWidget {
  final Chat chat;

  const ChatListCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 2.sp) ,
      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical:8.sp ),
      decoration: BoxDecoration(
        color: AppPallete.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.account_circle_rounded,
            size: 30.sp,
            color: AppPallete.white,
          ),
          SizedBox(width: 4.sp,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat.username,
                    style: GoogleFonts.notoSans().copyWith(
                        color: AppPallete.lightGray,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                       )),
                Text(chat.message,
                    style: GoogleFonts.notoSans().copyWith(
                      color: AppPallete.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 10.sp,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
