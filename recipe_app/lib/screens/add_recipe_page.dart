import 'package:flutter/material.dart';

class AddRecipePage extends StatelessWidget {
  const AddRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Recipe name')),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Image path')),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Ingredients')),
          ],
        ),
      ),
    );
  }
}
