// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_model_example.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class MyRealmObject extends _MyRealmObject
    with RealmEntity, RealmObjectBase, RealmObject {
  MyRealmObject(
    ObjectId id,
    String name,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  MyRealmObject._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<MyRealmObject>> get changes =>
      RealmObjectBase.getChanges<MyRealmObject>(this);

  @override
  MyRealmObject freeze() => RealmObjectBase.freezeObject<MyRealmObject>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MyRealmObject._);
    return const SchemaObject(
        ObjectType.realmObject, MyRealmObject, 'MyRealmObject', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}
