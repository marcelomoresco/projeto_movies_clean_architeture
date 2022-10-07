import 'package:dartz/dartz.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/movies_repository.dart';

class GetGenreListUsecase implements Usecase<List<GenreEntity>, NoParams> {
  final IMoviesRepository moviesRepository;

  const GetGenreListUsecase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<GenreEntity>>> call(NoParams params) async {
    return await moviesRepository.getGenreList();
  }
}
