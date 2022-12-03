import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_rating_usecase.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final GetRatingUsecase getRatingUsecase;
  RatingBloc({required this.getRatingUsecase}) : super(RatingInitial()) {
    on<GetRatings>(_onGetRating);
  }

  void _onGetRating(GetRatings event, Emitter<RatingState> emit) async {
    emit(RatingLoading());
    final ratings = await getRatingUsecase();
    print('chegou');
    ratings.fold(
        (error) => emit(
              const RatingFailure(errorMessage: "Erro ao fazer o get"),
            ), (rating) {
      emit(
        RatingLoaded(ratings: rating),
      );
    });
  }
}
