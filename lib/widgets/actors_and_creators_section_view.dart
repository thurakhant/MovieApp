import 'package:flutter/material.dart';
import 'package:movieapp/widgets/title_text_with_see_more_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/actor_view.dart';

class ActorAndCreatorsSectionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  const ActorAndCreatorsSectionView(
    this.titleText,
    this.seeMoreText, {
    this.seeMoreButtonVisibility = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: const EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        bottom: MARGIN_XXLARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
              titleText,
              seeMoreText,
              seeMoreButtonVisibility: seeMoreButtonVisibility,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          SizedBox(
            height: BEST_ACTOR_HEIGHT,
            child: ListView(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              children: const [
                ActorView(),
                ActorView(),
                ActorView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
