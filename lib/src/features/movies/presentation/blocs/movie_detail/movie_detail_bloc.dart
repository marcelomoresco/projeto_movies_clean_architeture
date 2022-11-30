// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/core/usecases/usecase.dart';

import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_details_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_rating_usecase.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMoviesDetailsUsecase getMoviesDetailsUsecase;
  final GetRatingUsecase getRatingUsecase;

  MovieDetailBloc({
    required this.getRatingUsecase,
    required this.getMoviesDetailsUsecase,
  }) : super(MovieDetailInitialState()) {
    on<GetMovieDetailsEvent>(_getMovieDetailsEvent);
    on<GetRatingEvent>(_getRatingEvent);
  }

  Future<void> _getRatingEvent(
      GetRatingEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoadingState());
    final result = await getRatingUsecase(NoParams());
    result.fold(
        (failed) async => emit(
              const MovieDetailErrorState(
                  errorMessage: "Erro ao pegar informações de rating!"),
            ), (rating) async {
      emit(
        MovieDetailLoadedState(ratingList: rating),
      );
    });
  }

  Future<void> _getMovieDetailsEvent(
      GetMovieDetailsEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoadingState());
    final result = await getMoviesDetailsUsecase(event.movieId);
    result.fold(
        (failed) async => emit(
              const MovieDetailErrorState(
                  errorMessage: "Erro ao pegar informações do filme!"),
            ), (movie) async {
      emit(MovieDetailLoadedState(movieDetails: movie));
    });
  }
}
