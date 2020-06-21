import 'package:mobx/mobx.dart';
import 'package:scrapbook/api/api.dart';
import 'package:flutter/foundation.dart';

import 'package:scrapbook/models/models.dart';

part 'state.g.dart';

class ScrapbookStore = _ScrapbookStore with _$ScrapbookStore;

abstract class _ScrapbookStore with Store {
  @observable
  bool isPostsLoading = false;

  @observable
  bool isUsersLoading = false;

  @observable
  ObservableList<Post> posts = ObservableList.of([]);

  @observable
  ObservableList<User> users = ObservableList.of([]);

  @action
  Future<void> loadPosts() async {
    isPostsLoading = true;
    final res = await Api.client.fetchPosts();
    if (!listEquals(res, posts)) {
      posts
        ..clear()
        ..addAll(res);
    }
    isPostsLoading = false;
  }

  @action
  Future<void> refreshPosts() async {
    final res = await Api.client.fetchPosts();
    if (!listEquals(res, posts)) {
      posts
        ..clear()
        ..addAll(res);
    }
  }

  @action
  Future<void> loadUsers() async {
    isUsersLoading = true;
    final res = await Api.client.fetchUsers();
    if (!listEquals(res, posts)) {
      users
        ..clear()
        ..addAll(res);
    }
    isUsersLoading = false;
  }

  @action
  Future<void> refreshUsers() async {
    final res = await Api.client.fetchUsers();
    if (!listEquals(res, posts)) {
      users
        ..clear()
        ..addAll(res);
    }
  }
}
