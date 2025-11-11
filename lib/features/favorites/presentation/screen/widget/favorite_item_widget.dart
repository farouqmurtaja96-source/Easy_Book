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

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: favorite.img.isNotEmpty
                    ? Image.network(
                  favorite.img,
                  height: 190,
                  width: 145,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 190,
                      width: 145,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.book,
                        size: 64,
                        color: Colors.grey,
                      ),
                    );
                  },
                )
                    : Container(
                  height: 190,
                  width: 145,
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.book,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<FavoritesCubit>(context)
                        .removeFavorite(favorite);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .4),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.4),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            favorite.title ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(favorite.author ,

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
  }
}
