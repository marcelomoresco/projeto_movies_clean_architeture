import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/details/movie_detail_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/initial/initial_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/loading_widget.dart';
import '../../../domain/entities/movies_details_entity.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favoritos",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<FavoritesBloc, FavoritesState>(
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
                        DateTime dateTime = DateTime.parse(movie.releaseDate);
                        return GestureDetector(
                            onTap: () {
                              context
                                  .read<MovieDetailBloc>()
                                  .add(GetMovieDetailsEvent(movie.id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: "Deletar",
                                      onPressed: (_) {
                                        context.read<FavoritesBloc>().add(
                                            RemoveFavoritesEvent(movie: movie));
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.scale,
                                          dialogType: DialogType.success,
                                          title: 'Removido com Sucesso',
                                          headerAnimationLoop: false,
                                          btnOkOnPress: () {},
                                        ).show();
                                      },
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 165,
                                                child: Text(
                                                  movie.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(dateTime),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12)),
                                              Row(
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
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    movie.voteAverage,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
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
      ),
    );
  }
}
