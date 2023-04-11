import 'package:realm/realm.dart';

part 'realm_model_example.g.dart';

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
