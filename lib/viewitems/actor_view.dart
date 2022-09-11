import 'package:flutter/material.dart';
import 'package:movieapp/data/vos/base_actor_vo.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:movieapp/resources/colors.dart';
import '../resources/dimens.dart';

class ActorView extends StatelessWidget {
  final BaseActorVO mActor;
  const ActorView({
    required this.mActor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(mActorImageUrl: mActor.profilePath ?? '',),
          ),
          const Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameLikeView(mActorName: mActor.name ?? '',),
          )
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String mActorImageUrl;
  const ActorImageView({
    required this.mActorImageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$mActorImageUrl',
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_outline,
      color: Colors.white,
    );
  }
}

class ActorNameLikeView extends StatelessWidget {
  final String mActorName;
  const ActorNameLikeView({
    required this.mActorName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            mActorName,
            style: const TextStyle(
              fontSize: TEXT_REGULAR_2X,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_MEDIUM,
              ),
              SizedBox(height: MARGIN_MEDIUM),
              Text(
                'YOU LIKED 13 MOVIES',
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
