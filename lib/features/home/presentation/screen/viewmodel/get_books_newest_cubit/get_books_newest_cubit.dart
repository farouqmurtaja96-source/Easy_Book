import 'package:bloc/bloc.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/home/data/repo/repo_home.dart';
import 'package:equatable/equatable.dart';

part 'get_books_newest_state.dart';

class GetBooksNewestCubit extends Cubit<GetBooksNewestState> {
  GetBooksNewestCubit(this.repoHome) : super(GetBooksNewestInitial());
  final RepoHome repoHome;
  Future<void> getBooksNewest() async {
    emit(GetBooksNewestLoading());
    var result = await repoHome.getBooksNewest();
    result.fold(
      (faliuer) {
        emit(GetBooksNewestFaluier(message: faliuer.message));
      },
      (books) {
        emit(GetBooksNewestSuccess(books: books));
      },
    );
  }
}
