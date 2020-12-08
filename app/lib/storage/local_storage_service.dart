import 'dart:convert';

import 'package:app/storage/storage_service.dart';
import 'package:universal_html/html.dart';

class LocalStorageService implements BaseStorageService {
  @override
  delete(String key) {
    return window.localStorage.remove(key);
  }

  @override
  Map get(String key) {
    try {
      var string = window.localStorage[key];
      return jsonDecode(string);
    } catch (e) {
      return null;
    }
  }

  @override
  set(String key, Map data) {
    var string = jsonEncode(data);
    return window.localStorage[key] = string;
  }
}
