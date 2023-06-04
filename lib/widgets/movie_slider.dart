import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';
import 'package:movies/theme/app_theme.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function nextMovies;

  const MovieSlider({
    required this.movies,
    required this.nextMovies,
    super.key, 
    this.title, 
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.nextMovies();
      }
    });
    super.initState();
  }

  Widget categoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: AppTheme.headTitle
      ),
    );
  }

  Widget listItems(List<Movie> movies) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, index) {
          return _MoviePoster(movie: movies[index], heroAnimationId: '${widget.title}-$index-${movies[index].id}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title != null)
            categoryTitle(widget.title!),
          const SizedBox(height: 5),
          listItems(widget.movies),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroAnimationId;

  const _MoviePoster({required this.movie, required this.heroAnimationId});
  

  @override
  Widget build(BuildContext context) {

    movie.heroAnimationIndex = heroAnimationId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            child: Hero(
              tag: movie.heroAnimationIndex!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterPath),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
