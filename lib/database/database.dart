import 'package:realm/realm.dart';

abstract class OfflineRealmDatabase {}

abstract class OnlineRealmDatabase {
  Future<void> init();
  String get appId;
  User get user;
  App get app;
}
