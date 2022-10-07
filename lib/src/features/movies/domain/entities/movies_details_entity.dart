import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';

class MoviesDetailsEntity extends Equatable {
  final String id;
  final String popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final String rating;
  final String voteCount;

  final String releaseDate;
  final String budget;
  final String revenue;
  final String status;
  final String runtime;

  const MoviesDetailsEntity(
      {required this.id,
      required this.popularity,
      required this.title,
      required this.backPoster,
      required this.poster,
      required this.overview,
      required this.rating,
      required this.voteCount,
      required this.releaseDate,
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
        voteCount,
        releaseDate,
        budget,
        revenue,
        status,
        runtime,
      ];
}
