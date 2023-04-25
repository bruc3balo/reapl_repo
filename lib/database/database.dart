import 'package:realm/realm.dart';

abstract class OfflineRealmDatabase {
  void close();
}

abstract class OnlineRealmDatabase {
  Future<void> init();
  void close();
  String get appId;
  User get user;
  App get app;
}
