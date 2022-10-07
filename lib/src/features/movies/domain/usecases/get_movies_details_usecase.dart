import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/movies_details_entity.dart';
import '../repositories/movies_repository.dart';

class GetMoviesDetailsUsecase implements Usecase<MoviesDetailsEntity, int> {
  final IMoviesRepository moviesRepository;

  const GetMoviesDetailsUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, MoviesDetailsEntity>> call(int params) async {
    return await moviesRepository.getMoviesDetail(params);
  }
}
