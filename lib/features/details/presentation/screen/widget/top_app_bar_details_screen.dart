import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopAppBarDetailsScreen extends StatelessWidget {
  const TopAppBarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Color(0xff647a85),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Text(
            'Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Color(0xff647a85),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Icon(Icons.share, size: 22, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
