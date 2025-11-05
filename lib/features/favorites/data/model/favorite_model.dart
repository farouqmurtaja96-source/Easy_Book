import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final int id;
  final String title;
  final String author;
  final String img;
  final List<String> summaries;
  final String textPlainCharsetUsAscii;

  const FavoriteModel({
    required this.summaries,
    required this.textPlainCharsetUsAscii,
    required this.id,
    required this.title,
    required this.author,
    required this.img,
  });

  @override
  List<Object> get props => [id, title, author, img];

  factory FavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    return FavoriteModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      img: json['img'] ?? '',
      summaries: (json['summaries'] as List<dynamic>).cast<String>(),
      textPlainCharsetUsAscii: json['textPlainCharsetUsAscii'] ?? '',
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'img': img,
      'summaries': summaries,
      'textPlainCharsetUsAscii': textPlainCharsetUsAscii,
    };
  }
}
