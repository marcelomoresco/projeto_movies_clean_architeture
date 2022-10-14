import 'package:flutter/material.dart';

import '../../widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              SearchWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
