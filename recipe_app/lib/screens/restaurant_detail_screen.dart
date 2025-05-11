import 'package:flutter/material.dart';
import 'package:recipe_app/data/favorites.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final List<String> menuItems;

  const RestaurantDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.menuItems,
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool get isFavorite =>
      favoriteRestaurants.any((r) => r['name'] == widget.name);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoriteRestaurants.removeWhere((r) => r['name'] == widget.name);
      } else {
        favoriteRestaurants.add({
          'name': widget.name,
          'image': widget.image,
          'menu': widget.menuItems,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${widget.name} removed from favorites'
              : '${widget.name} added to favorites',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.image, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('Menu', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: Text(widget.menuItems[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
