import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/favorites_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitialState()) {
    on<StartFavoritesEvent>(_onStartFavoritesEvent);
    on<AddFavoritesEvent>(_onAddFavoritesEvent);
    on<RemoveFavoritesEvent>(_onRemoveFavoritesEvent);
  }

  void _onStartFavoritesEvent(
      StartFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoadingState());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const FavoritesLoadedState());
    } catch (_) {
      emit(const FavoritesErrorState(
          errorMessage: "Erro ao Carregar Favoritos"));
    }
  }

  void _onAddFavoritesEvent(
      AddFavoritesEvent event, Emitter<FavoritesState> emit) {
    final state = this.state;
    if (state is FavoritesLoadedState) {
      try {
        emit(
          FavoritesLoadedState(
            favorites: FavoritesEntity(
              movies: List.from(state.favorites.movies)..add(event.movie),
            ),
          ),
        );
      } catch (e) {
        emit(
          const FavoritesErrorState(
              errorMessage: "Erro ao Adicionar esse filme aos Favoritos"),
        );
      }
    }
  }

  void _onRemoveFavoritesEvent(
      RemoveFavoritesEvent event, Emitter<FavoritesState> emit) {
    final state = this.state;
    if (state is FavoritesLoadedState) {
      try {
        emit(
          FavoritesLoadedState(
            favorites: FavoritesEntity(
              movies: List.from(state.favorites.movies)..remove(event.movie),
            ),
          ),
        );
      } catch (e) {
        emit(
          const FavoritesErrorState(
              errorMessage: "Erro ao Remover esse filme aos Favoritos"),
        );
      }
    }
  }
}
