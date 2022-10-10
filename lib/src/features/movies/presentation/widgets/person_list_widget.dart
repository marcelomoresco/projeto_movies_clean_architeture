// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';

class TrendingPersonMoviesWidget extends StatelessWidget {
  final List<PersonEntity> personList;
  const TrendingPersonMoviesWidget({
    Key? key,
    required this.personList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Atores da semana",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: personList.length,
                separatorBuilder: (context, index) => const VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
                itemBuilder: (context, index) {
                  PersonEntity person = personList[index];
                  if (person.profilePath == null) {
                    return Container();
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
                                  'https://image.tmdb.org/t/p/w200${person.profilePath}',
                              height: 120,
                              placeholder: (context, url) => Container(
                                width: 80,
                                height: 80,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              person.name.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'muli',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              person.knowForDepartment.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
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
            )
          ],
        ),
      ),
    );
  }
}
