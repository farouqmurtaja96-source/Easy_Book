import 'package:easy_book/features/library/presentation/screen/widget/my_book_body.dart';
import 'package:easy_book/features/library/presentation/screen/widget/recently_read_body.dart';
import 'package:easy_book/features/library/presentation/view_model/cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        if (state is LibraryError) {
          return Center(child: Text(state.message));
        } else if (state is LibrarySuccess) {
          return Column(
            children: [
              RecentlyReadBody(books: state.books),
              Expanded(child: MyBooksBody(books: state.books)),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
