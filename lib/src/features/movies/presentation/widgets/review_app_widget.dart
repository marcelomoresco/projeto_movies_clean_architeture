import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class ReviewAppWidget extends StatelessWidget {
  final List<ReviewEntity> reviews;
  const ReviewAppWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Reviews do APP",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Veja os reviews do nosso app e deixe seu review",
          style: TextStyle(color: Colors.white),
        ),
        Card(),
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Container();
          },
        ),
      ],
    );
  }
}
