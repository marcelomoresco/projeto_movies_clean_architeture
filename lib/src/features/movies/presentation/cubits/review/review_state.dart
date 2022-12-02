// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoadingState extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoadedState extends ReviewState {
  final List<ReviewEntity> reviews;

  ReviewLoadedState({
    required this.reviews,
  });

  @override
  List<Object?> get props => [reviews];
}

class RatingLoadedState extends ReviewState {
  //final List<RatingEntity> ratings;
  String message;

  RatingLoadedState({
    // required this.ratings,
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ReviewErrorState extends ReviewState {
  final String errorMessage;

  const ReviewErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class ReviewDeleteSuccessState extends ReviewState {
  final String title;

  const ReviewDeleteSuccessState({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}

class ReviewUpdateSuccessState extends ReviewState {
  final String title;

  const ReviewUpdateSuccessState({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}
