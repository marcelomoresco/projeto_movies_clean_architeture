// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_details_usecase.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMoviesDetailsUsecase getMoviesDetailsUsecase;

  MovieDetailBloc({
    required this.getMoviesDetailsUsecase,
  }) : super(MovieDetailLoadingState()) {
    on<GetMovieDetailsEvent>(_getMovieDetailsEvent);
  }

  void _getMovieDetailsEvent(
      GetMovieDetailsEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoadingState());
    final result = await getMoviesDetailsUsecase(event.movieId);

    result.fold(
      (failed) => emit(
        const MovieDetailErrorState(
            errorMessage: "Erro ao pegar informações do filme!"),
      ),
      (movie) => emit(
        MovieDetailLoadedState(movieDetails: movie),
      ),
    );
  }
}
