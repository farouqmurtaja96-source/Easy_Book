part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<FavoriteModel> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({required this.message});

  @override
  List<Object> get props => [message];
}
