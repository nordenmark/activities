import 'dart:io' as io show Platform;
import 'package:app/models/user.model.dart';
import 'package:app/storage/native_storage_service.dart';

import 'package:app/auth/tokens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'local_storage_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  BaseStorageService storage;

  bool isWeb;

  try {
    if (io.Platform.isIOS || io.Platform.isAndroid) {
      isWeb = false;
    } else {
      isWeb = true;
    }
  } catch (e) {
    isWeb = true;
  }

  if (isWeb) {
    storage = LocalStorageService();
  } else {
    storage = NativeStorageService(FlutterSecureStorage());
  }

  return StorageService(storage);
});

abstract class BaseStorageService {
  dynamic get(String key);
  set(String key, Map data);
  delete(String key);
}

class StorageService {
  final String _refreshTokenKey = 'WORKOUT_REFRESH_TOKEN_KEY';
  final String _accessTokenKey = 'WORKOUT_ACCESS_TOKEN_KEY';
  final String _userKey = 'WORKOUT_USER_KEY';

  final BaseStorageService storage;

  StorageService(this.storage);

  Future<Token> getRefreshToken() async {
    dynamic json = await storage.get(this._refreshTokenKey);

    if (json == null) {
      return null;
    }

    try {
      return Token.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<Token> getAccessToken() async {
    dynamic json = await storage.get(this._accessTokenKey);

    if (json == null) {
      return null;
    }

    try {
      return Token.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<User> getUser() async {
    dynamic json = await storage.get(this._userKey);

    if (json == null) {
      return null;
    }

    try {
      return User.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  clear() async {
    await this.storage.delete(this._refreshTokenKey);
    await this.storage.delete(this._accessTokenKey);
    await this.storage.delete(this._userKey);
  }

  setRefreshToken(Token token) async {
    Map json = token.toJson();

    return this.storage.set(this._refreshTokenKey, json);
  }

  setAccessToken(Token token) async {
    Map json = token.toJson();

    return this.storage.set(this._accessTokenKey, json);
  }

  setUser(User user) async {
    Map json = user.toJson();

    return this.storage.set(this._userKey, json);
  }
}
