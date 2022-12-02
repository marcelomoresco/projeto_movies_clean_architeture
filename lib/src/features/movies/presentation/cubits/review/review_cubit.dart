import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/get_current_uid_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/delete_review_movie_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_rating_usecase.dart';
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
  final DeleteRatingMovieUseCase deleteRatingMovieUseCase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  final GetRatingUsecase getRatingUsecase;
  ReviewCubit({
    required this.getRatingUsecase,
    required this.getCurrentUIdUsecase,
    required this.deleteRatingMovieUseCase,
    required this.updateReviewUsecase,
    required this.postRatingMovieUseCase,
    required this.addReviewUsecase,
    required this.deleteReviewUsecase,
    required this.getReviewsUsecase,
  }) : super(ReviewInitial());

  Future<void> getRating(MoviesDetailsEntity moviesDetailsEntity) async {
    try {
      final rating = await getRatingUsecase();
      String message = '';
      for (int i = 0; i < rating.length; i++) {
        if (rating[i].id == moviesDetailsEntity.id) {
          message = "Você colocou ${rating[i].rating}";
        }
      }
      emit(RatingLoadedState(message: message));
    } catch (e) {
      emit(ReviewErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> postRatingMovie(
      int movieId, int rate, BuildContext context) async {
    try {
      await postRatingMovieUseCase(movieId, rate);
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        title: 'Rating feito com Sucesso',
        headerAnimationLoop: false,
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        title: 'Erro ao fazer o POST',
        headerAnimationLoop: false,
        btnOkOnPress: () {},
      ).show();
      emit(const ReviewErrorState(errorMessage: "Erro ao fazer o post"));
    }
  }

  Future<void> deleteRatingMovie(int movieId, BuildContext context) async {
    try {
      await deleteRatingMovieUseCase(movieId);
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        title: 'Rating Deletado com sucesso',
        headerAnimationLoop: false,
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      emit(const ReviewErrorState(errorMessage: "Erro ao fazer o delete"));
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
      print(uid);
      getReviewsUsecase.call(uid).listen((reviews) {
        print(reviews);
        print(reviews);
        print(reviews);
        print(reviews);
        print(reviews);
        print(reviews);
        emit(ReviewLoadedState(reviews: reviews));
      });
    } on SocketException catch (_) {
      emit(const ReviewErrorState(errorMessage: "Erro ao pegar notas!"));
    } catch (_) {
      emit(const ReviewErrorState(errorMessage: "Acorreu um erro!"));
    }
  }
}
