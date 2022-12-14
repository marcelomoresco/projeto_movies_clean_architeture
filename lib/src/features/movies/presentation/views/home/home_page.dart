// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/login/sign_in_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/review_app/review_app_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/loading_widget.dart';
import '../../blocs/person_bloc/person_bloc.dart';
import '../../widgets/category_widget.dart';
import '../../widgets/person_list_widget.dart';
import '../../widgets/upcoming_movies_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talk Movie"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<UserCubit>().signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SignInPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
                builder: (context, state) {
              if (state is UpcomingMoviesLoadedState) {
                return UpcomingMoviesWidget(
                  moviesList: state.moviesList,
                );
              } else if (state is UpcomingMoviesLoadingState) {
                return const LoadingWidget();
              } else if (state is UpcomingMoviesErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            }),
            // Categorias
            const BuildWidgetCategory(),
            //Atores da Semana
            BlocBuilder<PersonBloc, PersonState>(
              builder: (context, state) {
                if (state is PersonLoadedState) {
                  return TrendingPersonMoviesWidget(
                    personList: state.personList,
                  );
                } else if (state is PersonLoadingState) {
                  return const LoadingWidget();
                } else if (state is PersonErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return const Center(
                    child: Text("Algo de errado aconteceu!"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
