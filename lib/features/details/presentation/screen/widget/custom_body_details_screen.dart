import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBodyDetailsScreen extends StatelessWidget {
  const CustomBodyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Book Name Book Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  'Author Name Author Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 35),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              height: 190,
              width: 150,
              imageUrl: 'https://picsum.photos/250?image=9',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
