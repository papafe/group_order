// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_order_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmOrderItem extends _RealmOrderItem with RealmEntity, RealmObject {
  RealmOrderItem(
    Uuid id,
    String name,
    double price,
    int color,
  ) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'price', price);
    RealmObject.set(this, 'color', color);
  }

  RealmOrderItem._();

  @override
  Uuid get id => RealmObject.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  double get price => RealmObject.get<double>(this, 'price') as double;
  @override
  set price(double value) => RealmObject.set(this, 'price', value);

  @override
  int get color => RealmObject.get<int>(this, 'color') as int;
  @override
  set color(int value) => RealmObject.set(this, 'color', value);

  @override
  Stream<RealmObjectChanges<RealmOrderItem>> get changes =>
      RealmObject.getChanges<RealmOrderItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RealmOrderItem._);
    return const SchemaObject(RealmOrderItem, 'RealmOrderItem', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.double),
      SchemaProperty('color', RealmPropertyType.int),
    ]);
  }
}
