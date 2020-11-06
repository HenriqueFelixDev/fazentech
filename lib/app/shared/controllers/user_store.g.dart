// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  final _$userAtom = Atom(name: '_UserStoreBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_UserStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_getSignedUserAsyncAction =
      AsyncAction('_UserStoreBase._getSignedUser');

  @override
  Future<void> _getSignedUser() {
    return _$_getSignedUserAsyncAction.run(() => super._getSignedUser());
  }

  final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_UserStoreBase.signInWithEmailAndPassword');

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _$signInWithEmailAndPasswordAsyncAction
        .run(() => super.signInWithEmailAndPassword(email, password));
  }

  final _$signOutAsyncAction = AsyncAction('_UserStoreBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$signUpWithEmailAndPasswordAsyncAction =
      AsyncAction('_UserStoreBase.signUpWithEmailAndPassword');

  @override
  Future<void> signUpWithEmailAndPassword(UserModel user) {
    return _$signUpWithEmailAndPasswordAsyncAction
        .run(() => super.signUpWithEmailAndPassword(user));
  }

  final _$updateUserAsyncAction = AsyncAction('_UserStoreBase.updateUser');

  @override
  Future<void> updateUser(UserModel user) {
    return _$updateUserAsyncAction.run(() => super.updateUser(user));
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoading: ${isLoading}
    ''';
  }
}
