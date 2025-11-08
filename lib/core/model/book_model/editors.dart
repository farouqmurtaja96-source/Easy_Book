import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'editors.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Editors extends Equatable {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final int? birthyear;

  @HiveField(2)
  final int? deathyear;

  const Editors({this.name, this.birthyear, this.deathyear});

  factory Editors.fromJson(Map<String, dynamic> json) => _$EditorsFromJson(json);

  Map<String, dynamic> toJson() => _$EditorsToJson(this);

  @override
  List<Object?> get props => [name, birthyear, deathyear];
}
