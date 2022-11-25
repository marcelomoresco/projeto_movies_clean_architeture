import '../repositories/movies_repository.dart';

class PostRatingMovieUseCase {
  final IMoviesRepository moviesRepository;

  const PostRatingMovieUseCase({required this.moviesRepository});

  Future<void> call(int movieId, int rate) async {
    return moviesRepository.postRatingMovie(movieId, rate);
  }
}
