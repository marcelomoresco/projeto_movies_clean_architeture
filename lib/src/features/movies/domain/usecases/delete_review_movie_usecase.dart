import '../repositories/movies_repository.dart';

class DeleteRatingMovieUseCase {
  final IMoviesRepository moviesRepository;

  const DeleteRatingMovieUseCase({required this.moviesRepository});

  Future<void> call(int movieId) async {
    return moviesRepository.deleteRatingMovie(movieId);
  }
}
