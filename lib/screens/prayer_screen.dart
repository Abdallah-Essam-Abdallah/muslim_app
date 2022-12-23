import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geolocator/geolocator.dart';

import '../configs/arabic_numbers.dart';
import '../configs/size_config.dart';

import '../cubit/app_cubit/app_cubit.dart';
import '../cubit/prayer_cubit/prayer_cubit.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: ((context, state) {
      return AppCubit.permission == LocationPermission.denied ||
              AppCubit.permission == LocationPermission.deniedForever ||
              AppCubit.permission == LocationPermission.unableToDetermine
          ? const DisabledLocationWidget()
          : BlocProvider(
              create: (context) => PrayerCubit()..getPrayersTimes(),
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.screenWidth! * .02),
                child: BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    if (state is GetPrayersTimesLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is GetPrayersTimesSuccessState) {
                      return PrayerTimesWidget(
                        prayerTimes: state.prayerTimes,
                      );
                    } else {
                      return const OnErrorWidget();
                    }
                  },
                ),
              ),
            );
    }));
  }
}

class DisabledLocationWidget extends StatelessWidget {
  const DisabledLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_off,
          size: SizeConfig.screenHeight! * .35,
          color: Colors.red[900],
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * .01,
        ),
        Text(
          'خدمات الموقع لا تعمل',
          style: TextStyle(fontSize: SizeConfig.screenWidth! * .10),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * .15,
        ),
        SizedBox(
            height: SizeConfig.screenHeight! * .06,
            width: SizeConfig.screenWidth! * .50,
            child: ElevatedButton(
                onPressed: () async => await AppCubit.getAppCubit(context)
                    .determinePosition(context),
                child: const Text(
                  'حاول مره اخرى',
                  textDirection: TextDirection.rtl,
                  textScaleFactor: 1.5,
                )))
      ],
    ));
  }
}

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key, required this.prayerTimes});
  final List<String> prayerTimes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.screenHeight! * .25,
            decoration: const BoxDecoration(
                color: Color.fromARGB(179, 141, 152, 158),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage('assets/images/mosque.png'),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  PrayerCubit.model!.data.date.hijri.weekday.ar,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ArabicNumbers.toArabicNumbers(
                          PrayerCubit.model!.data.date.hijri.year),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      PrayerCubit.model!.data.date.hijri.month.ar,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                        ArabicNumbers.toArabicNumbers(
                            PrayerCubit.model!.data.date.hijri.day),
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * .03),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) => BlocBuilder<AppCubit, AppState>(
                      buildWhen: (previousState, currentState) {
                    return previousState == currentState &&
                        currentState == ChangeThemeModeState();
                  }, builder: ((context, state) {
                    return Container(
                      height: SizeConfig.screenHeight! * .10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: AppCubit.isDark
                                ? const [
                                    Color.fromARGB(172, 52, 66, 73),
                                    Color.fromARGB(255, 59, 76, 83),
                                  ]
                                : const [
                                    Colors.teal,
                                    Color.fromARGB(255, 3, 122, 96),
                                  ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            ArabicNumbers.toArabicNumbers(prayerTimes[index]),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          FaIcon(
                            PrayerCubit.prayerIcons[index],
                            color: Colors.white,
                          ),
                          Text(
                            PrayerCubit.prayersNames[index],
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    );
                  }))),
              separatorBuilder: ((context, index) => SizedBox(
                    height: SizeConfig.screenHeight! * .02,
                  )),
              itemCount: PrayerCubit.prayersNames.length),
        ],
      ),
    );
  }
}

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber,
            size: SizeConfig.screenHeight! * .35,
            color: Colors.amber,
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * .01,
          ),
          Text(
            'حدث خطاء ما',
            style: TextStyle(fontSize: SizeConfig.screenWidth! * .10),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * .15,
          ),
          SizedBox(
              height: SizeConfig.screenHeight! * .06,
              width: SizeConfig.screenWidth! * .50,
              child: ElevatedButton(
                  onPressed: () {
                    PrayerCubit.getPrayerCubit(context).getPrayersTimes();
                  },
                  child: const Text(
                    'حاول مره اخرى',
                    textDirection: TextDirection.rtl,
                    textScaleFactor: 1.5,
                  )))
        ],
      ),
    );
  }
}
