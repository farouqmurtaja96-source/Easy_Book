import 'package:easy_book/features/library/data/local_data_source/library_local_data_source.dart';
import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:easy_book/features/library/data/repo/library_repo.dart';

class LibraryRepoImplt implements LibraryRepo {
  final LibraryLocalDataSource localDataSource;

  LibraryRepoImplt({required this.localDataSource});

  @override
  Future<void> addBook({required LibraryModel book}) async {
    await localDataSource.addBook(book);
  }

  @override
  Future<void> addBookList({required List<LibraryModel> books}) async {
    await localDataSource.addBooks(books);
  }

  @override
  Future<List<LibraryModel>> getBook() async {
    return await localDataSource.getCachedLibrary();
  }
}
