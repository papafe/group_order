import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:realm/realm.dart';

part 'realm_order_item.g.dart';

@RealmModel()
class _RealmOrderItem {
  @PrimaryKey()
  late Uuid id = Uuid.v4();

  late String name;
  late double price;
}

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

  addItem(RealmOrderItem item) {
    realm.write(() {
      realm.add(item);
    });
  }

  addRandomItem() {
    final item = RealmOrderItem("test", 22);
    addItem(item);
  }

  double get totalPrice {
    return items.fold(0, (total, element) => total + element.price);
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
