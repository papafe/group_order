// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_order_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmOrderItem extends _RealmOrderItem with RealmEntity, RealmObject {
  RealmOrderItem(
    String name,
    double price,
  ) {
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'price', price);
  }

  RealmOrderItem._();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  double get price => RealmObject.get<double>(this, 'price') as double;
  @override
  set price(double value) => RealmObject.set(this, 'price', value);

  @override
  Stream<RealmObjectChanges<RealmOrderItem>> get changes =>
      RealmObject.getChanges<RealmOrderItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RealmOrderItem._);
    return const SchemaObject(RealmOrderItem, 'RealmOrderItem', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.double),
    ]);
  }
}
