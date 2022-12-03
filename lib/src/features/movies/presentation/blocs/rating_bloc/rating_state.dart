// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoaded extends RatingState {
  final List<RatingEntity> ratings;
  const RatingLoaded({
    required this.ratings,
  });
  @override
  List<Object> get props => [ratings];
}

class RatingFailure extends RatingState {
  final String errorMessage;
  const RatingFailure({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
