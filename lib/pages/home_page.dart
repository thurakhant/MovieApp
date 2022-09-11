import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/data/models/movie_model_impl.dart';
import 'package:movieapp/data/vos/actor_vo.dart';
import 'package:movieapp/data/vos/genre_vo.dart';
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

import '../data/vos/movie_vo.dart';
import '../widgets/title_text_with_see_more_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel mMovieModel = MovieModelImpl();
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMoviesList;
  List<GenreVO>? mGenreList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMovieList;
  List<MovieVO>? mMoviesByGenreList;

  @override
  initState() {
    super.initState();

    //Now Playing Movies
    mMovieModel.getNowPlayingMovies(1)?.then((movieList) {
      setState(() {
        mNowPlayingMovieList = movieList;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    //Popular Movies
    mMovieModel.getPopularMovies(1)?.then((movieList) {
      setState(() {
        mPopularMoviesList = movieList;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    //Genres
    mMovieModel.getGenres()?.then((genreList) {
      setState(() {
        mGenreList = genreList;

        //Movies By Genre
        _getMoviesByGenreAndRefresh(mGenreList?.first.id ?? 0);
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    //Showcase
    mMovieModel.getTopRatedMovies(1)?.then((movieList) {
      setState(() {
        mShowCaseMovieList = movieList;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    //Actors
    mMovieModel.getActors(1)?.then((actorList) {
      setState(() {
        mActors = actorList;
      });
    }).catchError((error) {
      setState(() {
        debugPrint(error.toString());
      });
    });
  }

  void _getMoviesByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId)?.then((moviesByGenre) {
      setState(() {
        mMoviesByGenreList = moviesByGenre;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

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
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: MARGIN_MEDIUM_2), child: Icon(Icons.search)),
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerSectionView(mPopularMovies: mPopularMoviesList?.take(8).toList() ?? []),
              const SizedBox(height: MARGIN_LARGE),
              BestPopularSectionMoviesAndSerialsSectionView(
                  mNowPlayingMovieList: mNowPlayingMovieList ?? [],
                  (movieId) => _navigateToMovieDetailsScreen(context, movieId)),
              const SizedBox(height: MARGIN_LARGE),
              const CheckMovieShowTimeSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                genreList: mGenreList ?? [],
                onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context, movieId),
                onTapGenre: (genreId) => _getMoviesByGenreAndRefresh(genreId),
                mMoviesByGenreList: mMoviesByGenreList ?? [],
              ),
              const SizedBox(height: MARGIN_LARGE),
              ShowcasesSection(mShowCaseMovieList: mShowCaseMovieList ?? []),
              const SizedBox(height: MARGIN_LARGE),
              ActorAndCreatorsSectionView(
                BEST_ACTORS_TITLE,
                BEST_ACTORS_SEE_MORE,
                mActorList: mActors ?? [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int movieId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsPage(movieId: movieId)));
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
                style: TextStyle(color: Colors.white, fontSize: TEXT_HEADING_1X, fontWeight: FontWeight.w600),
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
  final List<MovieVO> mShowCaseMovieList;

  const ShowcasesSection({
    required this.mShowCaseMovieList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        SizedBox(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: mShowCaseMovieList.map((showCaseMovie) {
              return ShowCaseView(mMovie: showCaseMovie);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class BestPopularSectionMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> mNowPlayingMovieList;

  const BestPopularSectionMoviesAndSerialsSectionView(this.onTapMovie, {required this.mNowPlayingMovieList, super.key});

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
        HorizintalMovieListView((movieId) => onTapMovie(movieId), movieList: mNowPlayingMovieList),
      ],
    );
  }
}

class HorizintalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> movieList;

  const HorizintalMovieListView(
    this.onTapMovie, {
    required this.movieList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieView((movieId) {
            onTapMovie(movieId);
          }, movieList[index]);
        },
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO> mPopularMovies;

  const BannerSectionView({
    required this.mPopularMovies,
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
              children: widget.mPopularMovies.map((popularMovie) => BannerView(mMovie: popularMovie)).toList()),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: widget.mPopularMovies.isNotEmpty ? widget.mPopularMovies.length : 2,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO> genreList;
  final List<MovieVO> mMoviesByGenreList;
  final Function onTapMovie;
  final Function(int) onTapGenre;

  const GenreSectionView({
    required this.onTapMovie,
    required this.onTapGenre,
    required this.mMoviesByGenreList,
    required this.genreList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              onTap: (index) {
                onTapGenre(genreList[index].id);
              },
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text(genre.name.toString()),
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
          child: HorizintalMovieListView(
            (movieId) => onTapMovie(movieId),
            movieList: mMoviesByGenreList,
          ),
        ),
      ],
    );
  }
}
