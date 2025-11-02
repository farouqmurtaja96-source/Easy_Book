import 'package:equatable/equatable.dart';

class Formats extends Equatable {
  final String? textHtml;
  final String? applicationEpubZip;
  final String? applicationXMobipocketEbook;
  final String? textPlainCharsetUsAscii;
  final String? applicationRdfXml;
  final String? imageJpeg;
  final String? applicationOctetStream;

  const Formats({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.textPlainCharsetUsAscii,
    this.applicationRdfXml,
    this.imageJpeg,
    this.applicationOctetStream,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    textHtml: json['text/html'] as String?,
    applicationEpubZip: json['application/epub+zip'] as String?,
    applicationXMobipocketEbook:
        json['application/x-mobipocket-ebook'] as String?,
    textPlainCharsetUsAscii: json['text/plain; charset=us-ascii'] as String?,
    applicationRdfXml: json['application/rdf+xml'] as String?,
    imageJpeg: json['image/jpeg'] as String?,
    applicationOctetStream: json['application/octet-stream'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'text/html': textHtml,
    'application/epub+zip': applicationEpubZip,
    'application/x-mobipocket-ebook': applicationXMobipocketEbook,
    'text/plain; charset=us-ascii': textPlainCharsetUsAscii,
    'application/rdf+xml': applicationRdfXml,
    'image/jpeg': imageJpeg,
    'application/octet-stream': applicationOctetStream,
  };

  @override
  List<Object?> get props {
    return [
      textHtml,
      applicationEpubZip,
      applicationXMobipocketEbook,
      textPlainCharsetUsAscii,
      applicationRdfXml,
      imageJpeg,
      applicationOctetStream,
    ];
  }
}
