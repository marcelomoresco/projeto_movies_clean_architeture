// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MoviesEntity extends Equatable {
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final String title;
  final bool video;
  final int voteCount;
  final String voteAverage;

  const MoviesEntity({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteCount,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        backdropPath,
        releaseDate,
        title,
        video,
        voteCount,
        voteAverage,
      ];
}
