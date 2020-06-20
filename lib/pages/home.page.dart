import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeweight/typeweight.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:scrapbook/state/state.dart';
import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:scrapbook/components/action_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<ScrapbookStore>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Scrapbook',
          style: ThemedFonts.primary(
            fontWeight: TypeWeight.bold,
          ),
        ),
        actions: <Widget>[
          ActionButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final posts = _store.posts;
          return RefreshIndicator(
            onRefresh: _store.loadPosts,
            displacement: 1,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, index) {
                final post = posts[index];
                final attachments = post.attachments;
                final thumbnails =
                    attachments.where((a) => a.thumbnails != null);
                final thumbnail =
                    thumbnails.isNotEmpty ? thumbnails.first : null;
                final thumbnailWidth = MediaQuery.of(context).size.width -
                    NavigationToolbar.kMiddleSpacing * 2;

                return InkWell(
                  onTap: () {},
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  placeholder:
                                      AssetImage('assets/placeholder.png'),
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
                                    fontSize:
                                        theme.textTheme.subtitle1.fontSize,
                                  ),
                                ),
                                Text(
                                  post.postedAt,
                                  style: ThemedFonts.primary(
                                    color: ThemedColors.textGrey,
                                    fontSize:
                                        theme.textTheme.subtitle2.fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
