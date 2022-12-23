import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:muslim_app/models/quran_model.dart';
import 'package:muslim_app/models/surah_model.dart';

import '../../models/quran_audio_model.dart';
import '../../services/dio_client.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  static QuranCubit getQuranCubit(context) => BlocProvider.of(context);

  static late QuranModel quranModel;
  static late SurahModel surahModel;

  void getQuranDetails() async {
    try {
      emit(GetQuranDetailsLoadingState());
      var quranResponse = await DioClient.getData(
          'https://api.quran.com/api/v4/chapters?language=en');

      quranModel = QuranModel.fromJson(quranResponse.data);

      emit(GetQuranDetailsSuccessState());
    } catch (error) {
      emit(GetQuranDetailsErrorState());
    }
  }

  void getSurah(int index) async {
    try {
      emit(GetSurahLoadingState());
      var surahResponse = await DioClient.getData(
          'https://api.quran.com/api/v4/quran/verses/uthmani?chapter_number=$index');

      surahModel = SurahModel.fromJson(surahResponse.data);

      emit(GetSurahSuccessState());
    } catch (error) {
      emit(GetSurahErrorState());
    }
  }

  static int lastReadPage = 1;
  saveLastReadPage(int page) {
    lastReadPage = page;
    emit(SaveLastReadState());
  }

  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioModel? audioModel;
  static late String audioUrl;
  static bool isAudioPlaying = false;
  static Duration audioDuration = Duration.zero;
  static Duration audioPosition = Duration.zero;

  void getAudio(int id) async {
    try {
      emit(GetAudioLoadingState());
      var audioResponse = await DioClient.getData(
          'https://api.quran.com/api/v4/chapter_recitations/6/$id');

      audioModel = AudioModel.fromJson(audioResponse.data);
      audioUrl = audioModel!.audioFile.audioUrl;

      emit(GetAudioSuccessState());
    } catch (error) {
      emit(GetAudioErrorState());
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  audioPlaying() async {
    isAudioPlaying = !isAudioPlaying;

    isAudioPlaying
        ? await audioPlayer.play(UrlSource(audioUrl))
        : await audioPlayer.pause();

    emit(AudioPlayingState());
  }

  updateDuration() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      audioDuration = newDuration;
      emit(UpdateAudioDurationState());
    });
  }

  updatePosition() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      audioPosition = newPosition;
      emit(UpdateAudioPositionState());
    });
  }

  @override
  Future<void> close() {
    AudioPlayer().dispose();
    return super.close();
  }
}
