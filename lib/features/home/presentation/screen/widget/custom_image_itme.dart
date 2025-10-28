import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageItme extends StatefulWidget {
  const CustomImageItme({super.key});

  @override
  State<CustomImageItme> createState() => _CustomImageItmeState();
}

class _CustomImageItmeState extends State<CustomImageItme> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            height: 190,
            width: 160,
            fit: BoxFit.fill,
            imageUrl:
                'https://www.gutenberg.org/cache/epub/2701/pg2701.cover.medium.jpg',
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isFav = !isFav;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .4),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 0.4),
              ),
              child: Icon(
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
