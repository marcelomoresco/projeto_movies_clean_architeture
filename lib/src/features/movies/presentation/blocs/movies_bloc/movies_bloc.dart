// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/core/usecases/usecase.dart';

import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowMoviesUsecase getNowMoviesUsecase;
  final GetMoviesByGenreUsecase getMoviesByGenreUsecase;
  MoviesBloc({
    required this.getNowMoviesUsecase,
    required this.getMoviesByGenreUsecase,
  }) : super(MoviesLoadingState()) {
    on<StartMoviesEvent>(_onStartMoviesEvent);
  }

  void _onStartMoviesEvent(
      StartMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoadingState());
    if (event.movieId == 0) {
      final result = await getNowMoviesUsecase(NoParams());
      result.fold(
        (failed) => emit(
            const MoviesErrorState(errorMessage: "Erro ao Pegar os filmes")),
        (movies) => emit(
          MoviesLoadedState(movies: movies),
        ),
      );
    } else {
      final result = await getMoviesByGenreUsecase(event.movieId);
      result.fold(
        (failed) => emit(
            const MoviesErrorState(errorMessage: "Erro ao Pegar os filmes")),
        (movies) => emit(
          MoviesLoadedState(movies: movies),
        ),
      );
    }
  }
}
