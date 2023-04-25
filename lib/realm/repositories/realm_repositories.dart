import 'package:realm/realm.dart';
import 'package:realm_repo/database/database_crud.dart';
import 'package:realm_repo/realm/crud/realm_crud.dart';

abstract class SingleRealmCRUDRepository<T extends RealmObject> implements SingleCRUD<T>, RealmCRUD<T> {
  SingleRealmCRUDRepository({required Realm realm}) : _realm = realm;

  @override
  RealmResults<T> get items => _realm.all<T>();

  final Realm _realm;

  @override
  Realm get realm => _realm;

  @override
  T? delete() {
    T? t = get();
    realm.write(() => realm.deleteAll<T>());
    return t;
  }

  @override
  T? get() {
    return items.isEmpty ? null : items[0];
  }

  @override
  T save(T t) {
    //open write transaction
    delete();
    return realm.write<T>(() => realm.add<T>(t));
  }

  @override
  void close() {
    realm.close();
  }
}

abstract class CollectionRealmCRUDRepository<T extends RealmObject> implements CollectionCRUD<T>, RealmCRUD<T> {
  CollectionRealmCRUDRepository({required Realm realm}) : _realm = realm;

  final Realm _realm;

  @override
  Realm get realm => _realm;

  @override
  RealmResults<T> get items => _realm.all<T>();

  @override
  List<T> delete(T t) {
    realm.write(() => realm.delete<T>(t));
    return getAll();
  }

  @override
  List<T> deleteAll() {
    realm.write(() => realm.deleteAll<T>());
    return getAll();
  }

  @override
  T? queryOne(String query, {List<Object?> data = const []}) {
    return realm.query<T>(query, data).firstOrNull;
  }

  @override
  List<T> queryMany(String query, {List<Object?> data = const []}) {
    return realm.query<T>(query, data).toList();
  }

  @override
  T get(int index) {
    return getAll()[index];
  }

  @override
  T? findById(ObjectId id) {
    return realm.find(id);
  }

  @override
  List<T> getAll() {
    return items.toList();
  }

  @override
  T save(T t) {
    t = realm.write<T>(() => realm.add<T>(t));
    return t;
  }

  @override
  void saveAll(List<T> t) {
    realm.write(() => realm.addAll<T>(t));
  }

  @override
  List<T> update({required T updatedValue}) {
    realm.write(() => updatedValue);
    return getAll();
  }

  @override
  void close() {
    realm.close();
  }
}
