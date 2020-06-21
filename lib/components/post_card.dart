import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:typeweight/typeweight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:scrapbook/models/models.dart';
import 'package:scrapbook/helpers/helpers.dart';
import 'package:scrapbook/pages/profile.page.dart';
import 'package:scrapbook/pages/image_view.page.dart';

class PostCardComponent extends StatefulWidget {
  final Post post;
  final User user;
  final int index;

  const PostCardComponent({
    Key key,
    @required this.post,
    @required this.user,
    @required this.index,
  }) : super(key: key);

  @override
  _PostCardComponentState createState() => _PostCardComponentState();
}

class _PostCardComponentState extends State<PostCardComponent>
    with AutomaticKeepAliveClientMixin<PostCardComponent> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final attachments = widget.post.attachments;
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
                  id: widget.index,
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
            AvatarWidget(
              user: widget.user,
              postedAt: widget.post.postedAt,
            ),
            SizedBox(
              height: NavigationToolbar.kMiddleSpacing,
            ),
            MarkdownBody(
              data: widget.post.text,
              fitContent: true,
              onTapLink: (link) {
                launchURL(context, link);
              },
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
                      tag: '${thumbnail.url}-${widget.index}',
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
  }
}

class AvatarWidget extends StatelessWidget {
  final User user;
  final String postedAt;

  const AvatarWidget({
    Key key,
    @required this.user,
    @required this.postedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ProfilePage(
                username: user.username,
              );
            },
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Badge(
            showBadge: user.streakDisplay,
            elevation: 0.0,
            position: BadgePosition.bottomRight(right: 2),
            badgeColor: ThemedColors.red,
            badgeContent: Text(
              '${user.streakCount}',
              style: ThemedFonts.primary(
                fontWeight: TypeWeight.medium,
                color: Colors.white,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(user.streakDisplay ? 2 : 0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: user.streakDisplay
                      ? ThemedColors.red
                      : Colors.transparent,
                  width: 2,
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
                    user.avatar,
                  ),
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
                user.username,
                style: ThemedFonts.primary(
                  fontWeight: TypeWeight.medium,
                  fontSize: theme.textTheme.subtitle1.fontSize,
                ),
              ),
              Text(
                postedAt,
                style: ThemedFonts.primary(
                  color: ThemedColors.textGrey,
                  fontSize: theme.textTheme.subtitle2.fontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
