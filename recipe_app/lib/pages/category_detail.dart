import 'package:flutter/material.dart';
import '../models/food_category.dart';

class CategoryDetailPage extends StatefulWidget {
  final FoodCategory category;

  const CategoryDetailPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  // Слайдер для изменения количества порций
  int _sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.category.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            //
            Text(
              widget.category.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            // Слайдер
            Text(
              'Portions: $_sliderValue',
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: _sliderValue.toDouble(),
              label: '$_sliderValue',
              onChanged: (double newValue) {
                setState(() {
                  _sliderValue = newValue.round();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
