import 'package:easy_book/features/home/presentation/screen/widget/custom_text_feild.dart';
import 'package:easy_book/features/search/presentation/screen/viewmodel/cubit/search_cubit.dart';
import 'package:easy_book/features/search/presentation/screen/widget/itme_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextFeild(
                onSubmitted: (value) {
                  final String query1 = value;
                  BlocProvider.of<SearchCubit>(context).search(query: query1);
                },
              ),
              const SizedBox(height: 20),
              Expanded(child: ItmeGridView(query: query)),
            ],
          ),
        ),
      ),
    );
  }
}
