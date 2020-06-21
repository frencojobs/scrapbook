import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeweight/typeweight.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:scrapbook/state/state.dart';
import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/components/action_button.dart';

import 'posts_list_view.dart';
import 'users_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _postsScrollController;
  ScrollController _usersScrollController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );

    _postsScrollController = ScrollController(initialScrollOffset: 0.0);
    _usersScrollController = ScrollController(initialScrollOffset: 0.0);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _postsScrollController.dispose();
    _usersScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<ScrapbookStore>(context);

    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Scrapbook',
              style: ThemedFonts.primary(
                fontWeight: TypeWeight.bold,
              ),
            ),
            actions: <Widget>[
              ActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              onTap: (i) {
                if (!_tabController.indexIsChanging) {
                  if (i == 0) {
                    _postsScrollController.animateTo(
                      0,
                      duration: kThemeChangeDuration,
                      curve: Curves.easeIn,
                    );
                  } else {
                    _usersScrollController.animateTo(
                      0,
                      duration: kThemeChangeDuration,
                      curve: Curves.easeIn,
                    );
                  }
                }
              },
              tabs: [
                Tab(
                  child: Text(
                    'Scraps',
                    style: ThemedFonts.primary(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Users',
                    style: ThemedFonts.primary(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Observer(
                builder: (_) {
                  final posts = _store.posts;
                  return RefreshIndicator(
                    onRefresh: _store.refreshPosts,
                    child: PostsListView(
                      controller: _postsScrollController,
                      posts: posts.toList(),
                    ),
                  );
                },
              ),
              Observer(builder: (_) {
                final users = _store.users;

                return RefreshIndicator(
                  onRefresh: _store.refreshUsers,
                  child: UsersListView(
                    controller: _usersScrollController,
                    users: users.toList(),
                  ),
                );
              }),
            ],
          ),
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(
              left: NavigationToolbar.kMiddleSpacing,
              top: MediaQuery.of(context).padding.top,
            ),
            child: Image.asset(
              'assets/flag.png',
              height: kToolbarHeight - NavigationToolbar.kMiddleSpacing / 2,
            ),
          ),
        ),
      ],
    );
  }
}
