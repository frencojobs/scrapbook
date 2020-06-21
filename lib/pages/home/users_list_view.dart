import 'package:flutter/material.dart';

import 'package:scrapbook/models/models.dart';

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
    return ListView.builder();
  }
}
