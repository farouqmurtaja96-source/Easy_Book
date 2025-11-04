import 'package:equatable/equatable.dart';

class Editors extends Equatable {
  final String? name;
  final int? birthyear;
  final int? deathyear;

  const Editors({
    required this.name,
    required this.birthyear,
    required this.deathyear,
  });
  factory Editors.fromJson(Map<String, dynamic> json) {
    return Editors(
      name: json['name'] as String?,
      birthyear: json['birth_year'] as int?,
      deathyear: json['death_year'] as int?,
    );
  }

  @override
  List<Object?> get props => [name, birthyear, deathyear];
}
