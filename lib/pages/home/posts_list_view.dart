import 'package:flutter/material.dart';

import 'package:scrapbook/models/models.dart';
import 'package:scrapbook/components/post_card.dart';

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
    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.posts.length,
      itemBuilder: (_, index) {
        final post = widget.posts[index];

        return PostCardComponent(
          post: post,
          user: post.user,
          index: index,
        );
      },
    );
  }
}
