import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:typeweight/typeweight.dart';

import 'package:scrapbook/state/state.dart';
import 'package:scrapbook/theme/fonts.dart';

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
      ),
      body: Observer(
        builder: (_) {
          final posts = _store.posts;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) {
              final post = posts[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          height: 40,
                          width: 40,
                          child: FadeInImage(
                            placeholder: AssetImage('assets/placeholder.png'),
                            image: NetworkImage(
                              post.user.avatar,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: NavigationToolbar.kMiddleSpacing,
                        ),
                        Column(
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
                    SizedBox(
                      height: NavigationToolbar.kMiddleSpacing,
                    ),
                    Text(
                      post.text,
                      style: ThemedFonts.primary(
                        fontSize: theme.textTheme.subtitle1.fontSize,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
