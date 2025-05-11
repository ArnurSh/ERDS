class Ingredient {
  final double quantity;
  final String measure;
  final String name;

  Ingredient(this.quantity, this.measure, this.name);
}

class Recipe {
  final String label;
  final String imageUrl;
  final int servings;
  final List<Ingredient> ingredients;
  final String category; // <- категория, к которой относится

  Recipe(this.label, this.imageUrl, this.servings, this.ingredients, this.category);

  static final List<Recipe> samples = [
    Recipe(
      'Spaghetti and Meatballs',
      'assets/spaghetti.jpg',
      4,
      [
        Ingredient(1, 'box', 'Spaghetti'),
        Ingredient(4, '', 'Frozen Meatballs'),
        Ingredient(0.5, 'jar', 'Sauce'),
      ],
      'Italian',
    ),
    Recipe(
      'Taco Salad',
      'assets/taco_salad.jpg',
      2,
      [
        Ingredient(4, 'oz', 'Nachos'),
        Ingredient(3, 'oz', 'Taco Meat'),
        Ingredient(0.5, 'cup', 'Cheese'),
      ],
      'Mexican',
    ),
    Recipe(
      'Tomato Soup',
      'assets/soup.jpg',
      2,
      [
        Ingredient(1, 'can', 'Tomato Soup'),
      ],
      'Soups',
    ),
  ];
}
