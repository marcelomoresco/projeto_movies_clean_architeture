// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';

import '../../domain/entities/movies_details_entity.dart';

class MoviesDetailsWidget extends StatelessWidget {
  final MoviesDetailsEntity movie;
  const MoviesDetailsWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoviesDetailsEntity movieDetail = movie;
    return Stack(
      children: [
        ClipPath(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/original/${movieDetail.backPoster}',
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 120),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.play_circle_outline,
                      color: Colors.yellow,
                      size: 65,
                    ),
                    Text(
                      movieDetail.title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'muli',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overview'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      movieDetail.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'muli'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Release date'.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli',
                            ),
                          ),
                          Text(
                            movieDetail.releaseDate,
                            style: TextStyle(
                              color: Colors.yellow[800],
                              fontSize: 12,
                              fontFamily: 'muli',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'run time'.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli',
                            ),
                          ),
                          Text(
                            movieDetail.runtime.toString(),
                            style: TextStyle(
                              color: Colors.yellow[800],
                              fontSize: 12,
                              fontFamily: 'muli',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Orçamento'.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli',
                              )),
                          Text(movieDetail.budget.toString(),
                              style: TextStyle(
                                color: Colors.yellow[800],
                                fontSize: 12,
                                fontFamily: 'muli',
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                  Text('Atores'.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'muli',
                        color: Colors.white,
                      )),
                  /*SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      ),
                      itemCount: movieDetail.castList!.length,
                      itemBuilder: (context, index) {
                        CastEntity cast = movieDetail.castList![index];
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 3,
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                    imageBuilder: (context, imageBuilder) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          image: DecorationImage(
                                            image: imageBuilder,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 80,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/img_not_found.jpg'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    cast.name.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 8,
                                      fontFamily: 'muli',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    cast.character.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 8,
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
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
