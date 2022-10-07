import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';

import '../../../../core/error/failures.dart';

abstract class IMoviesRepository {
  //Requst de Filmes Populares
  Future<Either<Failure, List<MoviesEntity>>> getNowMovies();
  //Requst de Filmes em cartaz
  Future<Either<Failure, List<MoviesEntity>>> getUpcomingMovies();
  //Requst de Filmes Similares
  Future<Either<Failure, List<MoviesEntity>>> getSimilarMovies(int movieId);
//Requst de Filmes por Genero
  Future<Either<Failure, List<MoviesEntity>>> getMovieByGenre(int movieId);
  //Requst de Generos
  Future<Either<Failure, List<GenreEntity>>> getGenreList();
  //Requst de atores do filme por id
  Future<Either<Failure, List<CastEntity>>> getCastList(int movieId);
  //Requst de atores do mes
  Future<Either<Failure, List<PersonEntity>>> getTrendingPerson();
  //Requst de Detalhes dos filmes
  Future<Either<Failure, MoviesDetailsEntity>> getMoviesDetail(int movieId);
}
