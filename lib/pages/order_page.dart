import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/order.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:group_order/service/realm_service.dart';
import 'package:group_order/viewmodel/immutable_order_list_view_model.dart';
import 'package:group_order/viewmodel/immutable_v2.dart';
import 'package:group_order/viewmodel/order_list_view_model.dart';
import 'package:realm/src/results.dart';

/* Summing up:

- The viewModel that uses ChangeProvider is probably the one that feels the most
natural to me. We just force an update when we need
- The first immutable version definitely works, and it's a 1-to-1 substitution in 
the ui (this page). The issue is that the view model depends on the changes stream,
so it gets rebuilt every time there is a change in the realm collection. This means
that we can't keep state in the view model, otherwise it gets overwritten all the time
- The second immutable version makes more sense, because the view model is independent from
the changes in the collection. But in order to make this work we need to add
a watch to the menuItemsStreamProvider in the view, so that it gets redrawn on change
of the collection, while the view model is the same. This can be verified by 
modifying the value of "fakeState" and printing it.

Considerations
- This still feels kinda awkward, but it seems a common issue with state management
in flutter anyways
- If realm provided a stream that would contain not only the changes, but the new 
collection too, then for simple cases we could just make a stream provider and use that
in the view, without the need to do like in v2 (where we need to have 2 providers necessarily,
one for the update and one for the current state). Maybe if it provided the realm too, then we'd
be golden, because almost everything realm related can be done with that.
- Probably the realm provider should have the .autoDispose modifier
- Using the .family modifier probably we can make the stream provider for collection
more generic (so we avoid creating n+1 providers for different collections and 
filters).

*/

class OrderPage extends ConsumerWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //This is to trigger redraw when the list changes and it's not necessary with the other immutable version
    ref.watch(menuItemsStreamProvider);
    final orderListState = ref.watch(immutableOrderListViewModelProvider2);

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
  final ImmutableOrderListViewModel2 orderListViewModel;

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
