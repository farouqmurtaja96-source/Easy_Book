import 'package:easy_book/core/utils/app_routers.dart';
import 'package:easy_book/features/home/presentation/screen/widget/custom_image_itme.dart';
import 'package:easy_book/features/search/presentation/screen/viewmodel/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ItmeGridView extends StatefulWidget {
  const ItmeGridView({super.key, required this.query});
  final String query;

  @override
  State<ItmeGridView> createState() => _ItmeGridViewState();
}

class _ItmeGridViewState extends State<ItmeGridView> {
  @override
  void initState() {
    super.initState();
    // استدعاء البحث عند تهيئة الـ Widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchCubit>(context).search(query: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchError) {
          return Center(child: Text(state.message));
        } else if (state is SearchSuccess) {
          print('UI received ${state.books.length} books');
          if (state.books.isEmpty) {
            return const Center(
              child: Text(
                'لم يتم العثور على نتائج',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 30,
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
                      style: const TextStyle(
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
              );
            },
          );
        } else {
          // حالة SearchInitial أو أي حالة أخرى
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
