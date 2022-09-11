import 'package:flutter/material.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/data/models/movie_model_impl.dart';
import 'package:movieapp/data/vos/credit_vo.dart';
import 'package:movieapp/data/vos/movie_vo.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:movieapp/resources/colors.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/resources/strings.dart';
import 'package:movieapp/widgets/actors_and_creators_section_view.dart';
import 'package:movieapp/widgets/gradient_view.dart';
import 'package:movieapp/widgets/rating_view.dart';
import 'package:movieapp/widgets/title_text.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieModel mMovieModel = MovieModelImpl();

  MovieVO? mMovie;
  List<CreditVO>? mActorList;
  List<CreditVO>? mCreatorsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mMovieModel.getMovieDetails(widget.movieId)?.then((movie) {
      setState(() {
        mMovie = movie;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    mMovieModel.getCreditsByMovie(widget.movieId)?.then((creditsList) {
      setState(() {
        mActorList?.where((credit) => credit.isActor()).toList();
        mCreatorsList?.where((credit) => credit.isCreator()).toList();
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: (mMovie != null)
            ? CustomScrollView(
                slivers: [
                  MovieDetailsAppBarView(mMovie: mMovie, () {
                    Navigator.pop(context);
                  }),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                          child: TrailerSection(mMovie: mMovie!),
                        ),
                        const SizedBox(height: MARGIN_LARGE),
                        ActorAndCreatorsSectionView(
                          mActorList: mActorList ?? [],
                          'ACTORS',
                          '',
                          seeMoreButtonVisibility: false,
                        ),
                        const SizedBox(height: MARGIN_LARGE),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                          child: AboutFilmSectionView(mMovie: mMovie),
                        ),
                        const SizedBox(height: MARGIN_LARGE),
                        (mCreatorsList != null && mCreatorsList!.isNotEmpty)
                            ? ActorAndCreatorsSectionView(
                                mActorList: mCreatorsList ?? [],
                                MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                                MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? mMovie;

  const AboutFilmSectionView({
    required this.mMovie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText('ABOUT FILM'),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Original Title:', mMovie?.originalTitle ?? ''),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Type:', mMovie?.genres?.map((genre) => genre.name).join(',') ?? ''),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Production:', mMovie?.productionCountries?.map((country) => country.name).join(',') ?? ''),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Premiere:', mMovie?.releaseDate ?? ''),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Description:', mMovie?.overview ?? ''),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

  const AboutFilmInfoView(
    this.label,
    this.description, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: const TextStyle(
              color: MOVIE_DETAILS_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final MovieVO mMovie;
  const TrailerSection({
    required this.mMovie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(mMovie.genres?.map((genre) => genre.name ?? '').toList() ?? []),
        const SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(mMovie.overview ?? ''),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: const [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
              'RATE MOVIE',
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  const MovieDetailsScreenButtonView(
    this.title,
    this.backgroundColor,
    this.buttonIcon, {
    this.isGhostButton = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(width: MARGIN_MEDIUM),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String desc;

  const StoryLineView(
    this.desc, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          desc,
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  final List<String> genreList;

  const MovieTimeAndGenreView(
    this.genreList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: _createMovieTimeAndGenreWidget(),
      ),
    );
  }

  List<Widget> _createMovieTimeAndGenreWidget() {
    List<Widget> widgets = [
      Icon(
        Icons.access_time,
        color: PLAY_BUTTON_COLOR,
      ),
      SizedBox(width: MARGIN_SMALL),
      Text(
        '2h 30min',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: MARGIN_MEDIUM),
    ];
    widgets.addAll(genreList.map((genre) => GenreChipView(genre.toString())).toList());
    widgets.add(
      const Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
    return widgets;
  }
// Row(
// children: genreList.map((genre) => GenreChipView(genre)).toList(),
// ),

}

class GenreChipView extends StatelessWidget {
  final String genreText;

  const GenreChipView(
    this.genreText, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
            backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(width: MARGIN_SMALL),
      ],
    );
  }
}

class MovieDetailsAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? mMovie;

  const MovieDetailsAppBarView(
    this.onTapBack, {
    required this.mMovie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAILS_SCRREN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(movieImage: mMovie?.posterPath ?? ''),
            ),
            const Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(() {
                  onTapBack();
                }),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: MovieDetailsAppBarInfoView(
                  mMovie: mMovie,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO? mMovie;

  const MovieDetailsAppBarInfoView({
    required this.mMovie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(year: mMovie?.releaseDate?.substring(0, 4) ?? ''),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RatingView(),
                    const SizedBox(height: MARGIN_SMALL),
                    TitleText('${mMovie?.voteCount} VOTES'),
                    const SizedBox(height: MARGIN_CARD_MEDIUM_2)
                  ],
                ),
                const SizedBox(width: MARGIN_MEDIUM),
                Text(
                  '${mMovie?.voteAverage}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEZT_SIZE,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          mMovie?.title ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;

  const MovieDetailsYearView({
    required this.year,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          year,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  const BackButtonView(
    this.onTapBack, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  final String movieImage;

  const MovieDetailsAppBarImageView({
    required this.movieImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$movieImage',
      fit: BoxFit.cover,
    );
  }
}
