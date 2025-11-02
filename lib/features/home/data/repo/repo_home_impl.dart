import 'package:dartz/dartz.dart';
import 'package:easy_book/core/error/failures.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/home/data/repo/repo_home.dart';

class RepoHomeImpl implements RepoHome {
  @override
  Future<Either<Failures, List<BookModel>>> getBooks() {}
}
