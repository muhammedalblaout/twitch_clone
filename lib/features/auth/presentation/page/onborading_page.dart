import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/utils/custom_button.dart';
import 'package:twitch_clone/features/auth/presentation/page/login_page.dart';
import 'package:twitch_clone/features/auth/presentation/page/signup_page.dart';

import '../../../../core/theme/app_pallete.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpeg"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(AppPallete.darkPurple, BlendMode.screen),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome \nTo Twitch",
                        style: GoogleFonts.notoSans().copyWith(
                            color: AppPallete.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              const Shadow(
                                blurRadius: 50,
                              ),
                              const Shadow(blurRadius: 50)
                            ]),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 60.sp,
                      ),
                      CustomButton(
                        text: "Log in",
                        onTap: () {
                          Navigator.push(this.context,
                              MaterialPageRoute(builder: (_) {
                            return const LoginPage();
                          }));
                        },
                        color: AppPallete.purple,
                        textColor: AppPallete.white,
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      CustomButton(
                        text: "Sign up",
                        onTap: () {
                          Navigator.push(context, SignUpPage.route());
                        },
                        color: AppPallete.lightGray,
                        textColor: AppPallete.purple,
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
