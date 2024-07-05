import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';
import 'package:twitch_clone/features/browse/presentation/bloc/browse/browse_bloc.dart';
import 'package:twitch_clone/features/live/presentation/bloc/live_stream/live_stream_bloc.dart';
import 'package:twitch_clone/features/live/presentation/page/live_page.dart';
import '../../../../int_dep.dart';
import '../../../browse/presentation/page/browse_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return const HomePage();
      });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int _selectedTab = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      BlocProvider(
        create: (context) => serviceLocator<BrowseBloc>(),
        child: const BrowsePage(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<LiveStreamBloc>(),
        child: const LivePage(),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: _pages),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CustomNavigationBar(
              iconSize: 24.0,
              selectedColor: AppPallete.lightPurple,
              unSelectedColor: AppPallete.lightGray,
              strokeColor: AppPallete.lightPurple,
              borderRadius: const Radius.circular(10),
              backgroundColor: AppPallete.darkGray,
              items: [
                CustomNavigationBarItem(
                  icon: Image.asset(
                    'icons/web.png',
                    height: 20.sp,
                    width: 20.sp,
                    color: _selectedTab == 0
                        ? AppPallete.lightPurple
                        : AppPallete.white,
                  ),
                  title: Text(
                    "Browse",
                    style: GoogleFonts.notoSans().copyWith(
                      color: _selectedTab == 0
                          ? AppPallete.lightPurple
                          : AppPallete.white,
                    ),
                  ),
                ),
                CustomNavigationBarItem(
                  icon: Image.asset(
                    'icons/live.png',
                    height: 20.sp,
                    width: 20.sp,
                    color: _selectedTab == 1
                        ? AppPallete.lightPurple
                        : AppPallete.white,
                  ),
                  title: Text(
                    "Go Live",
                    style: GoogleFonts.notoSans().copyWith(
                      color: _selectedTab == 1
                          ? AppPallete.lightPurple
                          : AppPallete.white,
                    ),
                  ),
                ),
              ],
              isFloating: true,
              currentIndex: _selectedTab,
              onTap: _handleIndexChanged)),
    );
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
      pageController.jumpToPage(_selectedTab);
    });
  }

  void pageChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  bool get wantKeepAlive => true;
}
