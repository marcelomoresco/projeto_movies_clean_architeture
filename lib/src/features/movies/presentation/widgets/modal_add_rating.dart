import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_details_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';

class ModalAddRating extends StatefulWidget {
  const ModalAddRating({
    super.key,
    required this.movieModel,
    required this.child,
  });

  final MoviesDetailsEntity movieModel;
  final Widget child;

  @override
  State<ModalAddRating> createState() => _ModalAddRatingState();
}

class _ModalAddRatingState extends State<ModalAddRating> {
  int ratingInt = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        modalBottomSheet(context);
      },
      child: widget.child,
    );
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
                    const Text(
                      "Qual o rating para esse filme?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      if (rating == 5) {
                        ratingInt = 10;
                      } else if (rating == 4) {
                        ratingInt = 8;
                      } else if (rating == 3) {
                        ratingInt = 6;
                      } else if (rating == 2) {
                        ratingInt = 4;
                      } else if (rating == 1) {
                        ratingInt = 2;
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        context
                            .read<ReviewCubit>()
                            .postRatingMovie(
                                widget.movieModel.id, ratingInt, context)
                            .then(
                              (value) => context
                                  .read<ReviewCubit>()
                                  .getRating(widget.movieModel),
                            )
                            .then(
                              (value) => Navigator.of(context).pop(),
                            );
                      },
                      child: const Text(
                        "Add Rating",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        context
                            .read<ReviewCubit>()
                            .deleteRatingMovie(widget.movieModel.id, context)
                            .then(
                              (value) => context
                                  .read<ReviewCubit>()
                                  .getRating(widget.movieModel),
                            )
                            .then(
                              (value) => Navigator.of(context).pop(),
                            );
                      },
                      child: const Text(
                        "Deletar Rating",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
