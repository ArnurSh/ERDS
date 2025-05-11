import 'package:flutter/material.dart';

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({super.key});

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
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
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: const Text('Pick a Date'),
          onPressed: _pickDate,
        ),
        if (selectedDate != null)
          Text(
            'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
            style: const TextStyle(fontSize: 16),
          ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.access_time),
          label: const Text('Pick a Time'),
          onPressed: _pickTime,
        ),
        if (selectedTime != null)
          Text(
            'Time: ${selectedTime!.format(context)}',
            style: const TextStyle(fontSize: 16),
          ),
      ],
    );
  }
}
