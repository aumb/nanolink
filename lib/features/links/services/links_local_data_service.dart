import 'dart:convert';

import 'package:celest_backend/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _linksKey = 'links';

class LinksLocalDataService {
  const LinksLocalDataService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  List<String> get encodedLinks =>
      _sharedPreferences.getStringList(_linksKey) ?? [];

  List<Link> get savedLinks => encodedLinks
      .map((e) => Link.fromJson(jsonDecode(e) as Map<String, dynamic>))
      .toList();

  Future<bool> saveLink(Link link) {
    final links = encodedLinks..insert(0, jsonEncode(link.toJson()));

    return _sharedPreferences.setStringList(_linksKey, links);
  }
}
