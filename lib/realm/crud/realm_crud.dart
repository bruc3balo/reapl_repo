import 'package:realm/realm.dart';

/// CRUD realm implementation
abstract class RealmCRUD<T extends RealmObject> {
  Realm get realm;
  RealmResults<T> get items;
  void close();
}
