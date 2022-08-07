import 'package:flutter/material.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/widgets/play_button_view.dart';

import '../widgets/gradient_view.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
         Positioned.fill(
          child: BannerImageView(),
        ),
         Positioned.fill(
            child: GradientView()),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(),
        ),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        )
      ],
    );
  }
}




class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'The Wolverine 2013.',
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
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
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://www.arthipo.com/image/cache/catalog/poster/movie/759-1554/pfilm1389-the-wolverine_bec3e98a-film-movie-posters-cinema-kanvas-tablo-canvas-1000x1000.jpg',
      fit: BoxFit.cover,
    );
  }
}
