import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/genre_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/person_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/rating_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/movie_model.dart';
import '../../models/movies_details_model.dart';
import 'dart:developer' as developer;

class MoviesRemoteDatasourceImplementation implements IMoviesRemoteDatasource {
  final apiKey = 'ce7533c109968faa724d1787f65b8a21';
  final mainUrl = 'https://api.themoviedb.org/3';
  final sessionId = 'f1d321a989bbb4aacc7452aebb13c3c8d7c71d84';
  final Dio _dio = Dio();

  @override
  Future<List<CastEntity>> getCastList(int movieId) async {
    final response = await _dio
        .get('$mainUrl/movie/$movieId/credits?api_key=$apiKey&language=pt-BR');
    if (response.statusCode == 200) {
      var list = response.data['cast'] as List;
      List<CastEntity> castList = list
          .map(
            (cast) => CastEntity(
              name: cast['name'],
              profilePath: cast['profile_path'],
              character: cast['character'],
            ),
          )
          .toList();
      return castList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GenreEntity>> getGenreList() async {
    final response = await _dio
        .get('$mainUrl/genre/movie/list?api_key=$apiKey&language=pt-BR');

    if (response.statusCode == 200) {
      var genres = response.data['genres'] as List;

      List<GenreEntity> genreList =
          genres.map((g) => GenreModel.fromJson(g)).toList();
      return genreList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getMovieByGenre(int movieId) async {
    final response = await _dio.get(
        "$mainUrl/discover/movie?with_genres=$movieId&api_key=$apiKey&language=pt-BR");

    if (response.statusCode == 200) {
      var movies = response.data['results'] as List;
      List<MoviesEntity> movieList =
          movies.map((movie) => MoviesModel.fromJson(movie)).toList();
      return movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MoviesDetailsEntity> getMoviesDetail(int movieId) async {
    final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=pt-BR');
    if (response.statusCode == 200) {
      MoviesDetailsEntity movieDetail =
          MoviesDetailsModel.fromJson(response.data);
      movieDetail.castList = await getCastList(movieId);
      return movieDetail;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getNowMovies() async {
    final response = await _dio.get(
        '$mainUrl/movie/now_playing?api_key=$apiKey&language=pt-BR&page=1');
    if (response.statusCode == 200) {
      var nowMovies = response.data['results'] as List;
      return List<MoviesModel>.from(
          nowMovies.map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getSimilarMovies(int movieId) async {
    final response = await _dio.get(
        "$mainUrl/movie/$movieId/similar?api_key=$apiKey&language=pt-BR&page=1");

    if (response.statusCode == 200) {
      var similarMovies = response.data['results'] as List;
      return List<MoviesModel>.from(
          similarMovies.map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PersonEntity>> getTrendingPerson() async {
    final response =
        await _dio.get('$mainUrl/trending/person/week?api_key=$apiKey');
    if (response.statusCode == 200) {
      var persons = response.data['results'] as List;

      final personList = persons.map((p) => PersonModel.fromJson(p)).toList();

      return personList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getUpcomingMovies() async {
    final response = await _dio
        .get("$mainUrl/movie/upcoming?api_key=$apiKey&language=pt-BR&page=1");

    if (response.statusCode == 200) {
      var upcomingMovies = response.data['results'] as List;
      return List<MoviesModel>.from(
          upcomingMovies.map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getMoviesBySeach(String query) async {
    final response = await _dio.get(
        '$mainUrl/search/movie?api_key=$apiKey&page=1&query=$query&language=pt-BR');
    if (response.statusCode == 200) {
      var searchMovies = response.data['results'] as List;
      return List<MoviesModel>.from(
        searchMovies.map(
          (movie) => MoviesModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> postRatingMovie(int movieId, int rate) async {
    final response = await _dio.post(
        "$mainUrl/movie/$movieId/rating?api_key=$apiKey&session_id=$sessionId",
        data: {'value': rate});
    print(response.statusCode);
    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRatingMovie(int movieId) async {
    final response = await _dio.delete(
        "$mainUrl/movie/$movieId/rating?api_key=$apiKey&session_id=$sessionId");
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<List<RatingEntity>> getRating() async {
    final response = await _dio.get(
        '$mainUrl/account/rated/movie?api_key=$apiKey&session_id=$sessionId&page=1');
    print("CHEGUEI");
    if (response.statusCode == 200) {
      var rating = response.data['results'] as List;
      return List<RatingEntity>.from(
        rating.map(
          (movie) => RatingModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerException();
    }
  }
}
