import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';

class ModalCreateEditReview extends StatefulWidget {
  const ModalCreateEditReview({
    super.key,
    this.reviewEntity,
    required this.isEdit,
    required this.child,
  });
  final bool isEdit;
  final ReviewEntity? reviewEntity;
  final Widget child;

  @override
  State<ModalCreateEditReview> createState() => _ModalCreateEditReviewState();
}

class _ModalCreateEditReviewState extends State<ModalCreateEditReview> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerReview = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      controllerName =
          TextEditingController(text: widget.reviewEntity!.nameReview);
      controllerReview =
          TextEditingController(text: widget.reviewEntity!.review);
    }
    super.initState();
  }

  bool checkButton() {
    if (widget.isEdit) {
      if (widget.reviewEntity!.nameReview != controllerName.text ||
          widget.reviewEntity!.review != controllerReview.text) return true;
      return false;
    } else {
      if (controllerName.text.isEmpty) {
        return false;
      }
      if (controllerReview.text.isEmpty) {
        return false;
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          modalBottomSheet(context);
        },
        child: widget.child);
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
                    Text(widget.isEdit ? "Editar Review" : "Criar Review",
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
                  controller: controllerName,
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
                  controller: controllerReview,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                Visibility(
                  visible: widget.isEdit,
                  child: Column(
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
                                    context
                                        .read<ReviewCubit>()
                                        .updateReview(
                                          ReviewEntity(
                                            review: controllerReview.text,
                                          ),
                                        )
                                        .then(
                                          (value) => AwesomeDialog(
                                            context: context,
                                            animType: AnimType.scale,
                                            dialogType: DialogType.success,
                                            title: 'Editado com Sucesso',
                                            headerAnimationLoop: false,
                                            btnOkOnPress: () {},
                                          ).show(),
                                        );
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
                              "Salvar Review",
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

                                docReview.delete().then(
                                    (value) => Navigator.of(context).pop());
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
                ),
                Visibility(
                  visible: !widget.isEdit,
                  child: Column(
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
                                  FirebaseFirestore.instance
                                      .collection('reviews')
                                      .add(
                                    {
                                      'nameReview': controllerName.text,
                                      'review': controllerReview.text,
                                    },
                                  ).then(
                                    (value) => AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.success,
                                      title: 'Criado com Sucesso',
                                      headerAnimationLoop: false,
                                      btnOkOnPress: () {},
                                    ).show(),
                                  );
                                  controllerName.clear();
                                  controllerReview.clear();
                                }
                              : null,
                          child: const Text(
                            "Criar Review",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
