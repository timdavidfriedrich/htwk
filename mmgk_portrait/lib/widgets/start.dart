import 'package:flutter/material.dart';
import 'package:mmgk_portrait/constants/appConstants.dart';
import 'package:mmgk_portrait/constants/source.dart';
import 'package:mmgk_portrait/constants/text.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return w < defaultBp
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: startContent(context).reversed.toList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: startContent(context),
          );
  }
}

List<Widget> startContent(BuildContext context) {
  var tt = Theme.of(context).textTheme;
  var w = MediaQuery.of(context).size.width;
  var h = MediaQuery.of(context).size.height;
  return [
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: <Widget>[
            Positioned(
              bottom: w < defaultBp ? -2 : -3,
              right: w < defaultBp ? -2 : -3,
              child: Text(
                'Tim Friedrich',
                style: w < defaultBp
                    ? tt.bodyLarge!.copyWith(fontSize: 48)
                    : tt.bodyLarge,
              ),
            ),
            Text(
              'Tim Friedrich',
              style: w < defaultBp
                  ? tt.bodyLarge!.copyWith(
                      fontSize: 48,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.black,
                    )
                  : tt.bodyLarge!.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5
                        ..color = Colors.black,
                    ),
            ),
          ],
        ),
        Text(
          description,
          style: w < defaultBp
              ? tt.bodyMedium!.copyWith(fontSize: 24)
              : tt.bodyMedium,
        ),
      ],
    ),
    w < defaultBp ? const SizedBox(height: 48) : Container(),
    w < defaultBp
        ? SizedBox(width: 320, child: Image.asset(dino))
        : SizedBox(height: h * 0.8, child: Image.asset(dino)),
  ];
}
