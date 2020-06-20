import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrapbook/components/action_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(photo),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: ActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: Colors.white,
        ),
        heroAttributes: PhotoViewHeroAttributes(tag: '$photo-$id'),
        imageProvider: NetworkImage(photo),
      ),
    );
  }
}
