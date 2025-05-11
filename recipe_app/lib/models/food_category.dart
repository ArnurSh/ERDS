class FoodCategory {
  final String imageUrl;
  final String title;
  final String description;

  FoodCategory({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final List<FoodCategory> mockCategories = [
  FoodCategory(
    imageUrl: 'assets/spaghetti.jpg',
    title: 'Italian',
    description: 'Classic pastas, lasagna and more.',
  ),
  FoodCategory(
    imageUrl: 'assets/taco_salad.jpg',
    title: 'Mexican',
    description: 'Tacos, nachos, burritos with spice.',
  ),
  FoodCategory(
    imageUrl: 'assets/soup.jpg',
    title: 'Soups',
    description: 'Warm up with creamy and brothy bowls.',
  ),
  FoodCategory(
    imageUrl: 'assets/asian.jpg',
    title: 'Asian',
    description: 'Sushi rolls, stir fry, and noodles.',
  ),
  FoodCategory(
    imageUrl: 'assets/desserts.jpg',
    title: 'Desserts',
    description: 'Cakes, cookies, and sweet treats.',
  ),
  FoodCategory(
    imageUrl: 'assets/burger.jpg',
    title: 'Snacks',
    description: 'Quick bites and cheesy classics.',
  ),
];
