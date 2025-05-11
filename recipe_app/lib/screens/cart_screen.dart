import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<String> cartItems = ['Spaghetti', 'Tacos'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Dismissible(
            key: Key(item),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {},
            background: Container(color: Colors.red, alignment: Alignment.centerRight, child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            )),
            child: ListTile(title: Text(item)),
          );
        },
      ),
    );
  }
}
