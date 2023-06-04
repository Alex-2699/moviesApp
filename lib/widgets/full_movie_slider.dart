import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies/models/movie_dto.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/theme/app_theme.dart';

class FullMovieSlider extends StatelessWidget {
  final String peopleIds;

  const FullMovieSlider({super.key, required this.peopleIds});

  listItems(List<Movie> movies) {
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, index) => _MoviePoster(movie: movies[index], heroAnimationId: '${movies[index].title}-$index-${movies[index].id}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMoviesByPeople(peopleIds),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData){
          return const SizedBox(
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Movie> movies = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SizedBox(
            width: double.infinity,
            height: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Guillermo del toro', style: AppTheme.headTitle,),
                ),
                listItems(movies),
              ],
            ),
          ),
        );
      }
    );

  }
}

class _MoviePoster extends StatelessWidget {
 
  final Movie movie;
  final String heroAnimationId;

  const _MoviePoster({
    required this.movie, 
    required this.heroAnimationId,
  });

  @override
  Widget build(BuildContext context) {

    movie.heroAnimationIndex = heroAnimationId;

    return GestureDetector(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Hero(
              tag: movie.heroAnimationIndex!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullBackdropPath),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            right: 100,
            child: Text(movie.title.toUpperCase(), style: AppTheme.headTitle)
          )
        ],
      ),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}
