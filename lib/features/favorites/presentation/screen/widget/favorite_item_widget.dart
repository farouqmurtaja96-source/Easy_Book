import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/core/model/book_model/formats.dart';
import 'package:easy_book/core/model/book_model/author.dart';
import 'package:easy_book/core/utils/app_routers.dart';
import 'package:easy_book/features/favorites/data/model/favorite_model.dart';
import 'package:easy_book/features/favorites/presentation/screen/viewmodel/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({super.key, required this.favorite});

  final FavoriteModel favorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // تحويل FavoriteModel إلى BookModel عند النقر
        final bookModel = BookModel(
          id: favorite.id,
          title: favorite.title,
          formats: Formats(
            imageJpeg: favorite.img,
            textPlainCharsetUsAscii: favorite.textPlainCharsetUsAscii,
          ),
          authors: [
            Author(name: favorite.author, birthYear: null, deathYear: null),
          ],
          summaries: favorite.summaries,
          // إضافة ملخص افتراضي
        );

        GoRouter.of(context).push(AppRouters.kdetails, extra: bookModel);
      },

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              height: 190,
              width: 145,
              fit: BoxFit.fill,
              imageUrl: favorite.img.isNotEmpty
                  ? favorite.img
                  : 'https://www.gutenberg.org/cache/epub/2701/pg2701.cover.medium.jpg',
              placeholder: (context, url) => Container(
                height: 190,
                width: 145,
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 190,
                width: 145,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
          ),

          Positioned(
            right: 20,
            top: 10,

            child: GestureDetector(
              onTap: () {
                context.read<FavoritesCubit>().removeFavorite(favorite);
              },

              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.4),
                ),
                child: const Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
