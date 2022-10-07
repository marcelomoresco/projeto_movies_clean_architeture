import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/movies_entity.dart';
import '../repositories/movies_repository.dart';

class GetUpcomingMoviesUsecase
    implements Usecase<List<MoviesEntity>, NoParams> {
  final IMoviesRepository moviesRepository;

  const GetUpcomingMoviesUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<MoviesEntity>>> call(NoParams params) async {
    return await moviesRepository.getUpcomingMovies();
  }
}
