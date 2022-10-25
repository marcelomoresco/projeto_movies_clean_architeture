import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../blocs/movie_detail/movie_detail_bloc.dart';
import '../views/details/movie_detail_page.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final List<MoviesEntity> moviesList;
  const SimilarMoviesWidget({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moviesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
            child: GestureDetector(
              onTap: () {
                context
                    .read<MovieDetailBloc>()
                    .add(GetMovieDetailsEvent(moviesList[index].id));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailPage(movie: moviesList[index]),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 160.0,
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: moviesList[index].posterPath == null
                                  ? const Text("Personagem sem imagem")
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w300/${moviesList[index].posterPath}",
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        width: 180,
                                        height: 190,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
