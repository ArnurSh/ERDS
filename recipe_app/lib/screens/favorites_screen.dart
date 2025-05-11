import 'package:flutter/material.dart';
import 'package:recipe_app/data/favorites.dart';
import 'package:recipe_app/screens/restaurant_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}



class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favoriteRestaurants.isEmpty
          ? const Center(child: Text("No favorites yet."))
          : ListView.builder(
        itemCount: favoriteRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = favoriteRestaurants[index];
          return Dismissible(
            key: Key(restaurant['name']),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                favoriteRestaurants.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${restaurant['name']} removed')),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: const Icon(Icons.restaurant),
                title: Text(restaurant['name']),
                subtitle: Text(restaurant['menu'].join(', ')),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(
                        name: restaurant['name'],
                        image: restaurant['image'],
                        menuItems: List<String>.from(restaurant['menu']),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
