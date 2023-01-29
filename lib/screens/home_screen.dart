import 'package:flutter/material.dart';

import 'package:movies/widgets/card_swiper.dart';
import 'package:movies/widgets/movie_slider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              
            }, 
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            MovieSlider(),
          ],
        ),
      )
    );
  }
}