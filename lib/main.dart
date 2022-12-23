import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/configs/app_themes.dart';
import 'package:muslim_app/cubit/internet_cubit/internet_cubit.dart';
import 'package:muslim_app/cubit/quran_cubit/quran_cubit.dart';
import 'package:muslim_app/services/dio_client.dart';
import 'package:muslim_app/screens/splash_screen.dart';
import 'services/cache_helper.dart';
import 'cubit/app_cubit/app_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioClient.init();
  await CacheHelper.sharedInit();
  bool? isDdark = CacheHelper.getBoolean(key: 'isDark') ?? false;

  runApp(MyApp(
    iSDark: isDdark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.iSDark});
  final bool iSDark;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()..toggleTheme(themeMode: iSDark)),
        BlocProvider(
          create: (context) => InternetCubit()..checkInternetConnection(),
        ),
        BlocProvider(create: (context) => QuranCubit()..getQuranDetails()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppCubit.isDark ? darkTheme : lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
