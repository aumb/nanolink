// Generated by Celest. This file should not be modified manually, but
// it can be checked into version control.
// ignore_for_file: type=lint, unused_local_variable, unnecessary_cast, unnecessary_import

library;

import 'dart:io';

import 'package:celest/celest.dart';
import 'package:celest_core/src/util/globals.dart';
import 'package:http/http.dart' as http;

import 'src/client/functions.dart';
import 'src/client/serializers.dart';

final Celest celest = Celest();

class Celest {
  late http.Client httpClient = http.Client();

  late final Uri baseUri = kIsWeb || !Platform.isAndroid
      ? Uri.parse('http://localhost:7779')
      : Uri.parse('http://10.0.2.2:7779');

  final functions = CelestFunctions();

  void init() {
    Serializers.instance.put(const LinkSerializer());
    Serializers.instance.put(const LinkRequestSerializer());
    Serializers.instance.put(const InvalidLinkDataExceptionSerializer());
    Serializers.instance.put(const CreateLinkExceptionSerializer());
    Serializers.instance.put(const DeleteLinkExceptionSerializer());
  }
}
