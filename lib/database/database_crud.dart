// Crud methods for single object storage
import 'package:realm/realm.dart';

abstract class SingleCRUD<T> {
  T save(T t);
  T? get();
  T? delete();
}

// Crud methods for collection storage
abstract class CollectionCRUD<T> {
  T save(T t);
  void saveAll(List<T> t);

  List<T> getAll();
  T? get(int index);
  T? findById(ObjectId id);

  T? queryOne(String query, {List<Object?> data = const []});
  List<T> queryMany(String query, {List<Object?> data = const []});

  List<T> update({required T updatedValue});

  List<T> delete(T t);
  List<T> deleteAll();
}
