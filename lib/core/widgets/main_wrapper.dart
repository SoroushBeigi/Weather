import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/widgets/background.dart';
import 'package:weather/core/widgets/bottom_nav.dart';
import 'package:weather/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/feature_weather/presentation/screens/home_screen.dart';

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<WeatherBloc>(context)
//         .add(const LoadCurrentWEvent(cityname: 'tehran'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocBuilder<WeatherBloc, WeatherState>(
//         builder: (context, state) {
//           if (state.cwStatus is CWLoading) {
//             return const Center(child: Text('Loading...'));
//           }
//           if (state.cwStatus is CWError) {
//             return const Center(child: Text('Error'));
//           }
//           if (state.cwStatus is CWCompleted) {
//             return const Center(child: Text('Completed'));
//           }

//           return Container();
//         },
//       ),
//     );
//   }
// }

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
