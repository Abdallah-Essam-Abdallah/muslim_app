part of 'quran_cubit.dart';

@immutable
abstract class QuranState {}

class QuranInitial extends QuranState {}

class GetQuranDetailsLoadingState extends QuranState {}

class GetQuranDetailsSuccessState extends QuranState {}

class GetQuranDetailsErrorState extends QuranState {}

class GetSurahLoadingState extends QuranState {}

class GetSurahSuccessState extends QuranState {}

class GetSurahErrorState extends QuranState {}

class SaveLastReadState extends QuranState {}

class GetAudioLoadingState extends QuranState {}

class GetAudioSuccessState extends QuranState {}

class GetAudioErrorState extends QuranState {}

class AudioPlayingState extends QuranState {}

class UpdateAudioDurationState extends QuranState {}

class UpdateAudioPositionState extends QuranState {}
