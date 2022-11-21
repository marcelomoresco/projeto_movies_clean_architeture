import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:rxdart/rxdart.dart';

class ModalCardEditCreateReview extends StatefulWidget {
  const ModalCardEditCreateReview(
      {Key? key, this.reviewEntity, required this.isEdit, required this.child})
      : super(key: key);

  final ReviewEntity? reviewEntity;
  final bool isEdit;
  final Widget child;

  @override
  State<ModalCardEditCreateReview> createState() =>
      _ModalCardEditCreateReviewState();
}

class _ModalCardEditCreateReviewState extends State<ModalCardEditCreateReview> {
  late BehaviorSubject<String> value;
  late TextEditingController controllerReview;
  late TextEditingController controllerName;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    value = BehaviorSubject.seeded(widget.reviewEntity?.review ?? '');
    controllerReview = TextEditingController(text: widget.reviewEntity?.review);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => modalBottomSheet(context), child: widget.child);
  }

  bool checkButton() {
    if (controllerReview.text == widget.reviewEntity?.review) return false;
    return true;
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
                        style: const TextStyle()),
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
                  decoration: const InputDecoration(
                    hintText: "Seu nome",
                  ),
                  controller: controllerName,
                  onChanged: value.add,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: "Seu review sobre o app",
                  ),
                  controller: controllerReview,
                  onChanged: value.add,
                ),
                StreamBuilder<String>(
                  initialData: widget.isEdit ? widget.reviewEntity?.review : "",
                  stream: value,
                  builder: (_, snap) {
                    if (widget.isEdit) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: checkButton()
                                  ? () {
                                      context.read<ReviewCubit>().updateReview(
                                          widget.reviewEntity!, uid);
                                    }
                                  : null,
                              child: const Text(
                                "Salvar Review",
                                style: TextStyle(color: Colors.white),
                              )),
                          const SizedBox(
                            height: 25,
                          ),
                          TextButton(
                            child: const Text(
                              "Deletar Review",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              context
                                  .read<ReviewCubit>()
                                  .deleteReview(widget.reviewEntity!, uid);
                            },
                          ),
                          const SizedBox(
                            height: 65,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: snap.data!.isNotEmpty
                                ? () {
                                    context.read<ReviewCubit>().addReview(
                                          ReviewEntity(
                                            review: controllerReview.text,
                                            createAt: Timestamp.fromDate(
                                              DateTime.now(),
                                            ),
                                          ),
                                          uid,
                                        );
                                  }
                                : null,
                            child: const Text(
                              "Criar Review",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
