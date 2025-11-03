part of 'reader_cubit.dart';

abstract class ReaderState extends Equatable {
  const ReaderState();

  @override
  List<Object> get props => [];
}

class ReaderInitial extends ReaderState {}

class ReaderLoading extends ReaderState {}

class BookTextLoaded extends ReaderState {
  final String bookText;

  const BookTextLoaded(this.bookText);

  @override
  List<Object> get props => [bookText];
}

class ReaderError extends ReaderState {
  final String message;

  const ReaderError(this.message);

  @override
  List<Object> get props => [message];
}
