import 'package:equatable/equatable.dart';

import 'author.dart';
import 'formats.dart';

class BookModel extends Equatable {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<String>? summaries;
  final List<dynamic>? editors;
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
        ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
        .toList(),
    summaries: (json['summaries'] as List<dynamic>?)?.cast<String>(),
    editors: (json['editors'] as List<dynamic>?)?.cast<String>(),
    translators: (json['translators'] as List<dynamic>?)?.cast<String>(),
    subjects: (json['subjects'] as List<dynamic>?)?.cast<String>(),
    bookshelves: (json['bookshelves'] as List<dynamic>?)?.cast<String>(),
    languages: (json['languages'] as List<dynamic>?)?.cast<String>(),
    copyright: json['copyright'] as bool?,
    mediaType: json['media_type'] as String?,
    formats: json['formats'] == null
        ? null
        : Formats.fromJson(json['formats'] as Map<String, dynamic>),
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
