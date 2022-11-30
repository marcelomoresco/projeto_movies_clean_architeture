import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/datasource/remote/firebase_remote_datasource_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/data/repositories/firebase_repository_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/repositories/firebase_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/forgot_password_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/get_create_current_user_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/get_current_uid_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/is_sign_in_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/sign_in_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/sign_out_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/sign_up_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/forgot/forgot_password_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/datasources/remote/movies_remote_datasource_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/repositories/movies_repository_implementation.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/repositories/movies_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/delete_review_movie_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_cast_list_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_genre_list_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_movies_details_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_rating_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_similar_moives.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_trending_person_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/post_review_movie_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/add_review_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/delete_review_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/get_reviews_usecase.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/review/update_review_usecase.dart';
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

import '../../features/movies/domain/usecases/get_movies_by_search_usecase.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  //bloc
  sl.registerFactory(
    () => UserCubit(
      forgotPasswordUsecase: sl(),
      signInUsecase: sl(),
      signUpUsecase: sl(),
      signOutUsecase: sl(),
      getCreateCurrentUserUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => ReviewCubit(
      deleteRatingMovieUseCase: sl(),
      getCurrentUIdUsecase: sl(),
      postRatingMovieUseCase: sl(),
      updateReviewUsecase: sl(),
      addReviewUsecase: sl(),
      deleteReviewUsecase: sl(),
      getReviewsUsecase: sl(),
    ),
  );

  sl.registerFactory(() =>
      MoviesBloc(getMoviesByGenreUsecase: sl(), getNowMoviesUsecase: sl()));
  sl.registerFactory(() =>
      MovieDetailBloc(getMoviesDetailsUsecase: sl(), getRatingUsecase: sl()));
  sl.registerFactory(() => SimilarMoviesBloc(getSimilarMoviesUsecase: sl()));
  sl.registerFactory(() => UpcomingMoviesBloc(getUpcomingMoviesUsecase: sl()));
  sl.registerFactory(() => PersonBloc(getTrendingPersonUsecase: sl()));
  sl.registerFactory(() => GenreBloc(getGenreListUsecase: sl()));
  sl.registerFactory(() => CastMovieBloc(getCastListUsecase: sl()));
  sl.registerFactory(() => SearchBloc(getMoviesBySearchUsecase: sl()));

  //usecase

  // review usecase
  sl.registerLazySingleton<GetRatingUsecase>(
      () => GetRatingUsecase(moviesRepository: sl()));

  sl.registerLazySingleton<GetReviewsUsecase>(
      () => GetReviewsUsecase(firebaseRepository: sl()));

  sl.registerLazySingleton<AddReviewUsecase>(
      () => AddReviewUsecase(firebaseRepository: sl()));

  sl.registerLazySingleton<DeleteReviewUsecase>(
      () => DeleteReviewUsecase(firebaseRepository: sl()));

  sl.registerLazySingleton<UpdateReviewUsecase>(
      () => UpdateReviewUsecase(firebaseRepository: sl()));

  sl.registerLazySingleton<PostRatingMovieUseCase>(
      () => PostRatingMovieUseCase(moviesRepository: sl()));

  sl.registerLazySingleton<DeleteRatingMovieUseCase>(
      () => DeleteRatingMovieUseCase(moviesRepository: sl()));

  //--------------------------------------
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
  sl.registerLazySingleton<GetMoviesBySearchUsecase>(
    () => GetMoviesBySearchUsecase(moviesRepository: sl()),
  );

  //login usecase
  sl.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(firebaseRepository: sl()),
  );

  sl.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(firebaseRepository: sl()),
  );

  sl.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(firebaseRepository: sl()),
  );
  sl.registerLazySingleton<IsSignInUsecase>(
    () => IsSignInUsecase(firebaseRepository: sl()),
  );
  sl.registerLazySingleton<GetCurrentUIdUsecase>(
    () => GetCurrentUIdUsecase(firebaseRepository: sl()),
  );
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
    () => GetCreateCurrentUserUsecase(firebaseRepository: sl()),
  );

  sl.registerLazySingleton<ForgotPasswordUsecase>(
    () => ForgotPasswordUsecase(
      firebaseRepository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<IMoviesRepository>(
    () => MoviesRepositoryImplementation(moviesRemoteDatasource: sl()),
  );

  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImplementation(
      remoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<IFirebaseRemoteDatasource>(
    () => FirebaseRemoteDatasourceImplementation(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
    ),
  );
  //datasources

  sl.registerLazySingleton<IMoviesRemoteDatasource>(
    () => MoviesRemoteDatasourceImplementation(),
  );

  //core

  //external

  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(
    () => auth,
  );
  sl.registerLazySingleton(
    () => firebaseFirestore,
  );
}
