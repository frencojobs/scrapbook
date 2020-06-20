import 'package:mobx/mobx.dart';
import 'package:scrapbook/api/api.dart';
import 'package:scrapbook/models/models.dart';

part 'state.g.dart';

class ScrapbookStore = _ScrapbookStore with _$ScrapbookStore;

abstract class _ScrapbookStore with Store {
  @observable
  List<Post> posts = [];

  @action
  Future<void> loadPosts() async {
    posts = await Api.client.fetchPosts();
  }
}
