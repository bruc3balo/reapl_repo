library realm_repo;

import 'package:realm/realm.dart';

import 'database/database.dart';

///Realm offline database implementation of OfflineRealmDatabase
abstract class RealmOfflineDatabase implements OfflineRealmDatabase {
  const RealmOfflineDatabase();
}

///Realm online database implementation of OnlineRealmDatabase
abstract class RealmOnlineDatabase implements OnlineRealmDatabase {
  RealmOnlineDatabase({required String appId}) : _appId = appId;

  @override
  Future<void> init() async {
    _app = App(AppConfiguration(_appId));
    _user = app.currentUser != null
        ? app.currentUser!
        : await app.logIn(Credentials.anonymous());
  }

  //App Id
  final String _appId;

  @override
  String get appId => _appId;

  //App
  late final App _app;

  @override
  App get app => _app;

  //User
  late final User _user;

  @override
  User get user => _user;
}
