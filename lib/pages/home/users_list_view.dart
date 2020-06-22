import 'package:flutter/material.dart';
import 'package:typeweight/typeweight.dart';

import 'package:scrapbook/models/models.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/pages/profile.page.dart';

class UsersListView extends StatefulWidget {
  final List<User> users;
  final ScrollController controller;

  const UsersListView({
    Key key,
    @required this.users,
    @required this.controller,
  }) : super(key: key);
  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView>
    with AutomaticKeepAliveClientMixin<UsersListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.users.length,
      itemBuilder: (_, index) {
        final user = widget.users[index];

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
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: theme.dividerColor,
                ),
              ),
            ),
            padding: EdgeInsets.all(
              NavigationToolbar.kMiddleSpacing,
            ),
            child: Row(
              children: <Widget>[
                Container(
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
                SizedBox(
                  width: NavigationToolbar.kMiddleSpacing,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.username,
                      style: ThemedFonts.primary(
                        fontWeight: TypeWeight.medium,
                        fontSize: theme.textTheme.subtitle1.fontSize,
                      ),
                    ),
                    if (user.streakDisplay)
                      Text(
                        '${user.streakCount} days streak',
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
        );
      },
    );
  }
}
