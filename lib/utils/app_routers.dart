import 'package:easy_book/features/onborading/presentation/screen/onborad_screen.dart';
import 'package:easy_book/features/splash/presentation/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouters {
  static const kOnborad = '/onboard';
  static final rotuer = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: kOnborad,
        builder: (context, state) => const OnboradScreen(),
      ),
    ],
  );
}
