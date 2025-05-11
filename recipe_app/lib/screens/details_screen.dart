import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String itemId;

  const DetailsScreen({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(child: Text('Details for item $itemId')),
    );
  }
}
