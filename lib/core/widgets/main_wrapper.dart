import 'package:flutter/material.dart';
import 'package:weather/core/widgets/background.dart';
import 'package:weather/core/widgets/bottom_nav.dart';
import 'package:weather/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:weather/features/feature_weather/presentation/screens/home_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const BookmarkScreen(),
    ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(pageController: pageController),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AppBackground.getBackGroundImage(),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: pageController,
          children: pages,
        ),
      ),
    );
  }
}
