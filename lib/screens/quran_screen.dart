import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/configs/arabic_numbers.dart';

import 'package:muslim_app/cubit/app_cubit/app_cubit.dart';

import 'package:muslim_app/cubit/quran_cubit/quran_cubit.dart';
import 'package:muslim_app/screens/surah_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return state is GetQuranDetailsLoadingState
            ? const Center(child: CircularProgressIndicator.adaptive())
            : const QuranDetailsWidget();
      },
    );
  }
}

class QuranDetailsWidget extends StatelessWidget {
  const QuranDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: QuranCubit.quranModel.chapters.length,
      itemBuilder: ((context, index) {
        return BlocBuilder<AppCubit, AppState>(
            buildWhen: (previousState, currentState) {
              return previousState == currentState &&
                  currentState == ChangeThemeModeState();
            },
            builder: ((context, state) => ListTile(
                trailing: Text(
                  ArabicNumbers.toArabicNumbers(
                      QuranCubit.quranModel.chapters[index].id.toString()),
                  style: Theme.of(context).textTheme.headline6,
                  textScaleFactor: 1.3,
                ),
                title: Text(
                  QuranCubit.quranModel.chapters[index].nameArabic,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  ('عدد اياتها : ${ArabicNumbers.toArabicNumbers(QuranCubit.quranModel.chapters[index].versesCount.toString())}'),
                  textAlign: TextAlign.right,
                ),
                onTap: () {
                  QuranCubit.getQuranCubit(context)
                      .getSurah(QuranCubit.quranModel.chapters[index].id);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SurahScreen(
                            surahindex: index,
                            audioindex:
                                QuranCubit.quranModel.chapters[index].id,
                            imageIndex:
                                QuranCubit.quranModel.chapters[index].pages[0],
                          ))));
                })));
      }),
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
