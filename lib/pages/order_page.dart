import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String enteredText = ""; //THIS DOES NOT WORK

    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: const Center(
        child: ItemsListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("What are you getting?"),
                content: TextField(
                  onChanged: (value) {
                    enteredText = value;
                  },
                ),
                actions: [
                  Consumer(
                    builder: (context, ref, child) {
                      final item = OrderItem(enteredText, 10);
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                            ref.read(orderProvider.notifier).addMenuItem(item);
                          },
                          child: const Text("Ok"));
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancel")),
                ],
              );
            },
          )
        },
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
