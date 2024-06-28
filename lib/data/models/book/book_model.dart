class PaginateBookModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<BookModel>? results;

  PaginateBookModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginateBookModel.fromJson(Map<String, dynamic> json) => PaginateBookModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<BookModel>.from(
                json["results"]!.map((x) => BookModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class BookModel {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<dynamic>? translators;
  final List<String>? subjects;
  final List<dynamic>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;

  BookModel({
    this.id,
    this.title,
    this.authors,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json["title"],
        authors: json["authors"] == null ? [] : List<Author>.from(json["authors"]!.map((x) => Author.fromJson(x))),
        translators: json["translators"] == null ? [] : List<dynamic>.from(json["translators"]!.map((x) => x)),
        subjects: json["subjects"] == null ? [] : List<String>.from(json["subjects"]!.map((x) => x)),
        bookshelves: json["bookshelves"] == null ? [] : List<dynamic>.from(json["bookshelves"]!.map((x) => x)),
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": authors == null ? [] : List<dynamic>.from(authors!.map((x) => x.toJson())),
        "translators": translators == null ? [] : List<dynamic>.from(translators!.map((x) => x)),
        "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x)),
        "bookshelves": bookshelves == null ? [] : List<dynamic>.from(bookshelves!.map((x) => x)),
        "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats?.toJson(),
        "download_count": downloadCount,
      };
}

class Author {
  final String? name;
  final int? birthYear;
  final int? deathYear;

  Author({
    this.name,
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
  final String? textHtml;
  final String? applicationEpubZip;
  final String? applicationXMobipocketEbook;
  final String? applicationRdfXml;
  final String? imageJpeg;
  final String? textPlainCharsetUsAscii;
  final String? applicationOctetStream;

  Formats({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.applicationRdfXml,
    this.imageJpeg,
    this.textPlainCharsetUsAscii,
    this.applicationOctetStream,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        textHtml: json["text/html"],
        applicationEpubZip: json["application/epub+zip"],
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        applicationRdfXml: json["application/rdf+xml"],
        imageJpeg: json["image/jpeg"],
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
