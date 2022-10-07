import 'package:dio/dio.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/genre_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/person_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/movie_model.dart';

class MoviesRemoteDatasourceImplementation implements IMoviesRemoteDatasource {
  final apiKey = 'ce7533c109968faa724d1787f65b8a21';
  final mainUrl = 'https://api.themoviedb.org/3';

  @override
  Future<List<CastEntity>> getCastList(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<List<GenreEntity>> getGenreList() async {
    final response = await Dio()
        .get('$mainUrl/genre/movie/list?api_key=$apiKey&language=en-US');

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
    final response = await Dio()
        .get("$mainUrl/discover/movie?with_genres=$movieId&api_key=$apiKey");

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
  Future<MoviesDetailsEntity> getMoviesDetail(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<List<MoviesEntity>> getNowMovies() async {
    final response = await Dio().get(
        '$mainUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=1');

    if (response.statusCode == 200) {
      return List<MoviesModel>.from((response.data['results'] as List)
          .map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getSimilarMovies(int movieId) async {
    final response = await Dio().get(
        "$mainUrl/movie/$movieId/similar?api_key=$apiKey&language=en-US&page=1");

    if (response.statusCode == 200) {
      return List<MoviesModel>.from((response.data['results'] as List)
          .map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PersonEntity>> getTrendingPerson() async {
    final response =
        await Dio().get('$mainUrl/trending/person/week?api_key=$apiKey');

    if (response.statusCode == 200) {
      var persons = response.data['results'] as List;
      List<PersonEntity> personList =
          persons.map((p) => PersonModel.fromJson(p)).toList();
      return personList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesEntity>> getUpcomingMovies() async {
    final response = await Dio()
        .get("$mainUrl/movie/upcoming?api_key=$apiKey&language=en-US&page=1");

    if (response.statusCode == 200) {
      return List<MoviesModel>.from((response.data['results'] as List)
          .map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }
}
