import 'package:easy_book/features/onborading/data/datasource/onboarding_local_ds.dart';
import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox("appBox");
  final repo = OnboardingRepo(
    localDataSource: OnBoardingLocalDataSource(box: box),
  );
  runApp(EasyBook(repo: repo));
}

class EasyBook extends StatelessWidget {
  const EasyBook({super.key, required this.repo});
  final OnboardingRepo repo;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouters.router(repo),
    );
  }
}
