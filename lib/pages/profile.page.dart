import 'package:flutter/material.dart';
import 'package:typeweight/typeweight.dart';
import 'package:flutter_icons/flutter_icons.dart' show AntDesign;

import 'package:scrapbook/api/api.dart';
import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/models/models.dart';
import 'package:scrapbook/helpers/helpers.dart';
import 'package:scrapbook/components/post_card.dart';
import 'package:scrapbook/components/action_button.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({
    @required this.username,
    Key key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final future = Api.client.fetchUserByName(widget.username);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: ThemedFonts.primary(
            fontWeight: TypeWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: ActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<UserInfo>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return InkWell(
              onTap: () {
                setState(() {});
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/sad-ginger-cat.png',
                      width: MediaQuery.of(context).size.width / 1.5,
                    ),
                    Text(
                      'Could not fetch the users. Tap to reload.',
                      style: ThemedFonts.primary(
                        fontWeight: FontWeight.bold,
                        fontSize: theme.textTheme.subtitle2.fontSize,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: kToolbarHeight),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      NavigationToolbar.kMiddleSpacing,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.dividerColor,
                          ),
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FadeInImage(
                              placeholder: AssetImage(
                                'assets/placeholder.png',
                              ),
                              image: NetworkImage(
                                user.profile.avatar,
                              ),
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
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
                              user.profile.username,
                              style: ThemedFonts.primary(
                                fontSize: theme.textTheme.headline6.fontSize,
                                fontWeight: TypeWeight.bold,
                                color: theme.textTheme.subtitle1.color,
                              ),
                            ),
                            if (user.profile.streakDisplay != null &&
                                user.profile.streakDisplay)
                              Text(
                                '${user.profile.streakCount} ${user.profile.streakCount > 1 ? 'days' : 'day'} streak',
                                style: ThemedFonts.primary(
                                  fontSize: theme.textTheme.subtitle2.fontSize,
                                  fontWeight: TypeWeight.medium,
                                  color: theme.hintColor,
                                ),
                              ),
                            SizedBox(
                              height: NavigationToolbar.kMiddleSpacing / 2,
                            ),
                            if (user.profile.website != null)
                              InkWell(
                                onTap: () {
                                  launchURL(context, user.profile.website);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width -
                                      (4 * NavigationToolbar.kMiddleSpacing) -
                                      80,
                                  child: Text(
                                    '${user.profile.website}',
                                    style: ThemedFonts.primary(
                                      fontSize:
                                          theme.textTheme.subtitle2.fontSize,
                                      fontWeight: TypeWeight.medium,
                                      color: Colors.blueAccent,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NavigationToolbar.kMiddleSpacing,
                    ),
                    child: Row(
                      children: [
                        RaisedButton.icon(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            launchURL(
                              context,
                              'https://app.slack.com/client/T0266FRGM/user_profile/${user.profile.slack}',
                            );
                          },
                          icon: Icon(
                            AntDesign.slack,
                            size: theme.textTheme.headline6.fontSize,
                          ),
                          label: Text(
                            'Slack',
                            style: ThemedFonts.primary(
                              fontSize: theme.textTheme.subtitle1.fontSize,
                              fontWeight: TypeWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: NavigationToolbar.kMiddleSpacing,
                        ),
                        RaisedButton.icon(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            launchURL(context, user.profile.github);
                          },
                          icon: Icon(
                            AntDesign.github,
                            size: theme.textTheme.headline6.fontSize,
                          ),
                          label: Text(
                            'GitHub',
                            style: ThemedFonts.primary(
                              fontSize: theme.textTheme.subtitle1.fontSize,
                              fontWeight: TypeWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: NavigationToolbar.kMiddleSpacing,
                  ),
                  Container(
                    height: 1,
                    color: theme.dividerColor,
                  ),
                  ...user.posts.asMap().entries.map((entry) {
                    final index = entry.key;
                    final post = entry.value;

                    return PostCardComponent(
                      post: post,
                      user: user.profile,
                      index: index,
                    );
                  }).toList(),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
