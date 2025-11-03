import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_book/features/reader_page/data/repo/reader_repo.dart';
import 'package:equatable/equatable.dart';

part 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit(this.readerRepo) : super(ReaderInitial());
  final ReaderRepo readerRepo;

  Future<void> loadBookText(String bookUrl) async {
    emit(ReaderLoading());
    final result = await readerRepo.getBookText(bookUrl);

    result.fold(
      (failure) {
        emit(ReaderError(failure.message));
      },
      (text) {
        emit(BookTextLoaded(text));
      },
    );
  }
}
