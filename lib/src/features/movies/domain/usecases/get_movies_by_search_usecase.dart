import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/movies_repository.dart';

class GetMoviesBySearchUsecase implements Usecase<List<MoviesEntity>, String> {
  final IMoviesRepository moviesRepository;

  const GetMoviesBySearchUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<MoviesEntity>>> call(String query) async {
    return await moviesRepository.getMovieBySearch(query);
  }
}
