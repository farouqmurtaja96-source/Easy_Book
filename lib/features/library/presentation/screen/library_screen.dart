import 'package:easy_book/features/library/presentation/screen/widget/top_library_body.dart';

import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopLibraryBody(),
        // const BottomLibraryBody(
      ],
    );
  }
}
