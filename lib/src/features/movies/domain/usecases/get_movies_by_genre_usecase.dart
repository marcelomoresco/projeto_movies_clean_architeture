import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/movies_entity.dart';
import '../repositories/movies_repository.dart';

class GetMoviesByGenreUsecase implements Usecase<List<MoviesEntity>, int> {
  final IMoviesRepository moviesRepository;

  const GetMoviesByGenreUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<MoviesEntity>>> call(int movieId) async {
    return await moviesRepository.getMovieByGenre(movieId);
  }
}
