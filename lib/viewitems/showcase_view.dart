import 'package:flutter/material.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/widgets/play_button_view.dart';
import 'package:movieapp/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://www.arthipo.com/image/cache/catalog/poster/movie/759-1554/pfilm1389-the-wolverine_bec3e98a-film-movie-posters-cinema-kanvas-tablo-canvas-1000x1000.jpg',
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
                children: const [
                  Text(
                    'Passengers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                      fontWeight: FontWeight.w600,
                      ),
                  ),
                  SizedBox(height: MARGIN_SMALL),
                  TitleText("15 DECEMBER 2016"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
