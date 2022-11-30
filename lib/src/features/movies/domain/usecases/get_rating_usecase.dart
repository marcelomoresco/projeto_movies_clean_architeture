import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/movies_repository.dart';

class GetRatingUsecase implements Usecase<List<RatingEntity>, NoParams> {
  final IMoviesRepository moviesRepository;

  const GetRatingUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<RatingEntity>>> call(NoParams params) async {
    return await moviesRepository.getRating();
  }
}
