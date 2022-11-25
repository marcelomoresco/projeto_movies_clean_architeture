import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/get_current_uid_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/post_review_movie_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/add_review_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/delete_review_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/get_reviews_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/update_review_usecase.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final UpdateReviewUsecase updateReviewUsecase;
  final AddReviewUsecase addReviewUsecase;
  final DeleteReviewUsecase deleteReviewUsecase;
  final GetReviewsUsecase getReviewsUsecase;
  final PostRatingMovieUseCase postRatingMovieUseCase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  ReviewCubit({
    required this.getCurrentUIdUsecase,
    required this.updateReviewUsecase,
    required this.postRatingMovieUseCase,
    required this.addReviewUsecase,
    required this.deleteReviewUsecase,
    required this.getReviewsUsecase,
  }) : super(ReviewInitial());

  Future<void> postRatingMovie(int movieId, int rate) async {
    try {
      await postRatingMovieUseCase(movieId, rate);
    } catch (e, st) {
      emit(const ReviewErrorState(errorMessage: "Erro ao fazer o post"));
    }
  }

  Future<void> addReview(ReviewEntity review) async {
    try {
      await addReviewUsecase.call(review);
      await getReviews();
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> deleteReview(ReviewEntity review) async {
    try {
      await deleteReviewUsecase.call(review);
      await getReviews();
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> updateReview(ReviewEntity review) async {
    try {
      await updateReviewUsecase.call(review);

      await getReviews();
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> getReviews() async {
    try {
      emit(ReviewLoadingState());
      final uid = await getCurrentUIdUsecase();
      getReviewsUsecase.call(uid).listen((reviews) {
        emit(ReviewLoadedState(reviews: reviews));
      });
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Erro ao pegar notas!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }
}
