// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';

import '../views/details/movie_detail_page.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  final List<MoviesEntity> moviesList;
  const UpcomingMoviesWidget({
    Key? key,
    required this.moviesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: moviesList
              .map((movie) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: 5.0,
                            right: 10.0,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  const Text(
                                    "Data de Lançamento: ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    movie.releaseDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            enableInfiniteScroll: true,
            height: 260,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: true,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
          ),
        )
      ],
    );
  }
}
