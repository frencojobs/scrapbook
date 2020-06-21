import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:scrapbook/pages/profile.page.dart';
import 'package:typeweight/typeweight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:scrapbook/models/models.dart';
import 'package:scrapbook/pages/image_view.page.dart';

class PostsListView extends StatefulWidget {
  final List<Post> posts;
  final ScrollController controller;

  const PostsListView({
    Key key,
    @required this.posts,
    @required this.controller,
  }) : super(key: key);

  @override
  _PostsListViewState createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView>
    with AutomaticKeepAliveClientMixin<PostsListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.posts.length,
      itemBuilder: (_, index) {
        final post = widget.posts[index];
        final attachments = post.attachments;
        final thumbnails = attachments.where((a) => a.thumbnails != null);
        final thumbnail = thumbnails.isNotEmpty ? thumbnails.first : null;
        final thumbnailWidth = MediaQuery.of(context).size.width -
            NavigationToolbar.kMiddleSpacing * 2;

        return InkWell(
          onTap: () {
            if (thumbnail != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) {
                    return ImageViewPage(
                      photo: thumbnail.url,
                      id: index,
                    );
                  },
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300],
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.all(
              NavigationToolbar.kMiddleSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ProfilePage();
                        },
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Badge(
                        showBadge: post.user.streakDisplay,
                        elevation: 1.0,
                        position: BadgePosition.bottomRight(right: -3),
                        badgeColor: ThemedColors.yellow,
                        badgeContent: Text(
                          '${post.user.streakCount}',
                          style: ThemedFonts.primary(
                            fontWeight: TypeWeight.medium,
                          ),
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          height: 40,
                          width: 40,
                          child: FadeInImage(
                            placeholder: AssetImage(
                              'assets/placeholder.png',
                            ),
                            image: NetworkImage(
                              post.user.avatar,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: NavigationToolbar.kMiddleSpacing,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            post.user.username,
                            style: ThemedFonts.primary(
                              fontWeight: TypeWeight.medium,
                              fontSize: theme.textTheme.subtitle1.fontSize,
                            ),
                          ),
                          Text(
                            post.postedAt,
                            style: ThemedFonts.primary(
                              color: ThemedColors.textGrey,
                              fontSize: theme.textTheme.subtitle2.fontSize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: NavigationToolbar.kMiddleSpacing,
                ),
                MarkdownBody(
                  data: post.text,
                  fitContent: true,
                  styleSheet: MarkdownStyleSheet.fromTheme(theme)
                      .copyWith(p: theme.textTheme.subtitle1),
                ),
                thumbnail != null
                    ? SizedBox(
                        height: NavigationToolbar.kMiddleSpacing,
                      )
                    : SizedBox.shrink(),
                thumbnail != null
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(1),
                        child: Hero(
                          tag: '${thumbnail.url}-$index',
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: thumbnailWidth,
                            height: thumbnailWidth * (9 / 16),
                            child: FadeInImage(
                              placeholder: AssetImage(
                                'assets/placeholder.png',
                              ),
                              image: NetworkImage(
                                thumbnail.thumbnails.full.url,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
