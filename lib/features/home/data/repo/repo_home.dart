import 'package:dartz/dartz.dart';
import 'package:easy_book/core/error/failures.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';

abstract class RepoHome {
  Future<Either<Failures, List<BookModel>>> getBooksPopular({String? topic});
  Future<Either<Failures, List<BookModel>>> getBooksNewest({
    String? topic = 'all',
  });
  Future<List<BookModel>> getCachedNewestBooks({String? topic});
  Future<List<BookModel>> getCachedPopularBooks({String? topic});
}
