import 'package:get_it/get_it.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/datasource/remote/firebase_remote_datasource_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/repositories/movies_repository_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/repositories/movies_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/person_bloc/person_bloc.dart';

GetIt sl = GetIt.instance;

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
