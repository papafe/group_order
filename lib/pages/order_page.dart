import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: const Center(
        child: ItemsListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {}),
        child: const Icon(Icons.sms_outlined),
      ),
    );
  }
}

class ItemsListView extends ConsumerWidget {
  const ItemsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(orderProvider);

    return ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 2),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
          );
        });
  }
}
