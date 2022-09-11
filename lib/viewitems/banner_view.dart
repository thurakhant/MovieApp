import 'package:flutter/material.dart';
import 'package:movieapp/data/vos/movie_vo.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/widgets/play_button_view.dart';

import '../widgets/gradient_view.dart';

class BannerView extends StatelessWidget {
  final MovieVO mMovie;
  const BannerView({
    required this.mMovie,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Positioned.fill(
          child: BannerImageView(
            mImageUrl: mMovie.posterPath ?? '',
          ),
        ),
         const Positioned.fill(
            child: GradientView()),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(
            mMovieName: mMovie.title ?? '',
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        )
      ],
    );
  }
}




class BannerTitleView extends StatelessWidget {
  final String mMovieName;
  const BannerTitleView({
    required this.mMovieName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:  [
          Text(
            mMovieName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Official Review',
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String mImageUrl;
  const BannerImageView({
    required this.mImageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$mImageUrl',
      fit: BoxFit.cover,
    );
  }
}
