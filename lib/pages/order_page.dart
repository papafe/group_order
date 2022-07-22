import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/order.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:realm/src/results.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListState = ref.watch(orderListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Column(children: [
        Expanded(child: ItemsListView(orderListState)),
        const Divider(height: 4, color: Colors.black),
        ItemsTotalWidget(orderListState.totalPrice)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          orderListState.addRandomItem();
        }),
        child: const Icon(Icons.sms_outlined),
      ),
    );
  }
}

// const Divider(height: 4, color: Colors.black),
// ItemsTotalWidget(orderListState.totalPrice)

//TODO Can probably remove consumer widget
class ItemsListView extends ConsumerWidget {
  final OrderListViewModel orderListViewModel;

  const ItemsListView(this.orderListViewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
        itemCount: orderListViewModel.items.length,
        separatorBuilder: (context, index) => const Divider(height: 2),
        itemBuilder: (context, index) {
          final item = orderListViewModel.items[index];
          return Dismissible(
            key: Key(item.id.toString()),
            onDismissed: ((direction) {}),
            background:
                Container(color: const Color.fromARGB(255, 213, 32, 77)),
            child: ListTile(
              title: Text(item.name),
              trailing: Text(
                item.price.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
            ),
          );
        });
  }
}

class ItemsTotalWidget extends StatelessWidget {
  final double total;
  const ItemsTotalWidget(this.total, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);
    return SizedBox(
      height: 80,
      child: Center(
        child: Text("$total DKK", style: hugeStyle),
      ),
    );
  }
}
