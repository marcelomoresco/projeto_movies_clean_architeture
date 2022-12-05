import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';

import '../repositories/movies_repository.dart';

class GetRatingUsecase {
  final IMoviesRepository moviesRepository;

  const GetRatingUsecase({required this.moviesRepository});

  Future<List<RatingEntity>> call() async {
    return await moviesRepository.getRating();
  }
}
