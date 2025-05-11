import 'package:flutter/material.dart';
import '../components/category_card.dart';
import '../components/categorysection.dart';
import '../models/food_category.dart';
import 'profile_screen.dart';
import 'restaurant_detail_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'package:recipe_app/data/favorites.dart';
import 'map_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    CategorySection(categories: mockCategories),
    const PostsTab(),
    const RestaurantsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foodie's Hub"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MapScreen()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Posts'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Restaurants'),
        ],
      ),
    );
  }
}

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> mockPosts = [
      'I just had the best sushi ever!',
      'Homemade pizza is underrated!',
      'Burger challenge at Grill House was 🔥',
    ];

    return ListView.builder(
      itemCount: mockPosts.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text('Friend #$index'),
          subtitle: Text(mockPosts[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
        ),
      ),
    );
  }
}

class RestaurantsTab extends StatefulWidget {
  const RestaurantsTab({super.key});

  @override
  State<RestaurantsTab> createState() => _RestaurantsTabState();
}

class _RestaurantsTabState extends State<RestaurantsTab> {
  String searchQuery = '';
  String sortCriteria = 'name'; // name или menuCount

  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Pizza Planet',
      'image': 'assets/pizza.jpg',
      'menu': ['Margherita', 'Pepperoni', 'Cheese Burst'],
    },
    {
      'name': 'Sushi Spot',
      'image': 'assets/sushi.jpg',
      'menu': ['Salmon Roll', 'Avocado Maki', 'Tuna Sashimi'],
    },
    {
      'name': 'Burger King',
      'image': 'assets/burger.jpg',
      'menu': ['Whopper', 'Cheeseburger', 'Fries'],
    },
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    final filtered = restaurants
        .where((r) =>
        r['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (sortCriteria == 'name') {
      filtered.sort((a, b) => a['name'].compareTo(b['name']));
    } else if (sortCriteria == 'menuCount') {
      filtered.sort((a, b) => b['menu'].length.compareTo(a['menu'].length));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search Field
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search Restaurants',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => searchQuery = value),
          ),
        ),

        // ↕ Sort Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<String>(
            value: sortCriteria,
            items: const [
              DropdownMenuItem(value: 'name', child: Text('Sort by Name')),
              DropdownMenuItem(value: 'menuCount', child: Text('Sort by Menu Size')),
            ],
            onChanged: (value) => setState(() => sortCriteria = value!),
            isExpanded: true,
          ),
        ),

        // 📋 Filtered List
        Expanded(
          child: ListView(
            children: filteredRestaurants.map((restaurant) {
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: Text(restaurant['name']),
                  subtitle: Text('${restaurant['menu'].length} items in menu'),
                  onTap: () {
                    // переход к RestaurantDetailScreen
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

