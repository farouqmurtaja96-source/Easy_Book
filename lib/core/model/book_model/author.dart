import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@HiveType(typeId: 1) // unique typeId
@JsonSerializable()
class Author extends Equatable {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final int? birthYear;

  @HiveField(2)
  final int? deathYear;

  @HiveField(3)
  final String? imageUrl;

  const Author({this.name, this.birthYear, this.deathYear, this.imageUrl});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  List<Object?> get props => [name, birthYear, deathYear, imageUrl];
}
