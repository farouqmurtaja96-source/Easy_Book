import 'package:easy_book/features/onborading/data/datasource/onboarding_local_ds.dart';
import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox("appBox");
  final repo = OnboardingRepo(
    localDataSource: OnBoardingLocalDataSource(box: box),
  );

  final router = AppRouters.router(repo);
  runApp(EasyBook(repo: repo, router: router));
}

class EasyBook extends StatelessWidget {
  const EasyBook({super.key, required this.repo, required this.router});
  final OnboardingRepo repo;
  final GoRouter router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
