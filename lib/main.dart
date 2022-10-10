import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/genre_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/similar_movies/similar_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/upcoming_movies_bloc/upcoming_movies_bloc.dart';
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
        BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc(
            getMoviesByGenreUsecase: di.sl(),
            getNowMoviesUsecase: di.sl(),
          )..add(const StartMoviesEvent(0, "")),
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
        home: SplashPage(),
        /* initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              }
              if (authState is UnAuthenticated) {
                return const SignInPage();
              }

              return const CircularProgressIndicator();
            });
          }
        },*/
      ),
    );
  }
}
