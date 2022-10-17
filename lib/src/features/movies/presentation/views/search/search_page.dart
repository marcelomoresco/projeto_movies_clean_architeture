import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/loading_widget.dart';

import '../../blocs/search_bloc/search_bloc.dart';
import '../../widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pesquise seu filme"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SearchWidget(
                searchController: searchController,
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const LoadingWidget();
                  } else if (state is SearchErrorState) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else if (state is SearchInitialState) {
                    return const Center();
                  } else if (state is SearchLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.moviesList.length,
                            itemBuilder: (context, index) {
                              final movie = state.moviesList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                        fit: BoxFit.cover,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            width: 110,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                          width: 180,
                                          height: 120,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          movie.originalTitle,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          movie.releaseDate,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          movie.voteAverage,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Algo deu muito errado!"),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
