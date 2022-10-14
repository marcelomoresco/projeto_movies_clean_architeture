import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';

class CastMovieDetailWidget extends StatelessWidget {
  final List<CastEntity> castsList;
  const CastMovieDetailWidget({
    super.key,
    required this.castsList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: castsList.length,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
        itemBuilder: (context, index) {
          if (castsList[index].profilePath == null) {
            return const Center(
              child: Text("Sem foto"),
            );
          }
          return Container(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w200${castsList[index].profilePath}',
                      height: 120,
                      placeholder: (context, url) => const SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      castsList[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      castsList[index].character,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
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
  }
}
