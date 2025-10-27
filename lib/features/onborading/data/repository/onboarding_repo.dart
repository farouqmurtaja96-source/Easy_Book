import 'package:easy_book/features/onborading/data/datasource/onboarding_local_ds.dart';

class OnboardingRepo {
  /** * Repository class for managing onboarding data operations. * This class acts as a mediator between data sources and business logic, * providing a clean API for accessing onboarding related data. */
  final OnBoardingLocalDataSource
  localDataSource; //  Local data source for onboarding operations

  OnboardingRepo({required this.localDataSource});
  /**   * Constructor for OnboardingRepo class.   * @param localDataSource The local data source instance to be used for operations   */

  Future<void> setDone() async => await localDataSource.cacheOnboardingDone();
  /**   * Marks the onboarding process as done by caching the status.   * @return A Future that completes when the operation is done   */

  bool isDone() => localDataSource.isOnboardingDone();
  /**   * Checks if the onboarding process has been completed.   * @return A boolean indicating whether onboarding is done or not   */
}
