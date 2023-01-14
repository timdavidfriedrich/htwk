import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mmgk_portrait/constants/appConstants.dart';
import 'package:mmgk_portrait/constants/source.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Gallery extends StatelessWidget {
  final List input;
  final int columns;
  const Gallery({Key? key, required this.input, this.columns = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MasonryGridView.count(
      crossAxisCount: w < defaultBp ? 1 : columns,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      shrinkWrap: true,
      itemCount: input.length,
      itemBuilder: (context, index) {
        return GalleryItem(input: input, context: context, i: index);
      },
    );
  }
}

class GalleryItem extends StatefulWidget {
  final List input;
  final BuildContext context;
  final int i;
  const GalleryItem(
      {Key? key, required this.input, required this.context, required this.i})
      : super(key: key);

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  List<bool> hover = [];

  @override
  void initState() {
    super.initState();
    hover = List.filled(widget.input.length, false);
  }

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(
          color: cs.onBackground,
          width: w < defaultBp ? 5 : 6,
        ),
      ),
      child: w < defaultBp
          ? InkWell(
              onTap: () => setState(() => hover[widget.i] = !hover[widget.i]),
              child: item(context, widget.input, widget.i, hover))
          : MouseRegion(
              onEnter: (event) => setState(() => hover[widget.i] = true),
              onExit: (event) => setState(() => hover[widget.i] = false),
              child: item(context, widget.input, widget.i, hover),
            ),
    );
  }
}

Widget item(BuildContext context, List input, int i, List hover) {
  var cs = Theme.of(context).colorScheme;
  var tt = Theme.of(context).textTheme;
  return Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(input[i]["thumb"]),
      Opacity(
        opacity: hover[i] ? 0.9 : 0,
        child: Image.asset(
          input[i]["thumb"],
          colorBlendMode: BlendMode.src,
          color: cs.primary,
        ),
      ),
      hover[i]
          ? Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    input[i]["description"],
                    textAlign: TextAlign.center,
                    style: tt.displayMedium,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => GalleryOpen(entry: input[i]),
                    ),
                    child: const Text("Öffnen"),
                  )
                ],
              ),
            )
          : Container(),
    ],
  );
}

class GalleryOpen extends StatelessWidget {
  final Map entry;
  const GalleryOpen({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(24),
            height: h,
            width: w,
            color: const Color.fromARGB(255, 17, 17, 17),
            child: Column(
              children: [
                entry["type"] == "video"
                    ? Flexible(
                        child: YoutubePlayerIFrame(
                          controller: YoutubePlayerController(
                            initialVideoId: entry["source"].split("?v=").last,
                            params: const YoutubePlayerParams(
                              desktopMode: true,
                              showFullscreenButton: true,
                            ),
                          ),
                          //aspectRatio: 16 / 9,
                        ),
                      )
                    : Flexible(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(color: cs.primary),
                            FadeInImage.assetNetwork(
                              placeholder: transparent,
                              image: entry["source"],
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 24),
                SelectableText(
                  entry["description"],
                  style: tt.bodySmall!.copyWith(color: cs.onPrimary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
