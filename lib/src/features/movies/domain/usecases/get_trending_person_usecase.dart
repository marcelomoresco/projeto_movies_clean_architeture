import 'package:projeto_movies_clean_arciteture/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/movies_repository.dart';

class GetTrendingPersonUsecase
    implements Usecase<List<PersonEntity>, NoParams> {
  final IMoviesRepository moviesRepository;

  const GetTrendingPersonUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<PersonEntity>>> call(NoParams params) async {
    return await moviesRepository.getTrendingPerson();
  }
}
