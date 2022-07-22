import 'dart:async';

import 'package:realm/realm.dart';

part 'realm_order_item.g.dart';

//TODO NOTE   late Uuid id = Uuid.v4();
//This cannot be done

@RealmModel()
class _RealmOrderItem {
  @PrimaryKey()
  late Uuid id;

  late String name;
  late double price;
  late int color;
}
