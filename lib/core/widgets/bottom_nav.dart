import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;
  const BottomNav({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.transparent,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  pageController.animateToPage(0,
                      duration: const Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                )),
            const SizedBox(),
            IconButton(
                onPressed: () {
                  pageController.animateToPage(1,
                      duration: const Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
