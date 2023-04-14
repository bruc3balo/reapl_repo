// Crud methods for single object storage
abstract class SingleCRUD<T> {
  T save(T t);
  T? get();
  T? delete();
}

// Crud methods for collection storage
abstract class CollectionCRUD<T> {
  List<T> save(T t);
  List<T> saveAll(List<T> t);

  List<T> getAll();
  T get(int index);

  List<T> update({required dynamic id, required T updatedValue});

  List<T> delete(T t);
  List<T> deleteAll();
}
