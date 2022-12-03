import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_create_edit_review.dart';

class ReviewAppWidget extends StatelessWidget {
  final List<ReviewEntity> reviews;
  const ReviewAppWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 90,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return ModalCreateEditReview(
            isEdit: true,
            reviewEntity: review,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    review.nameReview!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    review.review!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
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
