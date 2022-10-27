import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';

import 'cast_entity.dart';

class MoviesDetailsEntity extends Equatable {
  final int id;
  final double popularity;
  final String title;
  final String? backPoster;
  final String? poster;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final int budget;
  final int revenue;
  final String status;
  final int runtime;
  List<CastEntity>? castList;

  MoviesDetailsEntity({
    required this.id,
    required this.popularity,
    required this.title,
    this.backPoster,
    this.poster,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.budget,
    required this.revenue,
    required this.status,
    required this.runtime,
  });

  @override
  List<Object?> get props => [
        id,
        popularity,
        title,
        backPoster,
        poster,
        overview,
        voteAverage,
        voteCount,
        releaseDate,
        budget,
        revenue,
        status,
        runtime,
      ];
}
