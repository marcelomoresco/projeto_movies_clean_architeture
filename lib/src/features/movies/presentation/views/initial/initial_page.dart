import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../favorites/favorites_page.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  AnimationController? _animationController;

  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      switch (_scrollController!.position.userScrollDirection) {
        case ScrollDirection.idle:
          print("Parado");
          break;
        case ScrollDirection.forward:
          _animationController!.forward();
          break;
        case ScrollDirection.reverse:
          _animationController!.reverse();
          break;
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );

    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _animationController!.dispose();
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talk Movie"),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            SearchPage(),
            FavoritesPage(),
          ]),
      bottomNavigationBar: FadeTransition(
        opacity: _animationController!,
        child: ScaleTransition(
          scale: _animationController!,
          child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.blue,
            backgroundColor: Colors.black,
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Pesquisar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline),
                label: 'Favoritos',
              ),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
                pageController.animateToPage(
                  currentIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
