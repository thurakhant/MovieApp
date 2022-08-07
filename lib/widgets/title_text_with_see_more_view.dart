import 'package:flutter/material.dart';
import 'package:movieapp/widgets/see_more_text.dart';
import 'package:movieapp/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  const TitleTextWithSeeMoreView(this.titleText, this.seeMoreText,
      {this.seeMoreButtonVisibility = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(titleText),
        const Spacer(),
        Visibility(
            visible: seeMoreButtonVisibility,
            child: SeeMoreText(seeMoreText)),
      ],
    );
  }
}
