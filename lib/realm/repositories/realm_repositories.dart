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
    _realm.deleteAll();
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
    realm.write(() => realm.add(t));
    return t;
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
    realm.delete(t);
    return getAll();
  }

  @override
  List<T> deleteAll() {
    realm.deleteAll();
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
    realm.write(() => realm.add(t));
    return getAll();
  }

  @override
  List<T> saveAll(List<T> t) {
    realm.write(() => realm.addAll(t));
    return getAll();
  }

  @override
  List<T> update({required int index, required T updated}) {
    return getAll();
  }
}
