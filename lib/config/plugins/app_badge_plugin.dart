import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadgePlugin {
  static Future<bool> isAppBadgeSupported() async {
    return await FlutterAppBadger.isAppBadgeSupported();
  }

  static updateBadge(int count) async {
    if (!await isAppBadgeSupported()) return;

    FlutterAppBadger.updateBadgeCount(count);
  }

  static removeBadge() async {
    if (!await isAppBadgeSupported()) return;

    FlutterAppBadger.removeBadge();
  }
}
