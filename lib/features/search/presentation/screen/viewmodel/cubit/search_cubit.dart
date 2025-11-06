import 'package:bloc/bloc.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/search/data/search_repo.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.repo) : super(SearchInitial());
  final SearchRepo repo;
  Future<void> search({required String query}) async {
    try {
      emit(SearchLoading());
      print('cubit${query}');
      var books = await repo.searchBook(query);
      print({'books count: ${books.length}'});
      print({'first book: ${books.isNotEmpty ? books.first.title : 'none'}'});
      emit(SearchSuccess(books: books));
    } catch (e) {
      print('Error in search: $e');
      emit(SearchError(message: 'حدث خطأ أثناء البحث: $e'));
    }
  }
}
