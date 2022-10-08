import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
          if (state is GenreLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GenreErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GenreLoadedState) {
            return Container();
          } else {
            return const Center(
              child: Text("Algo de errado aconteceu......"),
            );
          }
        })
      ],
    );
  }
}
