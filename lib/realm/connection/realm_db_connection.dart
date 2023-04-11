// Provides variables for connecting realm online
import 'package:realm/realm.dart';

abstract class OnlineRealmConnection {
  String get appId;
  User get user;
  void subscriptions();
}
