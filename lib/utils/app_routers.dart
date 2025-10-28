import 'package:easy_book/features/main/presentation/screen/main_screen.dart';
import 'package:easy_book/features/onborading/data/repository/onboarding_repo.dart';
import 'package:easy_book/features/onborading/presentation/screen/onborad_screen.dart';
import 'package:easy_book/features/splash/presentation/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouters {
  static const kOnborad = '/onboard';
  static const kHome = '/home';
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
      ],
    );
  }
}
