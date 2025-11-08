import 'package:bloc/bloc.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/home/data/repo/repo_home.dart';
import 'package:equatable/equatable.dart';

part 'get_books_newest_state.dart';

class GetBooksNewestCubit extends Cubit<GetBooksNewestState> {
  GetBooksNewestCubit(this.repoHome) : super(GetBooksNewestInitial());
  final RepoHome repoHome;
  Future<void> getBooksNewest({String? topic}) async {
    // عرض حالة التحميل فقط إذا لم تكن هناك بيانات في الكاش
    emit(GetBooksNewestLoading());
    final cachedData = await repoHome.getCachedNewestBooks(topic: topic);
    if (cachedData.isNotEmpty) {
      emit(GetBooksNewestSuccess(books: cachedData));
    }

    final result = await repoHome.getBooksNewest(topic: topic);
    result.fold(
      (faliuer) {
        // إذا فشل جلب البيانات وكانت هناك بيانات في الكاش، لا نعرض خطأ

        emit(GetBooksNewestFaluier(message: faliuer.message));
      },
      (books) {
        emit(GetBooksNewestSuccess(books: books));
      },
    );
  }
}
