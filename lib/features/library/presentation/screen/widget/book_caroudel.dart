import 'dart:math';

import 'package:easy_book/features/library/data/model/library_model.dart';
import 'package:easy_book/features/library/presentation/screen/widget/book_progress_card.dart';
import 'package:easy_book/features/library/presentation/view_model/cubit/library_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCarousel extends StatefulWidget {
  const BookCarousel({super.key, required this.books});
  final List<LibraryModel> books;
  @override
  State<BookCarousel> createState() => _BookCarouselState();
}

class _BookCarouselState extends State<BookCarousel> {
  final PageController controller = PageController(viewportFraction: 0.75);
  double currentPage = 0;

  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? 0;
      });
    });
    context.read<LibraryCubit>().getBooks();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        RecentlyRead(currentPage: currentPage, books: widget.books),
        Center(
          child: SizedBox(
            height: 160,
            child: PageView.builder(
              controller: controller,
              itemCount: widget.books.length,
              itemBuilder: (context, index) {
                final book = widget.books[index];
                final double offset = (currentPage - index);
                // نحسب الدوران الزاوي
                final double angle = offset * pi / 6; // زاوية الدوران
                final double scale = (1 - (currentPage - index).abs() * 0.9)
                    .clamp(1, 1);
                final double opacity = (1 - (currentPage - index).abs() * 0.5)
                    .clamp(0.3, 1);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(1, 2, 0.0015)
                    ..rotateY(angle)
                    ..scale(scale),

                  child: Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BookProgressCard(book: book),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class RecentlyRead extends StatelessWidget {
  const RecentlyRead({
    super.key,
    required this.currentPage,
    required this.books,
  });
  final double currentPage;
  final List<LibraryModel> books;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              books.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 8,
                width: currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.deepPurple
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
