import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:realm/realm.dart';

class ImmutableOrderListViewModel2 {
  //This was just to test that this view model doesn't get rebuilt after changes in realm
  int fakeState = 0;

  late Realm realm;
  late RealmResults<RealmOrderItem> items;

  ImmutableOrderListViewModel2(RealmService realmService) {
    realm = realmService.getRealm();
    items = realm.all<RealmOrderItem>();
  }

  double get totalPrice {
    return items.fold(0, (total, element) => total + element.price);
  }

  addItem(RealmOrderItem item) {
    realm.write(() {
      realm.add(item);
    });
  }

  addRandomItem() {
    final randomColorVal = Random().nextInt(Colors.primaries.length);

    final item = RealmOrderItem(Uuid.v4(), "test-$randomColorVal",
        randomColorVal.toDouble(), randomColorVal);

    addItem(item);
  }

  removeItem(RealmOrderItem item) {
    realm.write(() {
      realm.delete(item);
    });
  }
}

final immutableOrderListViewModelProvider2 =
    Provider<ImmutableOrderListViewModel2>((ref) {
  final realmService = ref.watch(realmServiceProvider);
  return ImmutableOrderListViewModel2(realmService);
});
