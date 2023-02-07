import 'package:flutter/material.dart';

import 'package:movies/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(arrowBack: false, title: 'home'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardSwiper(),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
