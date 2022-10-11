// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class StartFavoritesEvent extends FavoritesEvent {}

class AddFavoritesEvent extends FavoritesEvent {
  final MoviesEntity movie;

  const AddFavoritesEvent({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class RemoveFavoritesEvent extends FavoritesEvent {
  final MoviesEntity movie;

  const RemoveFavoritesEvent({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}
