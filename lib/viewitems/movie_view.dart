import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../resources/dimens.dart';

class MovieView extends StatelessWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://www.arthipo.com/image/cache/catalog/poster/movie/759-1554/pfilm1389-the-wolverine_bec3e98a-film-movie-posters-cinema-kanvas-tablo-canvas-1000x1000.jpg',
            fit: BoxFit.cover,
            height: 200,
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          const Text(
            'West World',
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              const Text(
                '8.9',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: MARGIN_MEDIUM),
              RatingBar.builder(
                initialRating: 5.0,
                itemSize: MARGIN_MEDIUM_2,
                  itemBuilder: (BuildContext context, int index) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {

                  })
            ],
          )
        ],
      ),
    );
  }
}
