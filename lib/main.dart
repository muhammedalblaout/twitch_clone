import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitch_clone/core/commen/widget/loader.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';
import 'package:twitch_clone/core/theme/app_theme.dart';
import 'package:twitch_clone/features/auth/presentation/page/onborading_page.dart';
import 'package:twitch_clone/features/home/presentation/page/home_page.dart';
import 'core/commen/cubit/app_user/app_user_cubit.dart';
import 'core/commen/cubit/app_user/app_user_state.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'int_dep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await intDependcies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitch',
        theme: AppTheme.Thememode,
        home: ScreenUtilInit(
            minTextAdapt: true,

            child: BlocBuilder<AppUserCubit, AppUserState>(
              builder: (context, state) {
                if (state is AppUserLoggin) {
                  return const HomePage();
                }
                else if(state is AppUserLoading){
                  return const Center(child: Loader(color: AppPallete.purple));
                }
                else {
                  return const OnBoardingPage();
                }
              },
            )));
  }
}
