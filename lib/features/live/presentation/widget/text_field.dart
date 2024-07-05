import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_pallete.dart';

class TwitchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int? minLine;
  final int? maxLine;
  final TextInputType textInputType;


  static _border([Color color = AppPallete.lightPurple]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );
   const TwitchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.textInputType= TextInputType.text,
    this.minLine,
    this.maxLine=1

  });
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      keyboardType: textInputType,
      minLines: minLine,
      maxLines:maxLine,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled:true,
        fillColor: AppPallete.lightPurple.withOpacity(0.3),
        hintStyle:GoogleFonts.notoSans().copyWith(color: AppPallete.lightPurple,fontWeight: FontWeight.w600),

        contentPadding: const EdgeInsets.all(20),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.lightPurple),
        errorBorder: _border(AppPallete.error),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      style:GoogleFonts.notoSans().copyWith(color: AppPallete.lightPurple, fontWeight: FontWeight.w600),
    );
  }
}

