// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScrapbookStore on _ScrapbookStore, Store {
  final _$isPostsLoadingAtom = Atom(name: '_ScrapbookStore.isPostsLoading');

  @override
  bool get isPostsLoading {
    _$isPostsLoadingAtom.reportRead();
    return super.isPostsLoading;
  }

  @override
  set isPostsLoading(bool value) {
    _$isPostsLoadingAtom.reportWrite(value, super.isPostsLoading, () {
      super.isPostsLoading = value;
    });
  }

  final _$isUsersLoadingAtom = Atom(name: '_ScrapbookStore.isUsersLoading');

  @override
  bool get isUsersLoading {
    _$isUsersLoadingAtom.reportRead();
    return super.isUsersLoading;
  }

  @override
  set isUsersLoading(bool value) {
    _$isUsersLoadingAtom.reportWrite(value, super.isUsersLoading, () {
      super.isUsersLoading = value;
    });
  }

  final _$postsAtom = Atom(name: '_ScrapbookStore.posts');

  @override
  ObservableList<Post> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<Post> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  final _$usersAtom = Atom(name: '_ScrapbookStore.users');

  @override
  ObservableList<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$loadPostsAsyncAction = AsyncAction('_ScrapbookStore.loadPosts');

  @override
  Future<void> loadPosts() {
    return _$loadPostsAsyncAction.run(() => super.loadPosts());
  }

  final _$refreshPostsAsyncAction = AsyncAction('_ScrapbookStore.refreshPosts');

  @override
  Future<void> refreshPosts() {
    return _$refreshPostsAsyncAction.run(() => super.refreshPosts());
  }

  final _$loadUsersAsyncAction = AsyncAction('_ScrapbookStore.loadUsers');

  @override
  Future<void> loadUsers() {
    return _$loadUsersAsyncAction.run(() => super.loadUsers());
  }

  final _$refreshUsersAsyncAction = AsyncAction('_ScrapbookStore.refreshUsers');

  @override
  Future<void> refreshUsers() {
    return _$refreshUsersAsyncAction.run(() => super.refreshUsers());
  }

  @override
  String toString() {
    return '''
isPostsLoading: ${isPostsLoading},
isUsersLoading: ${isUsersLoading},
posts: ${posts},
users: ${users}
    ''';
  }
}
