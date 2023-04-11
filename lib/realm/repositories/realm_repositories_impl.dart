import 'package:realm/realm.dart';
import 'package:realm_repo/realm/connection/realm_db_connection.dart';
import 'package:realm_repo/realm/repositories/realm_repositories.dart';

/// SINGLE //

//Single Online
class OnlineValueRealmRepository<T extends RealmObject>
    extends SingleRealmCRUDRepository<T> implements OnlineRealmConnection {
  OnlineValueRealmRepository(
      {required String appId,
      required User user,
      required List<SchemaObject> schemas})
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
      mutableSubscriptions.add(realm.all<T>());
    });
  }
}

//Single Offline
class OfflineValueRealmRepository<T extends RealmObject>
    extends SingleRealmCRUDRepository<T> {
  OfflineValueRealmRepository({required List<SchemaObject> schemas})
      : super(realm: Realm(Configuration.local(schemas)));
}

/// COLLECTION //

// Collection Online
class OnlineCollectionRealmRepository<T extends RealmObject>
    extends CollectionRealmCRUDRepository<T> implements OnlineRealmConnection {
  OnlineCollectionRealmRepository(
      {required String appId,
      required User user,
      required List<SchemaObject> schemas})
      : _appId = appId,
        _user = user,
        super(realm: Realm(Configuration.local(schemas))) {
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
class OfflineCollectionRealmRepository<T extends RealmObject>
    extends CollectionRealmCRUDRepository<T> {
  OfflineCollectionRealmRepository({required List<SchemaObject> schemas})
      : super(realm: Realm(Configuration.local(schemas)));
}
