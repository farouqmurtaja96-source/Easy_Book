import 'package:bloc/bloc.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/home/data/repo/repo_home.dart';
import 'package:equatable/equatable.dart';

part 'get_books_popular_state.dart';

class GetBooksPopularCubit extends Cubit<GetBooksPopularState> {
  GetBooksPopularCubit(this.repoHome) : super(GetBooksPopularInitial());
  final RepoHome repoHome;
  Future<void> getBooksPopular({String? topic}) async {
    emit(GetBooksPopularLoading());
    var result = await repoHome.getBooksPopular(topic: topic);

    result.fold(
      (faluier) {
        emit(GetBooksPopularFaliuer(faluier.message));
      },
      (books) {
        emit(GetBooksPopularSuccess(books: books));
      },
    );
  }
}
