import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            backdropPath: movie.fullBackdropPath,
            movieTitle: movie.title,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                posterPath: movie.fullPosterPath,
                movieTitle: movie.title,
                originalTitle: movie.originalTitle,
                voteAverage: movie.voteAverage,
                heroAnimationId: movie.heroAnimationIndex!,
              ),
              _Overview(overview: movie.overview),
              CastingCards(movieId: movie.id),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String backdropPath;
  final String movieTitle;

  const _CustomAppBar({
    required this.backdropPath,
    required this.movieTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 13),
          child: Text(
            movieTitle,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  
  final String heroAnimationId;
  final String posterPath;
  final String movieTitle;
  final String originalTitle;
  final double voteAverage;

  const _PosterAndTitle({
    required this.posterPath,
    required this.movieTitle,
    required this.originalTitle,
    required this.voteAverage, 
    required this.heroAnimationId,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: heroAnimationId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(posterPath),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  originalTitle,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   StarRating(vote: double.parse((voteAverage * 0.5).toStringAsFixed(1))),
                    const SizedBox(width: 5),
                    Text(
                      '$voteAverage',
                      style: textTheme.bodyMedium,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview({required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double vote;

  const StarRating({required this.vote, super.key});

  @override
  Widget build(BuildContext context) {
    int wholeStars = vote.toInt();
    double decimalPart = vote - wholeStars;
    List<Widget> starWidgets = [];

    // Agregar estrellas enteras
    for (int i = 0; i < wholeStars; i++) {
      starWidgets.add(const Icon(Icons.star, color: Colors.amber,));
    }

    // Agregar media estrella si corresponde
    if (decimalPart >= 0.5) {
      starWidgets.add(const Icon(Icons.star_half, color: Colors.amber));
    }

    // Agregar estrellas vacías restantes
    for (int i = starWidgets.length; i < 5; i++) {
      starWidgets.add(const Icon(Icons.star_border_rounded, color: Colors.amber));
    }

    return Row(
      children: starWidgets,
    );
  }
}
