import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/details/presentation/screen/details_screen.dart';
import 'package:easy_book/features/main/presentation/screen/main_screen.dart';
import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/features/onborading/presentation/screen/onborad_screen.dart';
import 'package:easy_book/features/reader_page/presentation/screen/reader_screen_final.dart';
import 'package:easy_book/features/search/presentation/screen/search_screen.dart';
import 'package:easy_book/features/splash/presentation/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouters {
  static const kOnborad = '/onboard';
  static const kHome = '/home';
  static const kdetails = '/details';
  static const kreader = '/reader';
  static const ksearch = '/search';
  static GoRouter router(OnboardingRepo repo) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SplashScreen(repo: repo),
        ),
        GoRoute(
          path: kOnborad,
          builder: (context, state) => OnboradScreen(repo: repo),
        ),
        GoRoute(path: kHome, builder: (context, state) => const MainScreen()),
        GoRoute(
          path: kdetails,
          builder: (context, state) =>
              DetailsScreen(bookModel: state.extra as BookModel),
        ),
        GoRoute(
          path: kreader,
          builder: (context, state) =>
              ReaderScreenRefactored(bookModel: state.extra as BookModel),
        ),
        GoRoute(
          path: ksearch,
          builder: (context, state) =>
              SearchScreen(query: state.extra as String),
        ),
      ],
    );
  }
}
