import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:hive/hive.dart';

class LibraryLocalDataSource {
  final Box libraryBox;

  LibraryLocalDataSource({required this.libraryBox});

  Future<void> addBook(LibraryModel book) async {
    List<LibraryModel> currentBooks = await getCachedLibrary();

    // نتحقق هل الكتاب موجود مسبقًا
    final existingIndex = currentBooks.indexWhere((b) => b.id == book.id);
    if (existingIndex != -1) {
      currentBooks[existingIndex] = book; // تحديث الكتاب
    } else {
      currentBooks.add(book); // إضافة جديد
    }

    await libraryBox.put(
      'library_books',
      currentBooks.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> addBooks(List<LibraryModel> books) async {
    await libraryBox.put(
      'library_books',
      books.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<LibraryModel>> getCachedLibrary() async {
    final data = libraryBox.get('library_books') ?? [];

    return (data as List).map((e) {
      final Map<String, dynamic> converted = {};
      (e as Map).forEach((key, value) {
        converted[key.toString()] = value;
      });
      return LibraryModel.fromJson(converted);
    }).toList();
  }
}
