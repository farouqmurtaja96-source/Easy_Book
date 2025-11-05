import 'package:easy_book/core/utils/service_locater.dart';
import 'package:easy_book/features/favorites/data/repo/favorite_repo.dart';
import 'package:easy_book/features/favorites/presentation/screen/viewmodel/cubit/favorites_cubit.dart';
import 'package:easy_book/features/home/data/repo/repo_home_impl.dart';
import 'package:easy_book/features/home/presentation/screen/viewmodel/get_books_newest_cubit/get_books_newest_cubit.dart';
import 'package:easy_book/features/home/presentation/screen/viewmodel/get_books_popular_cubit/get_books_popular_cubit.dart';
import 'package:easy_book/features/onborading/data/datasource/onboarding_local_ds.dart';
import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/core/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final appBox = await Hive.openBox("appBox");
  final favoritesBox = await Hive.openBox("favoritesBox");
  final repo = OnboardingRepo(
    localDataSource: OnBoardingLocalDataSource(box: appBox),
  );

  setupServiceLocator();
  final router = AppRouters.router(repo);
  runApp(EasyBook(repo: repo, router: router));
}

class EasyBook extends StatelessWidget {
  const EasyBook({super.key, required this.repo, required this.router});
  final OnboardingRepo repo;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetBooksPopularCubit(getit.get<RepoHomeImpl>())
                ..getBooksPopular(),
        ),

        BlocProvider(
          create: (context) =>
              GetBooksNewestCubit(getit.get<RepoHomeImpl>())..getBooksNewest(),
        ),
        BlocProvider(
          create: (context) =>
              FavoritesCubit(getit.get<FavoriteRepo>())..getFavorites(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        routerConfig: router,
      ),
    );
  }
}
