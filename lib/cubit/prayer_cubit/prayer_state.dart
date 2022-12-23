part of 'prayer_cubit.dart';

@immutable
abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class GetPrayersTimesLoadingState extends PrayerState {}

class GetPrayersTimesSuccessState extends PrayerState {
  final List<String> prayerTimes;

  GetPrayersTimesSuccessState(this.prayerTimes);
}

class GetPrayersTimesErrorState extends PrayerState {}
