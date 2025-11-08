import 'package:easy_book/core/model/book_model/editors.dart';

import 'package:equatable/equatable.dart';

import 'author.dart';
import 'formats.dart';

class BookModel extends Equatable {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<String>? summaries;
  final List<Editors>? editors;
  final List<dynamic>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;

  const BookModel({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.editors,
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
    id: json['id'] as int?,
    title: json['title'] as String?,
    authors: (json['authors'] as List<dynamic>?)
        ?.map((e) {
          // تحويل Map<dynamic, dynamic> إلى Map<String, dynamic>
          final Map<String, dynamic> authorMap = {};
          if (e is Map) {
            e.forEach((key, value) {
              authorMap[key.toString()] = value;
            });
          }
          return Author.fromJson(authorMap);
        })
        .toList(),
    summaries: (json['summaries'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    editors: (json['editors'] as List<dynamic>?)
        ?.map((e) {
          // تحويل Map<dynamic, dynamic> إلى Map<String, dynamic>
          final Map<String, dynamic> editorMap = {};
          if (e is Map) {
            e.forEach((key, value) {
              editorMap[key.toString()] = value;
            });
          }
          return Editors.fromJson(editorMap);
        })
        .toList(),
    translators: (json['translators'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    subjects: (json['subjects'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    bookshelves: (json['bookshelves'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    copyright: json['copyright'] as bool?,
    mediaType: json['media_type'] as String?,
    formats: json['formats'] == null
        ? null
        : (() {
            // تحويل Map<dynamic, dynamic> إلى Map<String, dynamic>
            final Map<String, dynamic> formatsMap = {};
            if (json['formats'] is Map) {
              (json['formats'] as Map).forEach((key, value) {
                // تحويل أسماء الحقول من شكل API إلى شكل النموذج
                final String keyStr = key.toString();
                if (keyStr == 'text/html') {
                  formatsMap['textHtml'] = value;
                } else if (keyStr == 'application/epub+zip') {
                  formatsMap['applicationEpubZip'] = value;
                } else if (keyStr == 'application/x-mobipocket-ebook') {
                  formatsMap['applicationXMobipocketEbook'] = value;
                } else if (keyStr == 'text/plain; charset=us-ascii') {
                  formatsMap['textPlainCharsetUsAscii'] = value;
                } else if (keyStr == 'application/rdf+xml') {
                  formatsMap['applicationRdfXml'] = value;
                } else if (keyStr == 'image/jpeg') {
                  formatsMap['imageJpeg'] = value;
                } else if (keyStr == 'application/octet-stream') {
                  formatsMap['applicationOctetStream'] = value;
                } else {
                  // الاحتفاظ بالمفتاح الأصلي إذا لم يكن من الحقول المعروفة
                  formatsMap[keyStr] = value;
                }
              });
            }
            return Formats.fromJson(formatsMap);
          })(),
    downloadCount: json['download_count'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'authors': authors?.map((e) => e.toJson()).toList(),
    'summaries': summaries,
    'editors': editors,
    'translators': translators,
    'subjects': subjects,
    'bookshelves': bookshelves,
    'languages': languages,
    'copyright': copyright,
    'media_type': mediaType,
    'formats': formats?.toJson(),
    'download_count': downloadCount,
  };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      authors,
      summaries,
      editors,
      translators,
      subjects,
      bookshelves,
      languages,
      copyright,
      mediaType,
      formats,
      downloadCount,
    ];
  }
}
