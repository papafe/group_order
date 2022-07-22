import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:realm/realm.dart';

class OrderListViewModel extends ChangeNotifier {
  late Realm realm;
  late RealmResults<RealmOrderItem> items;
  late StreamSubscription _subscription;

  OrderListViewModel(RealmService realmService) {
    realm = realmService.getRealm();
    items = realm.all<RealmOrderItem>();
    _subscription = items.changes.listen((event) {
      notifyListeners();
    });
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

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final orderListViewModelProvider =
    ChangeNotifierProvider<OrderListViewModel>((ref) {
  final realmService = ref.watch(realmServiceProvider);
  return OrderListViewModel(realmService);
});
