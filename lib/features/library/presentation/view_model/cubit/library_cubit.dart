import 'package:bloc/bloc.dart';
import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:easy_book/features/library/data/repo/library_repo.dart';
import 'package:equatable/equatable.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this.libraryRepo) : super(LibraryInitial());

  final LibraryRepo libraryRepo;
  Future<void> getBooks() async {
    emit(LibraryLoading());
    try {
      final books = await libraryRepo.getBook();
      emit(LibrarySuccess(books: books));
    } catch (e) {
      emit(LibraryError(message: e.toString()));
    }
  }

  Future<void> addBook(LibraryModel book) async {
    try {
      await libraryRepo.addBook(book: book);
      // بعد الإضافة، نعيد جلب القائمة لتحديث الشاشة
      await getBooks();
    } catch (e) {
      emit(LibraryError(message: e.toString()));
    }
  }

  Future<void> updateProgress(int bookId, double newProgress) async {
    try {
      final books = await libraryRepo.getBook();
      final updatedBooks = books.map((book) {
        if (book.id == bookId) {
          return LibraryModel(
            id: book.id,
            name: book.name,
            image: book.image,
            author: book.author,
            progress: newProgress,
            readingHours: book.readingHours,
          );
        }
        return book;
      }).toList();

      await libraryRepo.addBookList(books: updatedBooks);
      emit(LibrarySuccess(books: updatedBooks));
    } catch (e) {
      emit(LibraryError(message: e.toString()));
    }
  }

  Future<void> updateReadingHours(int bookId, double hoursToAdd) async {
    try {
      final books = await libraryRepo.getBook();
      final updatedBooks = books.map((book) {
        if (book.id == bookId) {
          return LibraryModel(
            id: book.id,
            name: book.name,
            image: book.image,
            author: book.author,
            progress: book.progress,
            readingHours: book.readingHours + hoursToAdd,
          );
        }
        return book;
      }).toList();

      await libraryRepo.addBookList(books: updatedBooks);
      emit(LibrarySuccess(books: updatedBooks));
    } catch (e) {
      emit(LibraryError(message: e.toString()));
    }
  }
}
