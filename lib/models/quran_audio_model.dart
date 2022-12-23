import 'dart:convert';

AudioModel audioModelFromJson(String str) =>
    AudioModel.fromJson(json.decode(str));

String audioModelToJson(AudioModel data) => json.encode(data.toJson());

class AudioModel {
  AudioModel({
    required this.audioFile,
  });

  AudioFile audioFile;

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        audioFile: AudioFile.fromJson(json["audio_file"]),
      );

  Map<String, dynamic> toJson() => {
        "audio_file": audioFile.toJson(),
      };
}

class AudioFile {
  AudioFile({
    required this.id,
    required this.chapterId,
    this.fileSize,
    required this.format,
    required this.audioUrl,
  });

  int id;
  int chapterId;
  dynamic fileSize;
  String format;
  String audioUrl;

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        id: json["id"],
        chapterId: json["chapter_id"],
        fileSize: json["file_size"],
        format: json["format"],
        audioUrl: json["audio_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_id": chapterId,
        "file_size": fileSize,
        "format": format,
        "audio_url": audioUrl,
      };
}
