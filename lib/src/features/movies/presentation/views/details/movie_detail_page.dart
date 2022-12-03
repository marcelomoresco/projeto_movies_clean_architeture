// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/core/injector/injection_container.dart'
    as di;
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/cast_movie_bloc/cast_movie_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/similar_movies/similar_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';

import '../../../domain/entities/movies_entity.dart';
import '../../blocs/movie_detail/movie_detail_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/movies_details_widget.dart';

class MovieDetailPage extends StatefulWidget {
  final MoviesEntity movie;

  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SimilarMoviesBloc>(
          create: (_) => SimilarMoviesBloc(getSimilarMoviesUsecase: di.sl())
            ..add(
              StartSimilarMoviesEvent(movieId: widget.movie.id),
            ),
        ),
        BlocProvider<CastMovieBloc>(
          create: (_) => CastMovieBloc(getCastListUsecase: di.sl())
            ..add(
              GetCastMovieEvent(movieId: widget.movie.id),
            ),
        )
      ],
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoadingState) {
                return const LoadingWidget();
              } else if (state is MovieDetailErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is MovieDetailLoadedState) {
                return MoviesDetailsWidget(
                  movie: state.movieDetails,
                  movieEntity: widget.movie,
                );
              } else {
                return const Center(
                  child: Text("Algo de errado aconteceu.....!"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
