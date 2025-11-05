import 'package:bloc/bloc.dart';
import 'package:easy_book/features/favorites/data/model/favorite_model.dart';
import 'package:easy_book/features/favorites/data/repo/favorite_repo.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.favoriteRepo) : super(FavoritesInitial());
  final FavoriteRepo favoriteRepo;
  
  Future<void> getFavorites() async {
    try {
      emit(FavoritesLoading());
      final data = await favoriteRepo.getFavorites();
      emit(FavoritesLoaded(favorites: data));
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> addFavorite(FavoriteModel favorite) async {
    try {
      emit(FavoritesLoading());
      await favoriteRepo.addFavorite(favorite);
      final data = await favoriteRepo.getFavorites();
      emit(FavoritesLoaded(favorites: data));
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> removeFavorite(FavoriteModel favorite) async {
    try {
      emit(FavoritesLoading());
      await favoriteRepo.removeFavorite(favorite);
      final data = await favoriteRepo.getFavorites();
      emit(FavoritesLoaded(favorites: data));
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }
  
  Future<bool> isFavorite(int id) async {
    try {
      return await favoriteRepo.isFavorite(id);
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
      return false;
    }
  }
}
