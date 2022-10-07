import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';

class MoviesDetailsEntity extends Equatable {
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;
  final String releaseDate;
  final List<GenreEntity> genres;
  final int budget;
  final int revenue;
  final String status;
  final int runtime;

  const MoviesDetailsEntity(
      {required this.id,
      required this.popularity,
      required this.title,
      required this.backPoster,
      required this.poster,
      required this.overview,
      required this.rating,
      required this.releaseDate,
      required this.genres,
      required this.budget,
      required this.revenue,
      required this.status,
      required this.runtime});

  @override
  List<Object?> get props => [
        id,
        popularity,
        title,
        backPoster,
        poster,
        overview,
        rating,
        releaseDate,
        genres,
        budget,
        revenue,
        status,
        runtime,
      ];
}
