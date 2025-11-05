import 'package:easy_book/core/utils/app_routers.dart';
import 'package:easy_book/features/home/presentation/screen/viewmodel/get_books_newest_cubit/get_books_newest_cubit.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_image_itme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewsetGridView extends StatelessWidget {
  const NewsetGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBooksNewestCubit, GetBooksNewestState>(
      builder: (context, state) {
        if (state is GetBooksNewestFaluier) {
          return Center(child: Text(state.message));
        } else if (state is GetBooksNewestSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              childAspectRatio: 0.69,
            ),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final books = state.books[index];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouters.kdetails, extra: books);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageItme(book: books),
                    const SizedBox(height: 8),
                    Text(
                      books.title ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      (books.authors != null && books.authors!.isNotEmpty)
                          ? books.authors![0].name!
                          : (books.editors != null && books.editors!.isNotEmpty)
                          ? books.editors![0].name!
                          : "مجهول", // قيمة افتراضية في حالة عدم وجود مؤلفين أو محررين

                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
