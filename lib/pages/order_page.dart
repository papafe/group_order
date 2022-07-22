import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/order.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:group_order/viewmodel/order_list_view_model.dart';
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemsListView extends StatelessWidget {
  final OrderListViewModel orderListViewModel;

  const ItemsListView(this.orderListViewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: orderListViewModel.items.length,
        separatorBuilder: (context, index) => const Divider(height: 2),
        itemBuilder: (context, index) {
          final item = orderListViewModel.items[index];
          return Dismissible(
            key: Key(item.id.toString()),
            onDismissed: ((direction) {
              orderListViewModel.removeItem(item);
            }),
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(item.name),
              leading: SizedBox(
                width: 30.0,
                height: 30.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.primaries[item.color],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
              trailing: Text(
                item.price.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
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
