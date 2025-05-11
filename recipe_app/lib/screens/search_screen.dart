import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'Pizza Planet',
      'menu': ['Margherita', 'Pepperoni', 'Cheese Burst'],
    },
    {
      'name': 'Sushi Spot',
      'menu': ['Salmon Roll', 'Avocado Maki'],
    },
    {
      'name': 'Burger King',
      'menu': ['Whopper', 'Cheeseburger', 'Fries'],
    },
    {
      'name': 'SF Food',
      'menu': ['Doner', 'Blinchiki', 'Ice-cream', 'Wopper', 'Pineapple'],
    },
  ];

  List<Map<String, dynamic>> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _restaurants;
    _controller.addListener(_filterResults);
  }

  void _filterResults() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredRestaurants = _restaurants
          .where((r) => r['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Restaurants')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredRestaurants.isEmpty
                  ? const Center(child: Text('No results'))
                  : ListView.builder(
                itemCount: _filteredRestaurants.length,
                itemBuilder: (context, index) {
                  final res = _filteredRestaurants[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.restaurant),
                      title: Text(res['name']),
                      subtitle: Text(res['menu'].join(', ')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
