import 'package:flutter/material.dart';

import 'package:easy_book/features/details/presentation/screen/widget/top_app_bar_details_screen.dart';
import 'package:easy_book/features/favorites/presentation/screen/widget/favorites_grid_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  //   @override
  //   State<FavoritesScreen> createState() => _FavoritesScreenState();
  // }

  // class _FavoritesScreenState extends State<FavoritesScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // تحميل المفضلة عند فتح الشاشة
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     BlocProvider.of<FavoritesCubit>(context).getFavorites();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TopAppBarDetailsScreen(),
            Expanded(child: FavoritesGridView()),
          ],
        ),
      ),
    );
  }
}
