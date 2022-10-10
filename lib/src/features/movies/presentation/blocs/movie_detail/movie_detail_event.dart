// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailsEvent extends MovieDetailEvent {
  final int movieId;

  const GetMovieDetailsEvent(
    this.movieId,
  );

  @override
  List<Object> get props => [];
}
