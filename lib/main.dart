import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/core/consts/routes/on_generate_route.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/auth/auth_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/login/sign_in_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/cast_movie_bloc/cast_movie_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/similar_movies/similar_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/initial/initial_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/splash/splash_page.dart';
import 'src/core/injector/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc(
            getMoviesByGenreUsecase: di.sl(),
            getNowMoviesUsecase: di.sl(),
          )..add(const StartMoviesEvent(0, "")),
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
        home: AuthPage(),
      ),
    );
  }
}
