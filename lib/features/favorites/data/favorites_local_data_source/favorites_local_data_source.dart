import 'package:easy_book/features/favorites/data/model/favorite_model.dart';
import 'package:hive/hive.dart';

class FavoritesLocalDataSource {
  final Box box;
  static const String key = 'favorites';
  FavoritesLocalDataSource({required this.box});
  Future<List<FavoriteModel>> getFavorites() async {
    final result = await box.get(key);
    if (result == null) return [];
    final list = (result as List)
        .map((e) => FavoriteModel.fromJson(e))
        .toList();
    return list;
  }

  Future<void> addFavorite(FavoriteModel favoritemodel) async {
    final current = await getFavorites();
    if (current.any((e) => e.id == favoritemodel.id)) return;
    current.add(favoritemodel);
    await box.put(key, current.map((e) => e.toJson()).toList());
  }

  Future<void> removeFavorite(FavoriteModel favoritemodel) async {
    final current = await getFavorites();
    current.removeWhere((e) => e.id == favoritemodel.id);
    await box.put(key, current.map((e) => e.toJson()).toList());
  }

  Future<bool> isFavorite(int id) async {
    final favorites = await getFavorites();
    return favorites.any((favorite) => favorite.id == id);
  }
}
