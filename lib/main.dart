import 'package:easy_book/utils/app_routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EasyBook());
}

class EasyBook extends StatelessWidget {
  const EasyBook({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouters.rotuer,
    );
  }
}
