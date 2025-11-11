import 'package:easy_book/features/favorites/presentation/screen/widget/favorite_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_book/features/favorites/presentation/screen/viewmodel/cubit/favorites_cubit.dart';

class FavoritesGridView extends StatelessWidget {
  const FavoritesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FavoritesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'حدث خطأ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<FavoritesCubit>(context).getFavorites();
                  },
                  child: Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        } else if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "There are no books in favorites.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 60,
              childAspectRatio: 0.58,
            ),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final favorite = state.favorites[index];
              return GestureDetector(
                onTap: () {
                  // تم نقل التنقل إلى داخل FavoriteItemWidget
                },
                child: FavoriteItemWidget(favorite: favorite),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
