// Generated by Celest. This file should not be modified manually, but
// it can be checked into version control.
// ignore_for_file: type=lint, unused_local_variable, unnecessary_cast, unnecessary_import

library;

import 'package:celest/celest.dart';

abstract final class apis {
  static const clicks = CloudApi(name: r'clicks');

  static const links = CloudApi(name: r'links');
}

abstract final class functions {
  static const clicksAddClick = CloudFunction(
    api: r'clicks',
    functionName: r'addClick',
  );

  static const clicksGetClicksNumber = CloudFunction(
    api: r'clicks',
    functionName: r'getClicksNumber',
  );

  static const linksCreateLink = CloudFunction(
    api: r'links',
    functionName: r'createLink',
  );

  static const linksDeleteLink = CloudFunction(
    api: r'links',
    functionName: r'deleteLink',
  );

  static const linksGetLink = CloudFunction(
    api: r'links',
    functionName: r'getLink',
  );

  static const linksGetLinks = CloudFunction(
    api: r'links',
    functionName: r'getLinks',
  );
}

abstract final class env {
  static const supabaseUrl = EnvironmentVariable(name: r'supabaseUrl');

  static const supabaseKey = EnvironmentVariable(name: r'supabaseKey');
}
