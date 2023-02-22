import 'package:flutter/material.dart';

import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(arrowBack: false, title: 'home'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies, 
              title: 'Populares', 
              nextMovies: () => moviesProvider.getPopularMovies()
            ),
          ],
        ),
      ),
    );
  }
}
