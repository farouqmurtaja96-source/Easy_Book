import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: true,
      ),
      toolbarHeight: preferredSize.height,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/image/Group.png', height: 50),
            const SizedBox(width: 10),
            Text(
              'EASY BOOK',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
