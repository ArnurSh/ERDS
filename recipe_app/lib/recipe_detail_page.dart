import 'package:flutter/material.dart';
import 'models/recipe.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  int _sliderValue = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.recipe.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.recipe.servings * _sliderValue} servings',
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: _sliderValue.toDouble(),
              label: '${widget.recipe.servings * _sliderValue}',
              onChanged: (value) {
                setState(() {
                  _sliderValue = value.round();
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = widget.recipe.ingredients[index];
                  final adjustedQty = ingredient.quantity * _sliderValue;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '${adjustedQty.toStringAsFixed(2)} ${ingredient.measure} ${ingredient.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: const Text("Pick a Date"),
              onPressed: _pickDate,
            ),
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Selected date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.access_time),
              label: const Text("Pick a Time"),
              onPressed: _pickTime,
            ),
            if (selectedTime != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Selected time: ${selectedTime!.format(context)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
