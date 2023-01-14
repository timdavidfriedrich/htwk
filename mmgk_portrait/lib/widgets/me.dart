import 'package:flutter/material.dart';
import 'package:mmgk_portrait/constants/appConstants.dart';
import 'package:mmgk_portrait/constants/source.dart';
import 'package:mmgk_portrait/constants/text.dart';
import 'package:mmgk_portrait/widgets/socials.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return w < defaultBp
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: meContent(context),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: meContent(context),
          );
  }
}

List<Widget> meContent(BuildContext context) {
  var tt = Theme.of(context).textTheme;
  var w = MediaQuery.of(context).size.width;
  return [
    Padding(
      padding: const EdgeInsets.only(right: 128),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              width: 320,
              child: Image.asset(like)),
          const Socials(),
        ],
      ),
    ),
    w < defaultBp ? const SizedBox(height: 48) : Container(),
    Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(meTitle, style: tt.bodyMedium),
          const SizedBox(height: 16),
          SelectableText(meText, style: tt.bodySmall)
        ],
      ),
    )
  ];
}
