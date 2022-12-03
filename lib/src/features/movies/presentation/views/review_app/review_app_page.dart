import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/review_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_create_edit_review.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_edit_review.dart';

class ReviewAppPage extends StatefulWidget {
  const ReviewAppPage({super.key});

  @override
  State<ReviewAppPage> createState() => _ReviewAppPageState();
}

class _ReviewAppPageState extends State<ReviewAppPage> {
  @override
  void initState() {
    super.initState();
  }

  Stream<List<ReviewEntity>> readReviews() =>
      FirebaseFirestore.instance.collection('reviews').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => ReviewModel.fromSnapshot(doc.data()),
                )
                .toList(),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 3,
        title: const Text("Reviews"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              ModalCreateEditReview(
                isEdit: false,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.yellow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.star, color: Colors.black, size: 24),
                      Text(
                        "Deixe seu review agora mesmo",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Veja os reviews do nosso app e deixe seu review",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              StreamBuilder<List<ReviewEntity>>(
                stream: readReviews(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    final review = snap.data!;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 16,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: review.map(buildReview).toList(),
                      ),
                    );
                  } else if (snap.hasError) {
                    return const Text("Algo deu errado!");
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReview(ReviewEntity reviewEntity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: const Icon(Icons.person, color: Colors.black)),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              ModalEditReview(
                      reviewEntity: ReviewEntity(
                          nameReview: reviewEntity.nameReview!,
                          review: reviewEntity.review!))
                  .modalBottomSheet(context);
            },
            child: Container(
                width: 270,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reviewEntity.nameReview!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text(
                        reviewEntity.review!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
