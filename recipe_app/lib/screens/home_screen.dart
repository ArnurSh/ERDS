import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> mockItems = [
    {
      'id': '1',
      'title': 'Spaghetti',
      'description': 'Classic Italian pasta.',
      'image': 'assets/spaghetti.jpg'
    },
    {
      'id': '2',
      'title': 'Tacos',
      'description': 'Mexican delight.',
      'image': 'assets/taco_salad.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: ListView.builder(
        itemCount: mockItems.length,
        itemBuilder: (context, index) {
          final item = mockItems[index];
          return GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => _ItemDetailsSheet(item: item),
            ),
            onDoubleTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${item['title']} liked!')),
            ),
            child: Card(
              child: ListTile(
                leading: Image.asset(item['image']!, width: 50),
                title: Text(item['title']!),
                subtitle: Text(item['description']!),
                onTap: () => context.go('/details/${item['id']}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ItemDetailsSheet extends StatelessWidget {
  final Map<String, String> item;

  const _ItemDetailsSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(item['image']!),
          Text(item['title']!, style: TextStyle(fontSize: 20)),
          Text(item['description']!),
          Row(
            children: [
              IconButton(onPressed: () => setState(() => quantity--), icon: Icon(Icons.remove)),
              Text('$quantity'),
              IconButton(onPressed: () => setState(() => quantity++), icon: Icon(Icons.add)),
            ],
          ),
          ElevatedButton(
            child: Text('Add to Cart'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  }
}
