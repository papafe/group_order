import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_order/model/realm_order_item.dart';
import 'package:realm/realm.dart';

class RealmService {
  Realm getRealm() {
    var config = Configuration.local([RealmOrderItem.schema]);
    return Realm(config);
  }
}

var realmServiceProvider = Provider((ref) => RealmService());

final menuItemsStreamProvider = StreamProvider((ref) {
  final realm = ref.watch(realmServiceProvider).getRealm();
  return realm.all<RealmOrderItem>().changes;
});
