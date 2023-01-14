import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmgk_portrait/constants/source.dart';


class Socials extends StatefulWidget {
  const Socials({Key? key}) : super(key: key);

  @override
  State<Socials> createState() => _SocialsState();
}

class _SocialsState extends State<Socials> {
  bool instaHover = false;
  bool discordHover = false;

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        MouseRegion(
          onEnter: (PointerEvent event) => setState(() => instaHover = true),
          onExit: (PointerEvent event) => setState(() => instaHover = false),
          child: TextButton(
            onPressed: () => html.window.open(instaURL, "Instagram"),
            child: SizedBox(
              width: 48,
              height: 48,
              child: SvgPicture.asset(
                insta,
                color: instaHover ? cs.primary : cs.onBackground,
              ),
            ),
          ),
        ),
        MouseRegion(
          onEnter: (PointerEvent event) => setState(() => discordHover = true),
          onExit: (PointerEvent event) => setState(() => discordHover = false),
          child: TextButton(
            onPressed: () => html.window.open(discordURL, "Discord"),
            child: SizedBox(
              width: 48,
              height: 48,
              child: SvgPicture.asset(
                discord,
                color: discordHover ? cs.primary : cs.onBackground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}