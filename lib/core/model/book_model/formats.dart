import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'formats.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Formats extends Equatable {
  @HiveField(0)
  final String? textHtml;

  @HiveField(1)
  final String? applicationEpubZip;

  @HiveField(2)
  final String? applicationXMobipocketEbook;

  @HiveField(3)
  final String? textPlainCharsetUsAscii;

  @HiveField(4)
  final String? applicationRdfXml;

  @HiveField(5)
  final String? imageJpeg;

  @HiveField(6)
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

  factory Formats.fromJson(Map<String, dynamic> json) => _$FormatsFromJson(json);

  Map<String, dynamic> toJson() => _$FormatsToJson(this);

  @override
  List<Object?> get props => [
    textHtml,
    applicationEpubZip,
    applicationXMobipocketEbook,
    textPlainCharsetUsAscii,
    applicationRdfXml,
    imageJpeg,
    applicationOctetStream,
  ];
}
