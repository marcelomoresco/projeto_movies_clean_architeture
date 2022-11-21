import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_create_edit_review.dart';

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
        GestureDetector(
          onTap: () {
            ModalCardEditCreateReview(
              isEdit: false,
              child: Card(
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Deixe sua review",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Clique aqui e reixe sua review"),
                    ],
                  )
                ]),
              ),
            );
          },
        ),
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
