import 'package:easy_book/core/utils/service_locater.dart';
import 'package:easy_book/core/model/book_model/author.dart';
import 'package:easy_book/core/model/book_model/editors.dart';
import 'package:easy_book/core/model/book_model/formats.dart';
import 'package:easy_book/features/favorites/data/repo/favorite_repo.dart';
import 'package:easy_book/features/favorites/presentation/screen/viewmodel/cubit/favorites_cubit.dart';
import 'package:easy_book/features/home/data/repo/repo_home_impl.dart';
import 'package:easy_book/features/home/presentation/screen/viewmodel/get_books_newest_cubit/get_books_newest_cubit.dart';
import 'package:easy_book/features/home/presentation/screen/viewmodel/get_books_popular_cubit/get_books_popular_cubit.dart';
import 'package:easy_book/features/library/data/repo/library_repo_implt.dart';
import 'package:easy_book/features/library/presentation/view_model/cubit/library_cubit.dart';
import 'package:easy_book/features/onborading/data/datasource/onboarding_local_ds.dart';
import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/core/utils/app_routers.dart';
import 'package:easy_book/features/search/data/search_repo_impl.dart';
import 'package:easy_book/features/search/presentation/screen/viewmodel/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(AuthorAdapter());
  Hive.registerAdapter(EditorsAdapter());
  Hive.registerAdapter(FormatsAdapter());

  final appBox = await Hive.openBox("appBox");
  final favoritesBox = await Hive.openBox("favoritesBox");
  final homeCachedBox = await Hive.openBox('homeCachedBox');
  final libraryBox = await Hive.openBox('libraryBox');

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
                ..getBooksPopular(topic: 'all'),
        ),

        BlocProvider(
          create: (context) =>
              GetBooksNewestCubit(getit.get<RepoHomeImpl>())
                ..getBooksNewest(topic: 'all'),
        ),
        BlocProvider(
          create: (context) =>
              FavoritesCubit(getit.get<FavoriteRepo>())..getFavorites(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(getit.get<SearchRepoImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              LibraryCubit(getit.get<LibraryRepoImplt>())..getBooks(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        routerConfig: router,
      ),
    );
  }
}
