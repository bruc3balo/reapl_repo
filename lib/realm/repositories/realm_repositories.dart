import 'package:realm/realm.dart';
import 'package:realm_repo/database/database_crud.dart';
import 'package:realm_repo/realm/crud/realm_crud.dart';

abstract class SingleRealmCRUDRepository<T extends RealmObject>
    implements SingleCRUD<T>, RealmCRUD<T> {
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
}

abstract class CollectionRealmCRUDRepository<T extends RealmObject>
    implements CollectionCRUD<T>, RealmCRUD<T> {
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
  T get(int index) {
    return getAll()[index];
  }

  @override
  List<T> getAll() {
    return items.toList();
  }

  @override
  List<T> save(T t) {
    realm.write<T>(() => realm.add<T>(t));
    return getAll();
  }

  @override
  List<T> saveAll(List<T> t) {
    realm.write(() => realm.addAll<T>(t));
    return getAll();
  }

  @override
  List<T> update({required dynamic id, required T updatedValue}) {
    RealmObject? obj = realm.find(id);
    if (obj == null) throw RealmException("Object of id $id not found");

    realm.write(() => realm.add<T>(updatedValue, update: true));

    return getAll();
  }
}
