import 'dart:convert';

import 'package:app/storage/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NativeStorageService implements BaseStorageService {
  final FlutterSecureStorage _storage;

  NativeStorageService(this._storage);

  @override
  delete(String key) {
    return this._storage.delete(key: key);
  }

  @override
  dynamic get(String key) async {
    try {
      var string = await this._storage.read(key: key);
      return jsonDecode(string);
    } catch (e) {
      return null;
    }
  }

  @override
  set(String key, Map data) {
    var string = jsonEncode(data);

    return this._storage.write(key: key, value: string);
  }
}
