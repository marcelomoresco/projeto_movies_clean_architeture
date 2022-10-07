import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/core/usecases/usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../repositories/movies_repository.dart';

class GetNowMoviesUsecase implements Usecase<List<MoviesEntity>, NoParams> {
  final IMoviesRepository moviesRepository;

  const GetNowMoviesUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<MoviesEntity>>> call(NoParams params) async {
    return await moviesRepository.getNowMovies();
  }
}
