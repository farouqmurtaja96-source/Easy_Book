import 'package:easy_book/utils/color_constans.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  List<String> categoryList = [
    'All',
    'Arts ',
    'Novels',
    'Poetry',
    'History',
    'Biographies',
    'Essays',
    "Fiction",
    'Classics of Literature',
    'Teaching',
    'Science',
    'Mathematics',
    'Technology',
    'Engineering',
    'Medical',
    'Health',
    'Sports',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categoryList.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? AppColor.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      categoryList[index],
                      style: TextStyle(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
