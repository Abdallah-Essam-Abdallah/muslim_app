import 'dart:convert';

QuranModel quranModelFromJson(String str) =>
    QuranModel.fromJson(json.decode(str));

String quranModelToJson(QuranModel data) => json.encode(data.toJson());

class QuranModel {
  QuranModel({
    required this.chapters,
  });

  List<Chapter> chapters;

  factory QuranModel.fromJson(Map<String, dynamic> json) => QuranModel(
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  Chapter({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });

  int id;
  RevelationPlace? revelationPlace;
  int revelationOrder;
  bool bismillahPre;
  String nameSimple;
  String nameComplex;
  String nameArabic;
  int versesCount;
  List<int> pages;
  TranslatedName translatedName;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        revelationPlace: revelationPlaceValues.map[json["revelation_place"]],
        revelationOrder: json["revelation_order"],
        bismillahPre: json["bismillah_pre"],
        nameSimple: json["name_simple"],
        nameComplex: json["name_complex"],
        nameArabic: json["name_arabic"],
        versesCount: json["verses_count"],
        pages: List<int>.from(json["pages"].map((x) => x)),
        translatedName: TranslatedName.fromJson(json["translated_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "revelation_place": revelationPlaceValues.reverse[revelationPlace],
        "revelation_order": revelationOrder,
        "bismillah_pre": bismillahPre,
        "name_simple": nameSimple,
        "name_complex": nameComplex,
        "name_arabic": nameArabic,
        "verses_count": versesCount,
        "pages": List<dynamic>.from(pages.map((x) => x)),
        "translated_name": translatedName.toJson(),
      };
}

enum RevelationPlace { makkah, madinah }

final revelationPlaceValues = EnumValues(
    {"madinah": RevelationPlace.madinah, "makkah": RevelationPlace.makkah});

class TranslatedName {
  TranslatedName({
    required this.languageName,
    required this.name,
  });

  LanguageName? languageName;
  String name;

  factory TranslatedName.fromJson(Map<String, dynamic> json) => TranslatedName(
        languageName: languageNameValues.map[json["language_name"]],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language_name": languageNameValues.reverse[languageName],
        "name": name,
      };
}

enum LanguageName { english }

final languageNameValues = EnumValues({"english": LanguageName.english});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
