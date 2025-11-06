import 'package:easy_book/core/model/book_model/book_model.dart';

abstract class SearchRepo {
  Future<List<BookModel>> searchBook(String query);
}
