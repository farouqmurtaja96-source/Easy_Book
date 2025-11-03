import 'package:easy_book/core/datasource/api_services.dart';
import 'package:easy_book/features/home/data/repo/repo_home_impl.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;
void setupServiceLocator() {
  getit.registerSingleton<ApiServices>(ApiServices());
  getit.registerSingleton<RepoHomeImpl>(
    RepoHomeImpl(apiServices: getit.get<ApiServices>()),
  );
}
