part of 'get_books_popular_cubit.dart';

sealed class GetBooksPopularState extends Equatable {
  const GetBooksPopularState();

  @override
  List<Object> get props => [];
}

final class GetBooksPopularInitial extends GetBooksPopularState {}

final class GetBooksPopularLoading extends GetBooksPopularState {}

final class GetBooksPopularSuccess extends GetBooksPopularState {
  final List<BookModel> books;

  const GetBooksPopularSuccess({required this.books});
}

final class GetBooksPopularFaliuer extends GetBooksPopularState {
  final String message;

  const GetBooksPopularFaliuer(this.message);
}
