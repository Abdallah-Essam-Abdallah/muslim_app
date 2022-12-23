import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/configs/arabic_numbers.dart';
import 'package:muslim_app/services/cache_helper.dart';
import 'package:muslim_app/cubit/quran_cubit/quran_cubit.dart';
import '../configs/size_config.dart';

class SurahScreen extends StatelessWidget {
  final int surahindex;
  final int audioindex;
  final int imageIndex;
  const SurahScreen(
      {super.key,
      required this.surahindex,
      required this.audioindex,
      required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) => Scaffold(
          appBar: orientation == Orientation.portrait
              ? SurahAppBar(surahindex: surahindex)
              : null,
          body: TabBarView(children: [
            SurahImages(pageNumber: imageIndex),
            SurahText(textIndex: surahindex),
            SurahAudio(audioIndex: audioindex),
          ]),
        ),
      ),
    );
  }
}

class SurahAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SurahAppBar({super.key, required this.surahindex});
  final int surahindex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        centerTitle: true,
        title: Text(QuranCubit.quranModel.chapters[surahindex].nameArabic),
        leading: IconButton(
            onPressed: () {
              QuranCubit.isAudioPlaying
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                              'هل تريد غلق المقطع الصوتى او الاستمرار فى الاستماع'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('استكمال')),
                            TextButton(
                                onPressed: () {
                                  QuranCubit.getQuranCubit(context)
                                      .audioPlaying()
                                      .then((value) {
                                    Navigator.pop(context);
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text('ايقاف'))
                          ],
                        );
                      })
                  : Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'تم حفظ موضع القرأه',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headline6,
                )));
                CacheHelper.setInt(
                    key: 'lastRead', value: QuranCubit.lastReadPage);
              },
              icon: const Icon(Icons.bookmark_add))
        ],
        bottom: const TabBar(tabs: [
          Tab(
            text: 'بالصور',
          ),
          Tab(
            text: 'بالنص',
          ),
          Tab(
            text: 'استماع',
          ),
        ]),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}

class SurahText extends StatelessWidget {
  const SurahText({super.key, required this.textIndex});
  final int textIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth! * .02),
      child: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            BlocBuilder<QuranCubit, QuranState>(builder: ((context, state) {
              return state is GetSurahLoadingState
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : SelectableText.rich(
                      textDirection: TextDirection.rtl,
                      TextSpan(
                        children: [
                          for (int i = 0;
                              i <
                                  QuranCubit.quranModel.chapters[textIndex]
                                      .versesCount;
                              i++) ...[
                            TextSpan(
                                text:
                                    QuranCubit.surahModel.verses[i].textUthmani,
                                style: Theme.of(context).textTheme.headline6),
                            TextSpan(
                              text: ArabicNumbers.toArabicNumbers('(${i + 1})'),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 126, 39, 7),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    );
            }))
          ],
        ),
      ),
    );
  }
}

class SurahAudio extends StatelessWidget {
  const SurahAudio({super.key, required this.audioIndex});
  final int audioIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<QuranCubit>(context)
        ..getAudio(audioIndex)
        ..updateDuration()
        ..updatePosition(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenWidth! * .02),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight! * .50,
                child: Card(
                  child: Center(
                      child: Text(
                    QuranCubit.quranModel.chapters[audioIndex - 1].nameArabic,
                    style: Theme.of(context).textTheme.headline6,
                    textScaleFactor: 3,
                  )),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .01,
              ),
              Text(
                'الشيخ/محمود خليل الحصرى',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .01,
              ),
              BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  return Slider.adaptive(
                      min: 0,
                      max: QuranCubit.audioDuration.inSeconds.toDouble(),
                      value: QuranCubit.audioPosition.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await QuranCubit.audioPlayer.seek(position);
                      });
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .005,
              ),
              BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(QuranCubit.getQuranCubit(context)
                          .formatTime(QuranCubit.audioPosition)),
                      Text(QuranCubit.getQuranCubit(context).formatTime(
                          QuranCubit.audioDuration - QuranCubit.audioPosition)),
                    ],
                  );
                },
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                child: BlocBuilder<QuranCubit, QuranState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () async =>
                            QuranCubit.getQuranCubit(context).audioPlaying(),
                        icon: QuranCubit.isAudioPlaying
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow));
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

class SurahImages extends StatelessWidget {
  const SurahImages({super.key, required this.pageNumber});
  final int pageNumber;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 605 - pageNumber,
      scrollDirection: Axis.vertical,
      itemBuilder: ((context, index) {
        return Image.asset(
          'assets/images/quran/${pageNumber + index}.png',
          fit: BoxFit.fill,
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
        );
      }),
      onPageChanged: (value) {
        int pageValue = pageNumber + value;
        QuranCubit.getQuranCubit(context).saveLastReadPage(pageValue);
      },
    );
  }
}
