import 'package:easy_book/features/library/data/model/library_model.dart';

abstract class LibraryRepo {
  Future<void> addBook({required LibraryModel book});
  Future<void> addBookList({required List<LibraryModel> books});
  Future<List<LibraryModel>> getBook();
}
