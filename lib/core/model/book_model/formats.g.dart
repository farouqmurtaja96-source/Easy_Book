// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormatsAdapter extends TypeAdapter<Formats> {
  @override
  final int typeId = 3;

  @override
  Formats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Formats(
      textHtml: fields[0] as String?,
      applicationEpubZip: fields[1] as String?,
      applicationXMobipocketEbook: fields[2] as String?,
      textPlainCharsetUsAscii: fields[3] as String?,
      applicationRdfXml: fields[4] as String?,
      imageJpeg: fields[5] as String?,
      applicationOctetStream: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Formats obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.textHtml)
      ..writeByte(1)
      ..write(obj.applicationEpubZip)
      ..writeByte(2)
      ..write(obj.applicationXMobipocketEbook)
      ..writeByte(3)
      ..write(obj.textPlainCharsetUsAscii)
      ..writeByte(4)
      ..write(obj.applicationRdfXml)
      ..writeByte(5)
      ..write(obj.imageJpeg)
      ..writeByte(6)
      ..write(obj.applicationOctetStream);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Formats _$FormatsFromJson(Map<String, dynamic> json) => Formats(
      textHtml: json['textHtml'] as String?,
      applicationEpubZip: json['applicationEpubZip'] as String?,
      applicationXMobipocketEbook:
          json['applicationXMobipocketEbook'] as String?,
      textPlainCharsetUsAscii: json['textPlainCharsetUsAscii'] as String?,
      applicationRdfXml: json['applicationRdfXml'] as String?,
      imageJpeg: json['imageJpeg'] as String?,
      applicationOctetStream: json['applicationOctetStream'] as String?,
    );

Map<String, dynamic> _$FormatsToJson(Formats instance) => <String, dynamic>{
      'textHtml': instance.textHtml,
      'applicationEpubZip': instance.applicationEpubZip,
      'applicationXMobipocketEbook': instance.applicationXMobipocketEbook,
      'textPlainCharsetUsAscii': instance.textPlainCharsetUsAscii,
      'applicationRdfXml': instance.applicationRdfXml,
      'imageJpeg': instance.imageJpeg,
      'applicationOctetStream': instance.applicationOctetStream,
    };
