import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:muslim_app/cubit/app_cubit/app_cubit.dart';
import 'package:muslim_app/services/dio_client.dart';

import '../../models/prayer_model.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());

  static PrayerCubit getPrayerCubit(context) => BlocProvider.of(context);

  static PrayersModel? model;

  static final List<String> prayersNames = [
    '  الفجر',
    'الظهر',
    'العصر',
    'المغرب',
    'العشاء'
  ];
  static final List prayerIcons = [
    FontAwesomeIcons.cloudMoon,
    FontAwesomeIcons.solidSun,
    FontAwesomeIcons.sun,
    FontAwesomeIcons.cloudSun,
    FontAwesomeIcons.moon
  ];
  void getPrayersTimes() async {
    try {
      emit(GetPrayersTimesLoadingState());
      var prayerResponse = await DioClient.getData(
          'http://api.aladhan.com/v1/timings?latitude=${AppCubit.latitude}&longitude=${AppCubit.longtiude}&method=5');
      model = PrayersModel.fromJson(prayerResponse.data);
      emit(GetPrayersTimesSuccessState([
        model!.data.timings.fajr,
        model!.data.timings.dhuhr,
        model!.data.timings.asr,
        model!.data.timings.maghrib,
        model!.data.timings.isha,
      ]));
    } catch (error) {
      emit(GetPrayersTimesErrorState());
    }
  }
}
