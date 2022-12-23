import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim_app/configs/constants.dart';

import 'package:muslim_app/screens/prayer_screen.dart';
import 'package:muslim_app/screens/home_screen.dart';

import 'package:muslim_app/screens/quran_screen.dart';

import '../../services/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit getAppCubit(context) => BlocProvider.of(context);

  static bool isDark = false;
  void toggleTheme({bool? themeMode}) {
    if (themeMode != null) {
      isDark = themeMode;
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }

  static late LocationPermission permission;
  static late Position position;
  static double latitude = position.latitude;
  static double longtiude = position.longitude;

  Future determinePosition(BuildContext context) async {
    emit(GetLocationInitialState());

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            emit(GetLocationErrorState());
            return const CustomDialog(
              'لم يتم الحصول على الاذن لاستخدام خدمات الموقع',
              'خدمات الموقع',
            );
          });
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      emit(GetLocationSuccessState());
      return await Geolocator.getCurrentPosition();
    }
  }

  static List screens = const [
    QuranScreen(),
    HomeScreen(),
    PrayerScreen(),
  ];

  static List<String> titels = const [
    'القران الكريم',
    'الرئيسيه',
    'مواقيت الصلاه'
  ];

  static int bnbIndex = 1;
  void changeBnbIndex(int index) {
    bnbIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
