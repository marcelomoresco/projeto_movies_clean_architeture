import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/review_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_create_edit_review.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/review_app_widget.dart';

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
        child: Column(
          children: [
            const Text(
              "Veja os reviews do nosso app e deixe seu review",
              style: TextStyle(color: Colors.white),
            ),
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
            StreamBuilder<List<ReviewEntity>>(
              stream: readReviews(),
              builder: (context, snap) {
                if (snap.hasData) {
                  final review = snap.data!;
                  return ListView(
                    children: review.map(buildReview).toList(),
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
    );
  }

  Widget buildReview(ReviewEntity reviewEntity) {
    return ListTile(
      title: Text(reviewEntity.nameReview!),
      subtitle: Text(reviewEntity.review!),
    );
  }
}
