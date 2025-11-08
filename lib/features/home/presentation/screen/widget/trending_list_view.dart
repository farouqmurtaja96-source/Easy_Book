import 'package:easy_book/features/home/presentation/screen/viewmodel/get_books_popular_cubit/get_books_popular_cubit.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_image_itme.dart';
import 'package:easy_book/core/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class TrendingListView extends StatelessWidget {
  const TrendingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBooksPopularCubit, GetBooksPopularState>(
      builder: (context, state) {
        if (state is GetBooksPopularFaliuer) {
          return Center(child: Text(state.message));
        } else if (state is GetBooksPopularSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(state.books.length, (index) {
                final books = state.books[index];
                return GestureDetector(
                  onTap: () => GoRouter.of(
                    context,
                  ).push(AppRouters.kdetails, extra: books),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageItme(book: books),
                          const SizedBox(height: 8),
                          Text(
                            books.title!,
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
                                ? books.authors![0].name ?? ''
                                : (books.editors != null &&
                                      books.editors!.isNotEmpty)
                                ? books.editors![0].name ?? ''
                                : "مجهول",
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
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return SizedBox(
            height: 190,

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 145,
                        height: 190, // حجم الصندوق المؤقت
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // لو عندك زوايا مدورة
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
