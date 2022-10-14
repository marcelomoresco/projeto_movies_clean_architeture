import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';

class MoviesDetailsModel extends MoviesDetailsEntity {
  MoviesDetailsModel({
    required int id,
    required double popularity,
    required String title,
    required String backPoster,
    required String poster,
    required String overview,
    required double voteAverage,
    required int voteCount,
    required String releaseDate,
    required int budget,
    required int revenue,
    required String status,
    required int runtime,
  }) : super(
          id: id,
          popularity: popularity,
          title: title,
          backPoster: backPoster,
          poster: poster,
          overview: overview,
          voteAverage: voteAverage,
          voteCount: voteCount,
          releaseDate: releaseDate,
          budget: budget,
          revenue: revenue,
          status: status,
          runtime: runtime,
        );

  factory MoviesDetailsModel.fromJson(Map<String, dynamic> json) {
    return MoviesDetailsModel(
      id: json["id"],
      popularity: json["popularity"],
      title: json["title"],
      backPoster: json["backdrop_path"],
      poster: json["poster_path"],
      overview: json["overview"],
      voteAverage: json["vote_average"],
      voteCount: json['vote_count'],
      releaseDate: json["release_date"],
      budget: json["budget"],
      revenue: json["revenue"],
      status: json["status"],
      runtime: json["runtime"],
    );
  }
}
