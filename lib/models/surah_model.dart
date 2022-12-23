import 'dart:convert';

SurahModel surahModelFromJson(String str) =>
    SurahModel.fromJson(json.decode(str));

String surahModelToJson(SurahModel data) => json.encode(data.toJson());

class SurahModel {
  SurahModel({
    required this.verses,
    required this.meta,
  });

  List<Verse> verses;
  Meta meta;

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        verses: List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Meta {
  Meta({
    required this.filters,
  });

  Filters filters;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        filters: Filters.fromJson(json["filters"]),
      );

  Map<String, dynamic> toJson() => {
        "filters": filters.toJson(),
      };
}

class Filters {
  Filters({
    required this.chapterNumber,
  });

  String chapterNumber;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        chapterNumber: json["chapter_number"],
      );

  Map<String, dynamic> toJson() => {
        "chapter_number": chapterNumber,
      };
}

class Verse {
  Verse({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
  });

  int id;
  String verseKey;
  String textUthmani;

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json["id"],
        verseKey: json["verse_key"],
        textUthmani: json["text_uthmani"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "verse_key": verseKey,
        "text_uthmani": textUthmani,
      };
}
