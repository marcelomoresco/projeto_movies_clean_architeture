import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';

class ModalEditReview {
  ModalEditReview({
    required this.reviewEntity,
  });
  final ReviewEntity reviewEntity;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerReview = TextEditingController();

  bool checkButton() {
    if (reviewEntity.nameReview != controllerName.text ||
        reviewEntity.review != controllerReview.text) return true;
    return false;
  }

  Future<void> modalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Editar Review",
                        style: TextStyle(
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
                  controller: controllerName,
                  onChanged: (value) {},
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
                  controller: controllerReview,
                  onChanged: (value) {},
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: checkButton()
                              ? () {
                                  final docReview = FirebaseFirestore.instance
                                      .collection('reviews')
                                      .doc();

                                  docReview.update({
                                    'nameReview': controllerName.text,
                                    'review': controllerReview.text,
                                  }).then(
                                      (value) => Navigator.of(context).pop());
                                }
                              : null,
                          child: const Text(
                            "Editar Review",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextButton(
                      onPressed: checkButton()
                          ? () {
                              final docReview = FirebaseFirestore.instance
                                  .collection('reviews')
                                  .doc();

                              docReview
                                  .delete()
                                  .then((value) => Navigator.of(context).pop());
                            }
                          : null,
                      child: const Text(
                        "Deletar Review",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
