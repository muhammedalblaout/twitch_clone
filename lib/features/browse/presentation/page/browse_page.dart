import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitch_clone/core/commen/widget/loader.dart';
import 'package:twitch_clone/core/theme/app_pallete.dart';
import 'package:twitch_clone/features/browse/presentation/bloc/browse/browse_bloc.dart';
import 'package:twitch_clone/features/browse/presentation/widegt/live_card2.dart';
import 'package:twitch_clone/features/live/presentation/page/reciver_page.dart';

import '../../../../int_dep.dart';
import '../../../live/presentation/bloc/agora/agora_bloc.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  void initState() {
    context.read<BrowseBloc>().add(GetAllCurrentLiveEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Discover",
                  style: GoogleFonts.notoSans().copyWith(
                      color: AppPallete.lightGray,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800)),
              SizedBox(
                height: 16.sp,
              ),
              Expanded(
                child: BlocConsumer<BrowseBloc, BrowseState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is BrowseSuccess) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child:
                                LiveCard2(liveStreamData: state.list[index]),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                AgoraBloc agoraBloc =serviceLocator<AgoraBloc>();
                                return  MultiBlocProvider(
                                  providers: [
                                    BlocProvider(create: (_) => agoraBloc),
                                  ],
                                  child: ReciverPage(liveStreamData:  state.list[index],),
                                );
                              }));
                            },
                          );
                        },
                        itemCount: state.list.length,
                      );
                    }
                    return const Center(
                      child: Loader(
                        color: AppPallete.purple,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
