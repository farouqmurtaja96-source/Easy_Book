import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_book/features/favorites/data/model/favorite_model.dart';
import 'package:easy_book/features/favorites/presentation/screen/viewmodel/cubit/favorites_cubit.dart';

class FavoriteBookItem extends StatefulWidget {
  const FavoriteBookItem({
    super.key,
    required this.favorite,
  });

  final FavoriteModel favorite;

  @override
  State<FavoriteBookItem> createState() => _FavoriteBookItemState();
}

class _FavoriteBookItemState extends State<FavoriteBookItem> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = true; // الكتاب في المفضلة بالفعل
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Stack(
      children: [
      ClipRRect(
      borderRadius: BorderRadius.circular(16),
    child: widget.favorite.img.isNotEmpty
    ? Image.network(
    widget.favorite.img,
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
        .removeFavorite(widget.favorite);
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
    widget.favorite.title ?? '',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    const SizedBox(height: 3),
    Text(
    widget.favorite.author ,

    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade500,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    ],
    );}
}


