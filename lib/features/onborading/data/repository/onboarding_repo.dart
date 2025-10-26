import 'package:easy_book/features/onborading/data/datasource/onboarding_local_ds.dart';

class OnboardingRepo {
  final OnBoardingLocalDataSource localDataSource;

  OnboardingRepo({required this.localDataSource});

  Future<void> setDone() async => await localDataSource.cacheOnboardingDone();

  bool isDone() => localDataSource.isOnboardingDone();
}
