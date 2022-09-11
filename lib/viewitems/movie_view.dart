import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:movieapp/widgets/rating_view.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimens.dart';

class MovieView extends StatelessWidget {
  final Function(int) onTapMovie;
  final MovieVO mMovie;
  const MovieView(
      this.onTapMovie,this.mMovie,
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
              onTapMovie(mMovie.id);
            },
            child: Image.network(
              '$IMAGE_BASE_URL${mMovie.posterPath}',
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Text(
            mMovie.title.toString(),
            style: const TextStyle(
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
