library realm_repo;

import 'package:realm/realm.dart';

import 'database/database.dart';

import 'package:realm_repo/realm/connection/realm_db_connection.dart';
import 'package:realm_repo/realm/repositories/realm_repositories.dart';

/// SINGLE REPOSITORIES ///

//Single Online
class OnlineValueRealmRepository<T extends RealmObject> extends SingleRealmCRUDRepository<T> implements OnlineRealmConnection {
  OnlineValueRealmRepository({required String appId, required User user, required List<SchemaObject> schemas})
      : _appId = appId,
        _user = user,
        super(realm: Realm(Configuration.flexibleSync(user, schemas))) {
    subscriptions();
  }

  //App Id
  final String _appId;

  @override
  String get appId => _appId;

  //User
  final User _user;

  @override
  User get user => _user;

  //Subscriptions
  @override
  void subscriptions() {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add<T>(realm.all<T>());
    });
  }
}

//Single Offline
class OfflineValueRealmRepository<T extends RealmObject> extends SingleRealmCRUDRepository<T> {
  OfflineValueRealmRepository({required List<SchemaObject> schemas, required int schemaVersion}) : super(realm: Realm(Configuration.local(schemas, schemaVersion: schemaVersion)));
}

/// COLLECTION REPOSITORIES ///

// Collection Online
class OnlineCollectionRealmRepository<T extends RealmObject> extends CollectionRealmCRUDRepository<T> implements OnlineRealmConnection {
  OnlineCollectionRealmRepository({required String appId, required User user, required List<SchemaObject> schemas})
      : _appId = appId,
        _user = user,
        super(realm: Realm(Configuration.flexibleSync(user, schemas))) {
    subscriptions();
  }

  //App Id
  final String _appId;

  @override
  String get appId => _appId;

  //User
  final User _user;

  @override
  User get user => _user;

  @override
  void subscriptions() {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<T>());
    });
  }
}

// Collection Offline
class OfflineCollectionRealmRepository<T extends RealmObject> extends CollectionRealmCRUDRepository<T> {
  OfflineCollectionRealmRepository({required List<SchemaObject> schemas}) : super(realm: Realm(Configuration.local(schemas)));
}

/// DATABASES ///

//Realm offline database implementation of OfflineRealmDatabase
abstract class RealmOfflineDatabase implements OfflineRealmDatabase {
  const RealmOfflineDatabase();
}

//Realm online database implementation of OnlineRealmDatabase
abstract class RealmOnlineDatabase implements OnlineRealmDatabase {
  RealmOnlineDatabase({required String appId}) : _appId = appId;

  @override
  Future<void> init() async {
    _app = App(AppConfiguration(_appId));
    _user = app.currentUser != null ? app.currentUser! : await app.logIn(Credentials.anonymous());
    var state = _user.state;
    print('State : ${state.name}');
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

  User switchUser(User user) {
    _user = user;
    _app.switchUser(user);
    return user;
  }

  @override
  User get user => _user;
}
