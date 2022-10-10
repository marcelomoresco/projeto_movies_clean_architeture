import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';

import '../../../../../core/usecases/usecase.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final GetUpcomingMoviesUsecase getUpcomingMoviesUsecase;

  UpcomingMoviesBloc({required this.getUpcomingMoviesUsecase})
      : super(UpcomingMoviesInitialState()) {
    on<StartUpcomingMoviesEvent>(_onStartUpcomingMoviesEvent);
  }

  void _onStartUpcomingMoviesEvent(
      StartUpcomingMoviesEvent event, Emitter<UpcomingMoviesState> emit) async {
    emit(UpcomingMoviesLoadingState());

    final result = await getUpcomingMoviesUsecase(NoParams());
    result.fold(
      (failed) => emit(
          const UpcomingMoviesErrorState(message: "Erro ao Pegar os filmes")),
      (moviesList) => emit(
        UpcomingMoviesLoadedState(moviesList: moviesList),
      ),
    );
  }
}
