part of 'get_books_newest_cubit.dart';

sealed class GetBooksNewestState extends Equatable {
  const GetBooksNewestState();

  @override
  List<Object> get props => [];
}

final class GetBooksNewestInitial extends GetBooksNewestState {}

final class GetBooksNewestLoading extends GetBooksNewestState {}

final class GetBooksNewestSuccess extends GetBooksNewestState {
  final List<BookModel> books;

  const GetBooksNewestSuccess({required this.books});
}

final class GetBooksNewestFaluier extends GetBooksNewestState {
  final String message;

  const GetBooksNewestFaluier({required this.message});
}
