import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrapbook/components/action_button.dart';
import 'package:scrapbook/theme/fonts.dart';

class ImageViewPage extends StatelessWidget {
  final String photo;
  final int id;
  const ImageViewPage({
    @required this.photo,
    @required this.id,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          photo,
          style: ThemedFonts.primary(
            fontSize: theme.textTheme.headline6.fontSize,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: ActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        heroAttributes: PhotoViewHeroAttributes(tag: '$photo-$id'),
        imageProvider: NetworkImage(photo),
      ),
    );
  }
}
