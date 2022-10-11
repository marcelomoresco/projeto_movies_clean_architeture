// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

class FavoritesEntity extends Equatable {
  final List<MoviesEntity> movies;

  const FavoritesEntity({this.movies = const <MoviesEntity>[]});

  @override
  List<Object?> get props => [movies];
}
