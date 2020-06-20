import 'package:mobx/mobx.dart';
import 'package:scrapbook/api/api.dart';
import 'package:flutter/foundation.dart';

import 'package:scrapbook/models/models.dart';

part 'state.g.dart';

class ScrapbookStore = _ScrapbookStore with _$ScrapbookStore;

abstract class _ScrapbookStore with Store {
  @observable
  bool isLoading = false;

  @observable
  ObservableList<Post> posts = ObservableList.of([]);

  @action
  Future<void> loadPosts() async {
    isLoading = true;
    final res = await Api.client.fetchPosts();
    if (!listEquals(res, posts)) {
      posts
        ..clear()
        ..addAll(res);
    }
    isLoading = false;
  }
}
