import 'package:realm/realm.dart';
import 'package:realm_repo/realm/repositories/realm_repositories_impl.dart';
import 'package:realm_repo/realm_repo.dart';

import 'realm_model_example.dart';

/*@RealmModel()
class MyRealmObject {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;
}*/

Future<void> main() async {
  ObjectId id = ObjectId();
  String name = "Realm Object";
  MyRealmObject realmObj = MyRealmObject(id, name);

  //Online Db
  /// Use online database to store collections and single value objects
  MyOnlineDatabase onlineDb = MyOnlineDatabase(appId: 'Insert APP ID HERE');

  /// Initialize the database
  await onlineDb.init();

  //Create
  /// Save a single object as only value
  onlineDb.myUserDataRepository.save(realmObj);

  /// Save an object in collection
  onlineDb.allUserDataRepository.save(realmObj);

  /// Save a list of objects in collection
  onlineDb.allUserDataRepository.saveAll([realmObj, realmObj, realmObj]);

  //Read
  /// Get value of single object stored
  onlineDb.myUserDataRepository.get();

  ///Find by index in collection
  onlineDb.allUserDataRepository.get(0);

  /// Find all in collection
  onlineDb.allUserDataRepository.getAll();

  //Offline DB
  /// Use offline database to store collections and single value objects
  MyOfflineDatabase offlineDb = MyOfflineDatabase();

  //Update
  realmObj.name = "Realm Object 2";

  /// Update value of single object
  offlineDb.myUserDataRepository.save(realmObj);

  /// Update value of object as it has same id in collection
  offlineDb.allUserDataRepository.save(realmObj);

  /// Update list of objects as they have the same ids in collection
  offlineDb.allUserDataRepository.saveAll([realmObj]);

  //Delete
  /// Delete value of single object
  offlineDb.myUserDataRepository.delete();

  /// Delete object in collection
  offlineDb.allUserDataRepository.delete(realmObj);

  /// Delete all values in collection
  offlineDb.allUserDataRepository.deleteAll();
}

/// How to implement the realm online database
/// Just extend the RealmOnlineDB class and provide the appId
/// Simple addon to your existing database
/// Then declare your repositories
class MyOnlineDatabase extends RealmOnlineDatabase {
  MyOnlineDatabase({required super.appId});

  late final OnlineValueRealmRepository<MyRealmObject> myUserDataRepository =
      OnlineValueRealmRepository(
          appId: appId, user: user, schemas: [MyRealmObject.schema]);
  late final OnlineCollectionRealmRepository<MyRealmObject>
      allUserDataRepository = OnlineCollectionRealmRepository(
          appId: appId, user: user, schemas: [MyRealmObject.schema]);
}

/// Same as described in MyOnlineDatabase but without appId
class MyOfflineDatabase extends RealmOfflineDatabase {
  MyOfflineDatabase();

  final OfflineValueRealmRepository<MyRealmObject> myUserDataRepository =
      OfflineValueRealmRepository(schemas: [MyRealmObject.schema]);
  final OfflineCollectionRealmRepository<MyRealmObject> allUserDataRepository =
      OfflineCollectionRealmRepository(schemas: [MyRealmObject.schema]);
}
