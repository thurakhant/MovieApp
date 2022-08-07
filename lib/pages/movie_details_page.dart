import 'package:flutter/material.dart';
import 'package:movieapp/resources/colors.dart';
import 'package:movieapp/resources/dimens.dart';
import 'package:movieapp/resources/strings.dart';
import 'package:movieapp/widgets/actors_and_creators_section_view.dart';
import 'package:movieapp/widgets/gradient_view.dart';
import 'package:movieapp/widgets/rating_view.dart';
import 'package:movieapp/widgets/title_text.dart';

class MovieDetailsPage extends StatelessWidget {
  final List<String> genreList = ['Action', 'Adventure', 'Thriller'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
             MovieDetailsAppBarView((){
               Navigator.pop(context);
             }),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: TrailerSection(genreList),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  ActorAndCreatorsSectionView(
                    'ACTORS',
                    '',
                    seeMoreButtonVisibility: false,
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: AboutFilmSectionView(),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  ActorAndCreatorsSectionView(
                    MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                    MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TitleText('ABOUT FILM'),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView(
            'Original Title:', "X-Men Origins Wolverine"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView(
            'Type:', "Action, Adventure, Thriller"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Production:', "United Kingdom, USA"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView(
            'Premiere:', "8 November 2016(World)"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView('Description:',
            "Wolverine comes to Japan to meet an old friend whose life he saved years ago, and gets embroiled in a conspiracy involving yakuza and mutants. In modern day Japan, Wolverine is out of his depth in an unknown world as he faces his ultimate nemesis in a life-or-death battle that will leave him forever changed."),
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
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
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
  final List<String> genreList;

  const TrailerSection(
    this.genreList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
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
            SizedBox(width: MARGIN_MEDIUM),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({
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
          'Wolverine comes to Japan to meet an old friend whose life he saved years ago, and gets embroiled in a conspiracy involving yakuza and mutants. In modern day Japan, Wolverine is out of his depth in an unknown world as he faces his ultimate nemesis in a life-or-death battle that will leave him forever changed.',
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
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
          Row(
            children: genreList.map((genre) => GenreChipView(genre)).toList(),
          ),
          SizedBox(width: MARGIN_SMALL),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
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
  const MovieDetailsAppBarView(
      this.onTapBack,
      {
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
          children:  [
            const Positioned.fill(
              child: MovieDetailsAppBarImageView(),
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
                child: BackButtonView((){
                  onTapBack();
                }),
              ),
            ),
            Align(
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
                child: MovieDetailsAppBarInfoView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  const MovieDetailsAppBarInfoView({
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
            const MovieDetailsYearView(),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    RatingView(),
                    SizedBox(height: MARGIN_SMALL),
                    TitleText('38876 VOTES'),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2)
                  ],
                ),
                const SizedBox(width: MARGIN_MEDIUM),
                const Text(
                  '9,76',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEZT_SIZE,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        const Text(
          'The Wolvereine',
          style: TextStyle(
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
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          "2016",
          style: TextStyle(
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
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  const BackButtonView(
      this.onTapBack,
      {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
  const MovieDetailsAppBarImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://static1.srcdn.com/wordpress/wp-content/uploads/2022/06/Wolverine-red-right-hand-victim-fire-comics-logan.jpg?q=50&fit=crop&w=960&h=500&dpr=1.5",
      fit: BoxFit.cover,
    );
  }
}
