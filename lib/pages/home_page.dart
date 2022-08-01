import 'package:flutter/material.dart';
import 'package:movieapp/resources/colors.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/resources/strings.dart';
import 'package:movieapp/viewitems/banner_view.dart';
import 'package:movieapp/viewitems/movie_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
              padding: EdgeInsets.only(
                  top: 0, bottom: 0, left: 0, right: MARGIN_MEDIUM_2),
              child: Icon(Icons.search)),
        ],
      ),
      body: Container(
        color: PRIMARY_COLOR,
        child: Column(
            children: [
            const BannerSectionView(),
        Container(
          height: MOVIE_LIST_HEIGHT,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const MovieView();
            },
          ),
        )],
        ),
      ),
    );
  }
}

class BannerSectionView extends StatelessWidget {
  const BannerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 3,
      child: PageView(
        children: const [
          BannerView(),
          BannerView(),
        ],
      ),
    );
  }
}
