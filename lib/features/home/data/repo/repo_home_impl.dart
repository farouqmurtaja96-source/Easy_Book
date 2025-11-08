import 'package:dartz/dartz.dart';
import 'package:easy_book/core/datasource/api_services.dart';
import 'package:easy_book/core/error/failures.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/home/data/repo/repo_home.dart';
import 'package:hive/hive.dart';

class RepoHomeImpl implements RepoHome {
  final ApiServices apiServices;
  final Box homeCachedBox;
  RepoHomeImpl({required this.homeCachedBox, required this.apiServices});
  @override
  Future<Either<Failures, List<BookModel>>> getBooksPopular({
    String? topic,
  }) async {
    List<BookModel> books = [];
    final cached = homeCachedBox.get('popular_books$topic');
    if (cached != null) {
      books = (cached as List)
          .map((e) => BookModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    try {
      final data = await apiServices.getBooks(
        sort: '&sort=popular',
        topic: '&topic=$topic',
      );
      // for (var itme in data['results']) {
      //   books.add(BookModel.fromJson(itme));
      // }
      final List dataList = data['results'];
      final fresh = dataList.map((e) => BookModel.fromJson(e)).toList();
      await homeCachedBox.put(
        'popular_books$topic',
        fresh.map((e) => e.toJson()).toList(),
      );
      books = fresh;
      return Right(books);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<List<BookModel>> getCachedPopularBooks({String? topic}) async {
    List<BookModel> books = [];
    final cached = homeCachedBox.get('popular_books$topic');
    if (cached != null) {
      books = (cached as List)
          .map((e) => BookModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return books;
  }

  @override
  Future<Either<Failures, List<BookModel>>> getBooksNewest({
    String? topic = 'all',
  }) async {
    List<BookModel> books = [];
    final cached = homeCachedBox.get('newest_books$topic');
    if (cached != null) {
      books = (cached as List)
          .map((e) => BookModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    try {
      final data = await apiServices.getBooks(
        sort: '&sort=ascending',
        topic: '&topic=$topic',
      );
      final List dataList = data['results'];
      final fresh = dataList.map((e) => BookModel.fromJson(e)).toList();
      await homeCachedBox.put(
        'newest_books$topic',
        fresh.map((e) => e.toJson()).toList(),
      );
      books = fresh;
      return Right(books);
    } catch (e) {
      if (books.isNotEmpty) {
        return Right(books);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<List<BookModel>> getCachedNewestBooks({String? topic = 'all'}) async {
    List<BookModel> books = [];
    final cached = homeCachedBox.get('newest_books$topic');
    if (cached != null) {
      books = (cached as List)
          .map((e) => BookModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return books;
  }
}
