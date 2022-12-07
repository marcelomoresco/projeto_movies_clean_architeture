import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  Stream<List<ReviewEntity>> readReviews() =>
      FirebaseFirestore.instance.collection('reviews').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => ReviewModel.fromSnapshot(doc.data()),
                )
                .toList(),
          );

  final CollectionReference _reviews =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _reviewController,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Criar'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String price = _reviewController.text;
                    if (price.isNotEmpty) {
                      await _reviews.add({"nameReview": name, "review": price});

                      _nameController.text = '';
                      _reviewController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['nameReview'];
      _reviewController.text = documentSnapshot['review'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Editar Review",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Seu Nome",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: _nameController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Seu review",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: _reviewController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Editar'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String price = _reviewController.text;
                    if (price != null) {
                      await _reviews
                          .doc(documentSnapshot!.id)
                          .update({"nameReview": name, "review": price});
                      _nameController.text = '';
                      _reviewController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _reviews.doc(productId).delete();

    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      title: 'Removido com Sucesso',
      headerAnimationLoop: false,
      btnOkOnPress: () {},
    ).show();
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
              StreamBuilder(
                stream: _reviews.snapshots(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 16,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: snap.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snap.data!.docs[index];
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white),
                                      child: const Icon(Icons.person,
                                          color: Colors.black)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 270,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(documentSnapshot['nameReview'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          SizedBox(
                                            height: 90,
                                            child: Text(
                                              documentSnapshot['review'],
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.green),
                                      onPressed: () =>
                                          _update(documentSnapshot)),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          _delete(documentSnapshot.id)),
                                ],
                              ),
                            ),
                          );
                        },
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
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
