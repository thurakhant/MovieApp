import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_details_page.dart';
import 'package:movieapp/resources/colors.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/resources/strings.dart';
import 'package:movieapp/viewitems/showcase_view.dart';
import 'package:movieapp/widgets/actors_and_creators_section_view.dart';
import 'package:movieapp/widgets/see_more_text.dart';
import 'package:movieapp/widgets/title_text.dart';
import 'package:movieapp/viewitems/banner_view.dart';
import 'package:movieapp/viewitems/movie_view.dart';

import '../widgets/title_text_with_see_more_view.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

  HomePage({Key? key}) : super(key: key);

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
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BannerSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              BestPopularSectionMoviesAndSerialsSectionView(
                () => _navigateToMovieDetailsScreen(context),
              ),
              const SizedBox(height: MARGIN_LARGE),
              const CheckMovieShowTimeSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                genreList: genreList,
                () => _navigateToMovieDetailsScreen(context),
              ),
              const SizedBox(height: MARGIN_LARGE),
              const ShowcasesSection(),
              const SizedBox(height: MARGIN_LARGE),
              const ActorAndCreatorsSectionView(
                  BEST_ACTORS_TITLE, BEST_ACTORS_SEE_MORE),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MovieDetailsPage()));
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  const CheckMovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SHOWTIME_SECTION_HEIGHT,
      color: PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.all(MARGIN_LARGE),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOW_TIME,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_HEADING_1X,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  const ShowcasesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: const [
              ShowCaseView(),
              ShowCaseView(),
              ShowCaseView(),
            ],
          ),
        ),
      ],
    );
  }
}

class BestPopularSectionMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;

  const BestPopularSectionMoviesAndSerialsSectionView(
    this.onTapMovie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const TitleText(BEST_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        HorizintalMovieListView(() {
          onTapMovie();
        }),
      ],
    );
  }
}

class HorizintalMovieListView extends StatelessWidget {
  final Function onTapMovie;

  const HorizintalMovieListView(
    this.onTapMovie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return MovieView(() {
            onTapMovie();
          });
        },
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: const [
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 2,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<String> genreList;
  final Function onTapMovie;

  const GenreSectionView(this.onTapMovie, {required this.genreList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text(genre),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizintalMovieListView(() {
            onTapMovie();
          }),
        ),
      ],
    );
  }
}
