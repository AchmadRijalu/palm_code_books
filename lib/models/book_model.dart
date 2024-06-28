import 'dart:convert';

class BooksModel {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  BooksModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BooksModel.fromRawJson(String str) =>
      BooksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  String title;
  List<Author> authors;
  List<Author> translators;
  List<String> subjects;
  List<String> bookshelves;
  List<Language> languages;
  bool copyright;
  MediaType? mediaType;
  Formats? formats;
  int? downloadCount;

  Result({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        translators: List<Author>.from(
            json["translators"].map((x) => Author.fromJson(x))),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
        languages: List<Language>.from(
            json["languages"].map((x) => languageValues.map[x])),
        copyright: json["copyright"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        formats: Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "translators": List<dynamic>.from(translators.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages":
            List<dynamic>.from(languages.map((x) => languageValues.reverse[x])),
        "copyright": copyright,
        "media_type": mediaTypeValues.reverse[mediaType],
        "formats": formats!.toJson(),
        "download_count": downloadCount,
      };

  factory Result.fromDatabaseJson(Map<String, dynamic> json) {
    List<Language> parseLanguages(dynamic list) {
      if (list is List) {
        return list.map((e) => languageValues.map[e] ?? Language.EN).toList();
      } else {
        return [];
      }
    }

    return Result(
      id: json["id"],
      title: json["title"],
      authors: json["authors"] != null
          ? List<Author>.from(
              jsonDecode(json["authors"]).map((x) => Author.fromJson(x)))
          : [],
      translators: json["translators"] != null
          ? List<Author>.from(
              jsonDecode(json["translators"]).map((x) => Author.fromJson(x)))
          : [],
      subjects: json["subjects"] != null
          ? List<String>.from(
              jsonDecode(json["subjects"]).map((x) => x as String))
          : [],
      bookshelves: json["bookshelves"] != null
          ? List<String>.from(
              jsonDecode(json["bookshelves"]).map((x) => x as String))
          : [],
      languages:
          json["languages"] != null ? parseLanguages(json["languages"]) : [],
      copyright: json["copyright"] == 1,
      mediaType: json["media_type"] != null
          ? mediaTypeValues.map[json["media_type"]] ?? MediaType.TEXT
          : MediaType.TEXT,
      formats: json["formats"] != null
          ? Formats.fromJson(jsonDecode(json["formats"]))
          : Formats(
              textHtml: '',
              applicationEpubZip: '',
              applicationXMobipocketEbook: '',
              applicationRdfXml: '',
              imageJpeg: '',
              textPlainCharsetUsAscii: '',
              applicationOctetStream: '',
            ),
      downloadCount: json["download_count"],
    );
  }
}

class Author {
  String name;
  int? birthYear;
  int? deathYear;

  Author({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
      };
}

class Formats {
  String textHtml;
  String applicationEpubZip;
  String applicationXMobipocketEbook;
  String applicationRdfXml;
  String imageJpeg;
  String textPlainCharsetUsAscii;
  String applicationOctetStream;
  String? textHtmlCharsetUtf8;
  String? textPlainCharsetUtf8;
  String? textPlainCharsetIso88591;
  String? textHtmlCharsetIso88591;

  Formats({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationXMobipocketEbook,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.textPlainCharsetUsAscii,
    required this.applicationOctetStream,
    this.textHtmlCharsetUtf8,
    this.textPlainCharsetUtf8,
    this.textPlainCharsetIso88591,
    this.textHtmlCharsetIso88591,
  });

  factory Formats.fromRawJson(String str) => Formats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        textHtml: json["text/html"] ?? '',
        applicationEpubZip: json["application/epub+zip"] ?? '',
        applicationXMobipocketEbook:
            json["application/x-mobipocket-ebook"] ?? '',
        applicationRdfXml: json["application/rdf+xml"] ?? '',
        imageJpeg: json["image/jpeg"] ?? '',
        textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"] ?? '',
        applicationOctetStream: json["application/octet-stream"] ?? '',
        textHtmlCharsetUtf8: json["text/html; charset=utf-8"],
        textPlainCharsetUtf8: json["text/plain; charset=utf-8"],
        textPlainCharsetIso88591: json["text/plain; charset=iso-8859-1"],
        textHtmlCharsetIso88591: json["text/html; charset=iso-8859-1"],
      );

  Map<String, dynamic> toJson() => {
        "text/html": textHtml,
        "application/epub+zip": applicationEpubZip,
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/rdf+xml": applicationRdfXml,
        "image/jpeg": imageJpeg,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
        "application/octet-stream": applicationOctetStream,
        "text/html; charset=utf-8": textHtmlCharsetUtf8,
        "text/plain; charset=utf-8": textPlainCharsetUtf8,
        "text/plain; charset=iso-8859-1": textPlainCharsetIso88591,
        "text/html; charset=iso-8859-1": textHtmlCharsetIso88591,
      };
}

enum Language { EN, ES }

final languageValues = EnumValues({"en": Language.EN, "es": Language.ES});

enum MediaType { TEXT }

final mediaTypeValues = EnumValues({"Text": MediaType.TEXT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
