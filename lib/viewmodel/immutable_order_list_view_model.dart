import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:realm/realm.dart';

class ImmutableOrderListViewModel {
  late Realm realm;
  late RealmResults<RealmOrderItem> items;

  ImmutableOrderListViewModel(RealmService realmService) {
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

/* Probably this is not a good idea. 
If we save any state in the view model, then it'll be overwritten when there is 
a change in the realm collection
*/
final immutableOrderListViewModelProvider =
    Provider<ImmutableOrderListViewModel>((ref) {
  final realmService = ref.watch(realmServiceProvider);
  //"changes" is used only to trigger the rebuild of the view model after the list has changed
  final changes = ref.watch(menuItemsStreamProvider);
  return ImmutableOrderListViewModel(realmService);
});
