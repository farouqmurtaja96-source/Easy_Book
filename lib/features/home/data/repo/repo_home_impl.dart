import 'package:dartz/dartz.dart';
import 'package:easy_book/core/datasource/api_services.dart';
import 'package:easy_book/core/error/failures.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/home/data/repo/repo_home.dart';

class RepoHomeImpl implements RepoHome {
  final ApiServices apiServices;

  RepoHomeImpl({required this.apiServices});
  @override
  Future<Either<Failures, List<BookModel>>> getBooksPopular({
    String? topic = 'all',
  }) async {
    try {
      var data = await apiServices.getBooks(
        sort: '&sort=popular',
        topic: '&topic=$topic',
      );
      List<BookModel> books = [];
      for (var item in data['results']) {
        books.add(BookModel.fromJson(item));
      }
      return Right(books);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> getBooksNewest({
    String? topic = 'all',
  }) async {
    try {
      var data = await apiServices.getBooks(
        sort: '&sort=ascending',
        topic: '&topic=$topic',
      );
      List<BookModel> books = [];
      for (var itme in data['results']) {
        books.add(BookModel.fromJson(itme));
      }
      return Right(books);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
