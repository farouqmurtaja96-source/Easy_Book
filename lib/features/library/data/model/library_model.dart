class LibraryModel {
  final int id;
  final String name;
  final String image;
  final String author;
  final double progress;
  final double readingHours;
  LibraryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.author,
    required this.progress,
    required this.readingHours,
  });

  factory LibraryModel.fromJson(Map<String, dynamic> json) => LibraryModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    author: json['author'],
    progress: (json['progress'] ?? 0.0).toDouble(),
    readingHours: (json['readingHours'] ?? 0.0).toDouble(),
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'author': author,
      'progress': progress,
      'readingHours': readingHours,
    };
  }
}
