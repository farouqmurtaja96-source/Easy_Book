// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editors.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EditorsAdapter extends TypeAdapter<Editors> {
  @override
  final int typeId = 2;

  @override
  Editors read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Editors(
      name: fields[0] as String?,
      birthyear: fields[1] as int?,
      deathyear: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Editors obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthyear)
      ..writeByte(2)
      ..write(obj.deathyear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditorsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Editors _$EditorsFromJson(Map<String, dynamic> json) => Editors(
      name: json['name'] as String?,
      birthyear: (json['birthyear'] as num?)?.toInt(),
      deathyear: (json['deathyear'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EditorsToJson(Editors instance) => <String, dynamic>{
      'name': instance.name,
      'birthyear': instance.birthyear,
      'deathyear': instance.deathyear,
    };
