import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/cast_movie_bloc/cast_movie_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/similar_movies/similar_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/splash/splash_page.dart';
import 'src/core/injector/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<ReviewCubit>(
          create: (_) => di.sl<ReviewCubit>(),
        ),
        BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc(
            getMoviesByGenreUsecase: di.sl(),
            getNowMoviesUsecase: di.sl(),
          )..add(const StartMoviesEvent(0, "")),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(
            getMoviesBySearchUsecase: di.sl(),
          ),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => FavoritesBloc()
            ..add(
              StartFavoritesEvent(),
            ),
        ),
        BlocProvider<UpcomingMoviesBloc>(
          create: (_) => UpcomingMoviesBloc(
            getUpcomingMoviesUsecase: di.sl(),
          )..add(
              StartUpcomingMoviesEvent(),
            ),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => MovieDetailBloc(
            getMoviesDetailsUsecase: di.sl(),
          ),
        ),
        BlocProvider<CastMovieBloc>(
          create: (_) => CastMovieBloc(
            getCastListUsecase: di.sl(),
          ),
        ),
        BlocProvider<SimilarMoviesBloc>(
          create: (_) => SimilarMoviesBloc(
            getSimilarMoviesUsecase: di.sl(),
          ),
        ),
        BlocProvider<GenreBloc>(
          create: (_) => GenreBloc(
            getGenreListUsecase: di.sl(),
          )..add(const StartGenreEvent()),
        ),
        BlocProvider<PersonBloc>(
          create: (_) => PersonBloc(
            getTrendingPersonUsecase: di.sl(),
          )..add(const StartPersonEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
