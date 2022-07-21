import 'package:flutter_riverpod/flutter_riverpod.dart';

class Order {
  late List<OrderItem> items;
}

class OrderItem {
  late String name;
  late double price;
  bool paid = false;

  OrderItem(this.name, this.price);
}

class OrderNotifier extends StateNotifier<List<OrderItem>> {
  OrderNotifier() : super(Repository.GetExampleOrder().items);

  void addMenuItem(OrderItem item) {
    state = [...state, item];
  }
}

final orderProvider =
    StateNotifierProvider<OrderNotifier, List<OrderItem>>((ref) {
  return OrderNotifier();
});

class Repository {
  static Order GetExampleOrder() {
    var order = Order();

    order.items = [
      OrderItem("daiquiri", 120),
      OrderItem("beer", 20),
      OrderItem("burger", 40)
    ];

    return order;
  }
}
