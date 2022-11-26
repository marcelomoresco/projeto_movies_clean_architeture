import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../../../domain/entities/genre_entity.dart';
import '../../../domain/entities/movies_details_entity.dart';
import '../../../domain/entities/person_entity.dart';

abstract class IMoviesRemoteDatasource {
  Future<List<MoviesEntity>> getUpcomingMovies();
  Future<List<CastEntity>> getCastList(int movieId);
  Future<List<GenreEntity>> getGenreList();
  Future<List<MoviesEntity>> getMovieByGenre(int movieId);
  Future<MoviesDetailsEntity> getMoviesDetail(int movieId);
  Future<List<MoviesEntity>> getNowMovies();
  Future<List<MoviesEntity>> getSimilarMovies(int movieId);
  Future<List<PersonEntity>> getTrendingPerson();
  Future<List<MoviesEntity>> getMoviesBySeach(String query);
  Future<void> postRatingMovie(int movieId, int rate);
  Future<void> deleteRatingMovie(int movieId);
}
