import 'package:dartz/dartz.dart';
import 'package:easy_book/core/error/failures.dart';

abstract class ReaderRepo {
  Future<Either<Failures, String>> getBookText(String bookUrl);
}
