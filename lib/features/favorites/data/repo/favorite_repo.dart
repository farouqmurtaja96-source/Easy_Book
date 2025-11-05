import 'package:easy_book/features/favorites/data/favorites_local_data_source/favorites_local_data_source.dart';
import 'package:easy_book/features/favorites/data/model/favorite_model.dart';

class FavoriteRepo {
  final FavoritesLocalDataSource localDataSource;

  FavoriteRepo({required this.localDataSource});
  Future<List<FavoriteModel>> getFavorites() => localDataSource.getFavorites();
  Future<void> addFavorite(FavoriteModel favorite) =>
      localDataSource.addFavorite(favorite);
  Future<void> removeFavorite(FavoriteModel favorite) =>
      localDataSource.removeFavorite(favorite);
  Future<bool> isFavorite(int id) => localDataSource.isFavorite(id);
}
