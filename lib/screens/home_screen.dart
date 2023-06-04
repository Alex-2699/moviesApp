import 'package:flutter/material.dart';

import 'package:movies/providers/movies_provider.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: const CustomAppBar(arrowBack: false, title: 'home'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies, 
              title: 'Películas populares', 
              nextMovies: () => moviesProvider.getPopularMovies()
            ),
            // Guillermo del toro
            const FullMovieSlider(peopleIds: '10828'),
          ],
        ),
      ),
    );
  }
}
