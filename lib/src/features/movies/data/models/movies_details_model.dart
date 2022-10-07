import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/genre_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../../domain/entities/genre_entity.dart';

class MoviesDetailsModel extends MoviesDetailsEntity {
  const MoviesDetailsModel({
    required String id,
    required String popularity,
    required String title,
    required String backPoster,
    required String poster,
    required String overview,
    required String rating,
    required String voteCount,
    required String releaseDate,
    required String budget,
    required String revenue,
    required String status,
    required String runtime,
  }) : super(
          id: id,
          popularity: popularity,
          title: title,
          backPoster: backPoster,
          poster: poster,
          overview: overview,
          rating: rating,
          voteCount: voteCount,
          releaseDate: releaseDate,
          budget: budget,
          revenue: revenue,
          status: status,
          runtime: runtime,
        );

  factory MoviesDetailsModel.fromJson(Map<String, dynamic> json) {
    return MoviesDetailsModel(
      id: json["id"].toString(),
      popularity: json["popularity"],
      title: json["title"],
      backPoster: json["backdrop_path"],
      poster: json["poster_path"],
      overview: json["overview"],
      rating: json["vote_average"].toString(),
      voteCount: json['vote_count'].toString(),
      releaseDate: json["release_date"],
      budget: json["budget"].toString(),
      revenue: json["revenue"],
      status: json["status"],
      runtime: json["runtime"].toString(),
    );
  }
}
