import 'package:get_it/get_it.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/datasource/remote/firebase_remote_datasource_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/repositories/movies_repository_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/repositories/movies_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_cast_list_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_genre_list_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_details_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_similar_moives.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_trending_person_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/person_bloc/person_bloc.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  //bloc
  sl.registerFactory(() => AuthCubit(
      getCurrentUIdUsecase: sl(), isSignInUsecase: sl(), signOutUsecase: sl()));
  sl.registerFactory(
    () => UserCubit(
      signInUsecase: sl(),
      signUpUsecase: sl(),
      signOutUsecase: sl(),
      getCreateCurrentUserUsecase: sl(),
    ),
  );

  sl.registerFactory(() =>
      MoviesBloc(getMoviesByGenreUsecase: sl(), getNowMoviesUsecase: sl()));
  sl.registerFactory(() => MovieDetailBloc(getMoviesDetailsUsecase: sl()));
  sl.registerFactory(() => PersonBloc(getTrendingPersonUsecase: sl()));
  sl.registerFactory(() => GenreBloc(getGenreListUsecase: sl()));

  //usecase

  sl.registerLazySingleton<GetCastListUsecase>(
    () => GetCastListUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetGenreListUsecase>(
    () => GetGenreListUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetMoviesByGenreUsecase>(
    () => GetMoviesByGenreUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetMoviesDetailsUsecase>(
    () => GetMoviesDetailsUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetNowMoviesUsecase>(
    () => GetNowMoviesUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetSimilarMoviesUsecase>(
    () => GetSimilarMoviesUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetUpcomingMoviesUsecase>(
    () => GetUpcomingMoviesUsecase(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetTrendingPersonUsecase>(
    () => GetTrendingPersonUsecase(moviesRepository: sl()),
  );

  //repository
  sl.registerLazySingleton<IMoviesRepository>(
    () => MoviesRepositoryImplementation(moviesRemoteDatasource: sl()),
  );
  //datasources

  sl.registerLazySingleton<IMoviesRemoteDatasource>(
    () => MoviesRemoteDatasourceImplementation(),
  );

  sl.registerLazySingleton<IFirebaseRemoteDatasource>(
    () => FirebaseRemoteDatasourceImplementation(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
    ),
  );

  //core

  //external
}
