import 'package:flutter/material.dart';
import 'package:mmgk_portrait/config/themeConfig.dart';
import 'package:mmgk_portrait/constants/appConstants.dart';
import 'package:mmgk_portrait/constants/source.dart';
import 'package:mmgk_portrait/constants/text.dart';
import 'package:mmgk_portrait/widgets/start.dart';
import 'package:mmgk_portrait/widgets/gallery.dart';
import 'package:mmgk_portrait/widgets/me.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tim',
      debugShowCheckedModeBanner: false,
      theme: themeConfig,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: w < defaultBp ? 32 : 64),
          const Start(),
          SizedBox(height: w < defaultBp ? 160 : 320),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.15),
            child: const Me(),
          ),
          SizedBox(height: w < defaultBp ? 160 : 320),
          Padding(
            padding: w < defaultBp
                ? const EdgeInsets.symmetric(horizontal: 48)
                : const EdgeInsets.all(0),
            child: Center(
              child: SelectableText(
                graphicTitle,
                textAlign: TextAlign.center,
                style: w < defaultBp
                    ? tt.bodyMedium!.copyWith(fontSize: 24)
                    : tt.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.16),
            child: Gallery(input: graphic, columns: 4),
          ),
          SizedBox(height: w < defaultBp ? 160 : 320),
          Padding(
            padding: w < defaultBp
                ? const EdgeInsets.symmetric(horizontal: 48)
                : const EdgeInsets.all(0),
            child: Center(
              child: SelectableText(
                videoTitle,
                textAlign: TextAlign.center,
                style: w < defaultBp
                    ? tt.bodyMedium!.copyWith(fontSize: 24)
                    : tt.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.16),
            child: Gallery(input: video, columns: 3),
          ),
          SizedBox(height: w < defaultBp ? 160 : 320),
          Padding(
            padding: w < defaultBp
                ? const EdgeInsets.symmetric(horizontal: 48)
                : const EdgeInsets.all(0),
            child: Center(
              child: SelectableText(
                end,
                textAlign: TextAlign.center,
                style: w < defaultBp
                    ? tt.bodyMedium!.copyWith(fontSize: 24)
                    : tt.bodyMedium,
              ),
            ),
          ),
          SizedBox(height: w < defaultBp ? 160 : 320),
        ],
      ),
    );
  }
}
