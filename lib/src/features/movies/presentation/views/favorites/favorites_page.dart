import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/loading_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Favoritos")),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
          if (state is FavoritesLoadingState) {
            return const LoadingWidget();
          } else if (state is FavoritesErrorState) {
            return const Center(
              child: Text("Erro ao carregar favoritos"),
            );
          } else if (state is FavoritesLoadedState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: state.favorites.movies.length,
                itemBuilder: (context, index) {
                  MoviesEntity movie = state.favorites.movies[index];
                  return Container();
                },
              ),
            );
          } else {
            return Container();
          }
        }));
  }
}
