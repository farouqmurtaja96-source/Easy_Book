part of 'library_cubit.dart';

sealed class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

final class LibraryInitial extends LibraryState {}

final class LibrarySuccess extends LibraryState {
  final List<LibraryModel> books;

  const LibrarySuccess({required this.books});
}

final class LibraryLoading extends LibraryState {}

final class LibraryError extends LibraryState {
  final String message;
  const LibraryError({required this.message});
}
