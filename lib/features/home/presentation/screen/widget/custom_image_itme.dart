import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/favorites/data/model/favorite_model.dart';
import 'package:easy_book/features/favorites/presentation/screen/viewmodel/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomImageItme extends StatefulWidget {
  const CustomImageItme({this.book, super.key});
  final BookModel? book;
  @override
  State<CustomImageItme> createState() => _CustomImageItmeState();
}

class _CustomImageItmeState extends State<CustomImageItme> {
  bool isFav = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // التحقق مما إذا كان الكتاب في المفضلة عند تحميل المكون
    if (widget.book != null) {
      _checkIfFavorite();
    }
  }

  Future<void> _checkIfFavorite() async {
    if (widget.book == null) return;

    try {
      final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
      final isFavorite = await favoritesCubit.isFavorite(widget.book!.id!);
      if (mounted) {
        setState(() {
          isFav = isFavorite;
        });
      }
    } catch (e) {
      // تجاهل الخطأ في التحقق من الحالة
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.book == null || isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);

      if (isFav) {
        // إنشاء نموذج المفضلة من BookModel
        final favoriteModel = FavoriteModel(
          id: widget.book!.id!,
          title: widget.book!.title ?? '',
          author:
              (widget.book!.authors != null && widget.book!.authors!.isNotEmpty)
              ? widget.book!.authors![0].name ?? ''
              : (widget.book!.editors != null &&
                    widget.book!.editors!.isNotEmpty)
              ? widget.book!.editors![0].name ?? ''
              : 'مجهول',
          img: widget.book?.formats?.imageJpeg ?? '',
          summaries: widget.book?.summaries ?? [],
          textPlainCharsetUsAscii:
              widget.book?.formats?.textPlainCharsetUsAscii ?? '',
        );
        await favoritesCubit.removeFavorite(favoriteModel);
        setState(() {
          isFav = false;
        });
      } else {
        // إنشاء نموذج المفضلة من BookModel
        final favoriteModel = FavoriteModel(
          id: widget.book!.id!,
          title: widget.book!.title ?? '',
          author:
              (widget.book!.authors != null && widget.book!.authors!.isNotEmpty)
              ? widget.book!.authors![0].name ?? ''
              : (widget.book!.editors != null &&
                    widget.book!.editors!.isNotEmpty)
              ? widget.book!.editors![0].name ?? ''
              : 'مجهول',
          img: widget.book?.formats?.imageJpeg ?? '',
          summaries: widget.book?.summaries ?? [],
          textPlainCharsetUsAscii:
              widget.book?.formats?.textPlainCharsetUsAscii ?? '',
        );
        await favoritesCubit.addFavorite(favoriteModel);
        setState(() {
          isFav = true;
        });
      }
    } catch (e) {
      // يمكن عرض رسالة خطأ هنا إذا لزم الأمر
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFav
                ? 'فشل إزالة الكتاب من المفضلة'
                : 'فشل إضافة الكتاب إلى المفضلة',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            height: 190,
            width: 145,
            fit: BoxFit.fill,
            imageUrl:
                widget.book?.formats?.imageJpeg ??
                'https://www.gutenberg.org/cache/epub/2701/pg2701.cover.medium.jpg',
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: GestureDetector(
            onTap: _toggleFavorite,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .4),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 0.4),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color: isFav ? Colors.red : Colors.white,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
