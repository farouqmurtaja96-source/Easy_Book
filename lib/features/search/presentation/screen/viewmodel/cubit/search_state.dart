part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<BookModel> books;
  const SearchSuccess({required this.books});

  @override
  List<Object> get props => [books];
}

final class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
