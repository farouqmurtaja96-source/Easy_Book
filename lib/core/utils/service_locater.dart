import 'package:easy_book/core/datasource/api_services.dart';
import 'package:easy_book/features/favorites/data/favorites_local_data_source/favorites_local_data_source.dart';
import 'package:easy_book/features/favorites/data/repo/favorite_repo.dart';
import 'package:easy_book/features/home/data/repo/repo_home_impl.dart';
import 'package:easy_book/features/library/data/local_data_source/library_local_data_source.dart';
import 'package:easy_book/features/library/data/repo/library_repo_implt.dart';
import 'package:easy_book/features/search/data/search_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getit = GetIt.instance;
void setupServiceLocator() {
  getit.registerSingleton<ApiServices>(ApiServices());
  getit.registerSingleton<RepoHomeImpl>(
    RepoHomeImpl(
      apiServices: getit.get<ApiServices>(),
      homeCachedBox: Hive.box('homeCachedBox'),
    ),
  );
  getit.registerSingleton<FavoriteRepo>(
    FavoriteRepo(
      localDataSource: FavoritesLocalDataSource(box: Hive.box('favoritesBox')),
    ),
  );
  getit.registerSingleton<LibraryRepoImplt>(
    LibraryRepoImplt(
      localDataSource: LibraryLocalDataSource(
        libraryBox: Hive.box('libraryBox'),
      ),
    ),
  );

  getit.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(apiServices: getit.get<ApiServices>()),
  );
}
