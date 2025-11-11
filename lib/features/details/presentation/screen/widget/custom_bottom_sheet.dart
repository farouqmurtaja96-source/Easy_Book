import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/core/utils/app_routers.dart';
import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:easy_book/features/library/presentation/view_model/cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.57, // نصف الشاشة
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Summaries',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                bookModel.summaries != null && bookModel.summaries!.isNotEmpty
                    ? bookModel.summaries!.first
                    : 'No summary available for this book.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[500],
                ),
                maxLines: 16,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Download',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final book = LibraryModel(
                          id: bookModel.id!,
                          name: bookModel.title!,
                          image: bookModel.formats!.imageJpeg!,
                          author: bookModel.authors![0].name!,
                          progress: 0,
                          readingHours: 0,
                        );
                        context.read<LibraryCubit>().addBook(book);
                        GoRouter.of(
                          context,
                        ).push(AppRouters.kreader, extra: bookModel);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Read', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
