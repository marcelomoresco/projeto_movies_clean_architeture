import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/loading_widget.dart';

import '../../domain/entities/genre_entity.dart';
import '../../domain/entities/movies_entity.dart';
import '../blocs/genre_bloc/genre_bloc.dart';
import '../blocs/movies_bloc/movies_bloc.dart';
import '../views/details/movie_detail_page.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;

  const BuildWidgetCategory({Key? key, this.selectedGenre = 28})
      : super(key: key);

  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  int? selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Categorias",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              if (state is GenreLoadingState) {
                return const LoadingWidget();
              } else if (state is GenreLoadedState) {
                List<GenreEntity> genres = state.genreList;
                return Container(
                  height: 55,
                  color: Colors.white,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const VerticalDivider(
                      color: Colors.transparent,
                      width: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      GenreEntity genre = genres[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  GenreEntity genre = genres[index];
                                  selectedGenre = genre.id;
                                  context.read<MoviesBloc>().add(
                                      StartMoviesEvent(selectedGenre!, ''));
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: (genre.id == selectedGenre)
                                      ? Colors.grey[400]
                                      : Colors.white,
                                ),
                                child: Text(
                                  genre.name.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'muli',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesLoadingState) {
                return const LoadingWidget();
              } else if (state is MoviesLoadedState) {
                List<MoviesEntity> movieList = state.movies;

                return SizedBox(
                  height: 230,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const VerticalDivider(
                      color: Colors.transparent,
                      width: 15,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      MoviesEntity movie = movieList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 180,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) => const SizedBox(
                                  width: 180,
                                  height: 170,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              movie.title.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  movie.voteAverage,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
