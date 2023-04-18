# Realm Repo

A flutter project to make realm easy to work with by declaring a database, online or offline, and repositories for single objects and collections

This package just exposes the necessary CRUD functions

Web support is not yet supported as realm doesn't support web 

## Entities
* To create a realm model annotate the class with **@RealmModel** and the name of the class should start 
with an underscore '_' and a primary key annotation **@PrimaryKey** 
* For 

Example

```dart
import 'package:realm/realm.dart';

part 'realm_model_example.g.dart';

@RealmModel()
class _MyRealmObject {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;
}
```

* To Generate build classes use this command and make sure to import part '**$name**.g.dart'

```bash
flutter pub run realm generate
```




### Realm Repositories

RealmRepositories are collections self-contained as a type in the repositories

Just add this import

```dart
import 'package:realm_repo/realm_repo.dart';
```

1. **OnlineValue**
    
* To store a single object in cloud atlas
* FOR OnlineValueRealmRepository YOU SHOULD USE @MapTo('<insert schema name here>')
and should be unique so as not to clash with other schemas

 **Be careful**

Example
```dart
late final OnlineValueRealmRepository<MyRealmObject> myUserDataRepository = 
OnlineValueRealmRepository(appId: appId, user: user, schemas: [MyRealmObject.schema]);
```


2. **OfflineValue**

To store a single object in offline database

Example
```dart
final OfflineValueRealmRepository<MyRealmObject> myUserDataRepository =
OfflineValueRealmRepository(schemas: [MyRealmObject.schema]);
```

3. **OnlineCollection**

To store a collection of object in online database

Example
```dart
late final OnlineCollectionRealmRepository<MyRealmObject> allUserDataRepository = 
OnlineCollectionRealmRepository(appId: appId, user: user, schemas: [MyRealmObject.schema]);
```

4. **OfflineCollection**

To store a collection of objects in offline database

Example
```dart
final OfflineCollectionRealmRepository<MyRealmObject>allUserDataRepository =
OfflineCollectionRealmRepository(schemas: [MyRealmObject.schema]);
```

### Realm Databases

To implement a realm database you can extend the RealmOnlineDatabase or RealmOfflineDatabase in any class and declare
the respective repositories. This gives an advantage as it can make your database flexible in times of dilemma

#### Online:

```dart
class MyOnlineDatabase extends RealmOnlineDatabase {
  MyOnlineDatabase({required super.appId});



  late final OnlineValueRealmRepository<MyRealmObject>
      myUserDataRepository = OnlineValueRealmRepository(
          appId: appId, user: user, schemas: [MyRealmObject.schema]);
  late final OnlineCollectionRealmRepository<MyRealmObject>
      allUserDataRepository = OnlineCollectionRealmRepository(
          appId: appId, user: user, schemas: [MyRealmObject.schema]);
}

Future<void> main () async {
  /// Use online database to store collections and single value objects
  MyOnlineDatabase onlineDb = MyOnlineDatabase(appId: 'Insert APP ID HERE');

  /// Initialize the database
  await onlineDb.init();
}
```


#### Offline:

```dart
/// Same as described in MyOnlineDatabase but without appId
class MyOfflineDatabase extends RealmOfflineDatabase {
  MyOfflineDatabase();

  final OfflineValueRealmRepository<MyRealmObject> myUserDataRepository =
      OfflineValueRealmRepository(schemas: [MyRealmObject.schema]);
  final OfflineCollectionRealmRepository<MyRealmObject>
      allUserDataRepository =
      OfflineCollectionRealmRepository(schemas: [MyRealmObject.schema]);
}


Future<void> main () async {
  
  /// Use offline database to store collections and single value objects
  MyOfflineDatabase offlineDb = MyOfflineDatabase();
  
}
```


#### Schema

```dart

@RealmModel()
class _MyRealmObject {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;

  @override
  int get hashCode => Object.hash(id, name);

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }
}
```