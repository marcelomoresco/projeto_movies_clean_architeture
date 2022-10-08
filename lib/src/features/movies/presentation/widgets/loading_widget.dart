import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(
          height: 15,
        ),
        Text("Carregandoo......")
      ],
    );
  }
}
