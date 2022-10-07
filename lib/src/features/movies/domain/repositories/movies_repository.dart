import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/casts_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../../../../core/error/failures.dart';

abstract class IMoviesRepository {
  Future<Either<Failure, List<MoviesEntity>>> getPopularMovies();
  Future<Either<Failure, List<MoviesEntity>>> getMovieByGenre(int movieId);
  Future<Either<Failure, List<MoviesEntity>>> getUpcomingMovies(int movieId);
  Future<Either<Failure, GenreEntity>> getGenreList(int movieId);
  Future<Either<Failure, List<CastEntity>>> getCastList(int movieId);
  Future<Either<Failure, GenreEntity>> getTrendingPerson(int movieId);
  Future<Either<Failure, MoviesDetailsEntity>> getMoviesDetail(int movieId);
}
