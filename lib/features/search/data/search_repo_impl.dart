import 'package:easy_book/core/datasource/api_services.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/search/data/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiServices apiServices;

  SearchRepoImpl({required this.apiServices});
  @override
  Future<List<BookModel>> searchBook(String query) async {
    try {
      print('repoimpl${query}');
      var data = await apiServices.searchBook(query: query);

      // التحقق من صحة البيانات
      if (data == null || data['results'] == null) {
        print('Invalid response: data is null or missing results');
        return [];
      }

      List<BookModel> books = [];
      List<dynamic> results = data['results'];

      print('Results count: ${results.length}');

      // التحقق من وجود نتائج
      if (results.isNotEmpty) {
        for (var item in results) {
          try {
            // التحقق من صحة العنصر قبل تحويله
            if (item != null && item is Map<String, dynamic>) {
              books.add(BookModel.fromJson(item));
            } else {
              print('Invalid item format: $item');
            }
          } catch (e) {
            print('Error parsing book: $e');
            print('Problematic item: $item');
          }
        }
      }

      print('Final books count: ${books.length}');
      if (books.isNotEmpty) {
        print('First book title: ${books.first.title}');
      }
      return books;
    } catch (e) {
      print('Error in searchBook: $e');
      return [];
    }
  }
}
