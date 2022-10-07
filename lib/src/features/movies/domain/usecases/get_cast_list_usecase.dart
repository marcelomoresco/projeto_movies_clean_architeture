import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/repositories/movies_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/cast_entity.dart';

class GetCastListUsecase implements Usecase<List<CastEntity>, int> {
  final IMoviesRepository moviesRepository;

  const GetCastListUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<CastEntity>>> call(movieId) async {
    return await moviesRepository.getCastList(movieId);
  }
}
