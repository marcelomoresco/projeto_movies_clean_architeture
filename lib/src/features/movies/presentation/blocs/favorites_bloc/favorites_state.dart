// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesLoadedState extends FavoritesState {
  final FavoritesEntity favorites;

  const FavoritesLoadedState({
    this.favorites = const FavoritesEntity(),
  });

  @override
  List<Object> get props => [favorites];
}

class FavoritesErrorState extends FavoritesState {
  final String errorMessage;

  const FavoritesErrorState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
