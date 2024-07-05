import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:twitch_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:twitch_clone/features/auth/presentation/page/login_page.dart';

import '../../../../core/commen/widget/loader.dart';
import '../../../../core/commen/widget/show_snack_bar.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) {
        return const SignUpPage();
      });

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
            child: Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFail) {
                    ErrorShowSnackBar(context, state.massage);
                  }
                  if (state is AuthSuccess) {
                    Navigator.pop(context);
                  }

                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: Loader(
                        color: AppPallete.white,
                      ),
                    );
                  }

                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sign Up",
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
                              SizedBox(height: 40.sp),
                              CustomTextField(
                                hint: 'Name',
                                icon: Icons.person_outline,
                                isPassword: false,
                                textEditingController: nameController,
                              ),
                              SizedBox(
                                height: 8.sp,
                              ),
                              CustomTextField(
                                hint: 'Twitch@Gmail.com',
                                icon: Icons.mail_outline_outlined,
                                isPassword: false,
                                textEditingController: emailController,
                              ),
                              SizedBox(height: 8.sp),
                              CustomTextField(
                                hint: 'Password',
                                icon: Icons.lock_outline,
                                isPassword: true,
                                textEditingController: passwordController,
                              ),
                              SizedBox(
                                height: 16.sp,
                              ),
                              CustomButton(
                                text: 'Sign Up',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(SignUpEvent(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                        nameController.text.trim()));
                                  }
                                },
                                color: AppPallete.purple,
                                textColor: AppPallete.white,
                              ),
                              SizedBox(
                                height: 16.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, LoginPage.route());
                                },
                                child: RichText(
                                  text: TextSpan(
                                      text: "Already have an account? ",
                                      style: GoogleFonts.notoSans().copyWith(
                                          color: AppPallete.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            const Shadow(
                                              blurRadius: 50,
                                            ),
                                            const Shadow(blurRadius: 50)
                                          ]),
                                      children: [
                                        TextSpan(
                                            text: "Login",
                                            style: GoogleFonts.notoSans()
                                                .copyWith(
                                                    color:
                                                        AppPallete.lightPurple,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                  const Shadow(
                                                      blurRadius: 50,
                                                      color: AppPallete.black),
                                                ]))
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
