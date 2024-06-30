import 'dart:convert';

class DetailBooksModel {
  int id;
  String title;
  List<Author> authors;
  List<dynamic> translators;
  List<String> subjects;
  List<dynamic> bookshelves;
  List<String> languages;
  bool copyright;
  String mediaType;
  Formats formats;
  int downloadCount;

  DetailBooksModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory DetailBooksModel.fromRawJson(String str) =>
      DetailBooksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailBooksModel.fromJson(Map<String, dynamic> json) =>
      DetailBooksModel(
        id: json["id"],
        title: json["title"],
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        translators: List<dynamic>.from(json["translators"].map((x) => x)),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        bookshelves: List<dynamic>.from(json["bookshelves"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "translators": List<dynamic>.from(translators.map((x) => x)),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats.toJson(),
        "download_count": downloadCount,
      };
}

class Author {
  String name;
  int birthYear;
  int deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
  String? textHtml;
  String? applicationEpubZip;
  String? applicationXMobipocketEbook;
  String? applicationRdfXml;
  String? imageJpeg;
  String? textPlainCharsetUsAscii;
  String? applicationOctetStream;

  Formats({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationXMobipocketEbook,
    required this.applicationRdfXml,
    this.imageJpeg,
    required this.textPlainCharsetUsAscii,
    required this.applicationOctetStream,
  });

  factory Formats.fromRawJson(String str) => Formats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        textHtml: json["text/html"],
        applicationEpubZip: json["application/epub+zip"],
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        applicationRdfXml: json["application/rdf+xml"],
        imageJpeg: json["image/jpeg"] != null ? json["image/jpeg"] : '',
        textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
        applicationOctetStream: json["application/octet-stream"],
      );

  Map<String, dynamic> toJson() => {
        "text/html": textHtml,
        "application/epub+zip": applicationEpubZip,
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/rdf+xml": applicationRdfXml,
        "image/jpeg": imageJpeg,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
        "application/octet-stream": applicationOctetStream,
      };
}
