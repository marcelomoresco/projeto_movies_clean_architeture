import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

class MoviesModel extends MoviesEntity {
  MoviesModel({
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    String? posterPath,
    required String releaseDate,
    String? backdropPath,
    required String title,
    required bool video,
    required int voteCount,
    required String voteAverage,
  }) : super(
          id: id,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          releaseDate: releaseDate,
          backdropPath: backdropPath,
          title: title,
          video: video,
          voteCount: voteCount,
          voteAverage: voteAverage,
        );

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
      title: json['title'],
      video: json['video'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'].toString(),
    );
  }
}
