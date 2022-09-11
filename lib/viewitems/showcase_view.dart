import 'package:flutter/material.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/widgets/play_button_view.dart';
import 'package:movieapp/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';

class ShowCaseView extends StatelessWidget {
  final MovieVO mMovie;
  const ShowCaseView({
    required this.mMovie,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              '$IMAGE_BASE_URL${mMovie.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:  [
                  Text(
                    mMovie.title ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                      fontWeight: FontWeight.w600,
                      ),
                  ),
                  const SizedBox(height: MARGIN_SMALL),
                  const TitleText("15 DECEMBER 2016"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
