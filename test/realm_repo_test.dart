import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:realm_repo/realm_repo.dart';

import '../example/realm_model_example.dart';

/// Same as described in MyOnlineDatabase but without appId
class MyTestDB extends RealmOfflineDatabase {
  MyTestDB();

  final OfflineValueRealmRepository<MyRealmObject> testSingle = OfflineValueRealmRepository(schemas: [MyRealmObject.schema], schemaVersion: 2);
  final OfflineCollectionRealmRepository<MyRealmObject> testCollection = OfflineCollectionRealmRepository(schemas: [MyRealmObject.schema]);

  @override
  void close() {
    testSingle.realm.close();
    testCollection.realm.close();
  }
}

ObjectId testId = ObjectId();
String ogName = "test";

void main() {
  //Create or Insert
  //Single
  crudSingleTest();

  //Collection
  crudCollectionTest();
}

//CRUD TEST
void crudSingleTest() {
  test('crud single test', () {
    MyTestDB db = MyTestDB();
    MyRealmObject obj = MyRealmObject(testId, ogName);

    //Create
    db.testSingle.save(obj);

    //Read
    expect(db.testSingle.get(), obj);

    //Update
    obj.name = "update";
    db.testSingle.save(obj);
    expect(db.testSingle.get(), obj);

    //Delete
    db.testSingle.delete();
    expect(db.testSingle.get(), null);
  });
}

void crudCollectionTest() {
  test('crud collection test', () {
    MyTestDB db = MyTestDB();
    MyRealmObject obj = MyRealmObject(testId, ogName);
    db.testCollection.save(obj);

    // Create
    db.testCollection.save(obj);

    // Read
    expect(db.testCollection.get(0), obj);
    expect(db.testCollection.getAll().length, 1);

    // Update
    obj.name = "update";
    db.testCollection.save(obj);
    expect(db.testCollection.get(0), obj);

    // Delete
    db.testCollection.delete(obj);
    expect(db.testCollection.getAll().length, 0);

    // Save All
    db.testCollection.saveAll([obj, obj, obj]);
    expect(db.testCollection.getAll().length, 3);
    // Delete All
    db.testCollection.deleteAll();
    expect(db.testCollection.getAll().length, 0);
  });
}
