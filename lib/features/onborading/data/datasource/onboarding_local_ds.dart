import 'package:hive/hive.dart';

class OnBoardingLocalDataSource {
  final Box box;

  OnBoardingLocalDataSource({required this.box});

  Future<void> cacheOnboardingDone() async {
    await box.put('onboarding_done', true);
  }

  bool isOnboardingDone() {
    return box.get('onboarding_done', defaultValue: false);
  }
}
