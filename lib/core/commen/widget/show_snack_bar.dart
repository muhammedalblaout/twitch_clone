import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_pallete.dart';

void ErrorShowSnackBar(
  BuildContext context,
  String text,
) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppPallete.error,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppPallete.white,
              size: 40,
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Error:",
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 18, color: AppPallete.white),
                ),
                Text(
                  text,
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 12, color: AppPallete.white),
                )
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppPallete.transparent,
      elevation: 0,
    ));
}

void SuccessShowSnackBar(
  BuildContext context,
  String text,
) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppPallete.accept,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppPallete.white,
              size: 40,
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Success:",
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 18, color: AppPallete.white),
                ),
                Text(
                  text,
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 12, color: AppPallete.white),
                )
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppPallete.transparent,
      elevation: 0,
    ));
}
