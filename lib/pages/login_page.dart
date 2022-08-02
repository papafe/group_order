import 'package:flutter/material.dart';
import 'package:group_order/pages/order_page.dart';

//Not used at the moment, could be removed
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Create group order")),
              TextFormField(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderPage()),
                    );
                  },
                  child: const Text("Join")),
            ],
          ),
        ),
      ),
    );
  }
}
