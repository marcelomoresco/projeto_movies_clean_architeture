import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_create_edit_review.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/review_app_widget.dart';

class ReviewAppPage extends StatefulWidget {
  const ReviewAppPage({super.key});

  @override
  State<ReviewAppPage> createState() => _ReviewAppPageState();
}

class _ReviewAppPageState extends State<ReviewAppPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    context.read<ReviewCubit>().getReviews();
    super.initState();
  }

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
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('reviews').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                print(snapshot);
                print(FirebaseFirestore.instance.collection('reviews'));
                print(FirebaseFirestore.instance.collection('reviews'));
                print(FirebaseFirestore.instance.collection('reviews'));
                print(FirebaseFirestore.instance.collection('reviews'));
                if (snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Text(
                                document['nameReview'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                document['review'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return Column(
                    children: const [
                      SizedBox(
                        height: 90,
                      ),
                      Center(
                        child: Text(
                          "Ainda não temos review!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            /*BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) {
                if (state is ReviewLoadedState) {
                  print("TAAQUI!!!");
                  return ReviewAppWidget(reviews: state.reviews);
                } else if (state is ReviewLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ReviewErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is ReviewInitial) {
                  return const Center(
                    child: Text("Ainda não temos review no aplicativo!"),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Ainda não temos review no aplicativo!",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
