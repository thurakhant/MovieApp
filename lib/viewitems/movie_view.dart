import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/widgets/rating_view.dart';

import '../resources/dimens.dart';

class MovieView extends StatelessWidget {
  final Function onTapMovie;
  const MovieView(
      this.onTapMovie,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              onTapMovie();
            },
            child: Image.network(
              'https://www.arthipo.com/image/cache/catalog/poster/movie/759-1554/pfilm1389-the-wolverine_bec3e98a-film-movie-posters-cinema-kanvas-tablo-canvas-1000x1000.jpg',
              fit: BoxFit.cover,
              height: 200,
            ),
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
            children: const [
               Text(
                '8.9',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: MARGIN_MEDIUM),
              RatingView(),
            ],
          )
        ],
      ),
    );
  }
}
