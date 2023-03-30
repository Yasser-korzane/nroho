import 'package:flutter/material.dart';

class DateTimePickerRow extends StatefulWidget {
  const DateTimePickerRow({Key? key}) : super(key: key);

  @override
  _DateTimePickerRowState createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _selectDate,
          icon: Icon(Icons.calendar_today),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextFormField(
            readOnly: true,
            onTap: _selectDate,
            decoration: InputDecoration(
              labelText: _selectedDate == null
                  ? 'Select a date'
                  : 'Selected Date: ${_selectedDate!.toString().split(" ")[0]}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        IconButton(
          onPressed: _selectTime,
          icon: Icon(Icons.access_time),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextFormField(
            readOnly: true,
            onTap: _selectTime,
            decoration: InputDecoration(
              labelText: _selectedTime == null
                  ? 'Select a time'
                  : 'Selected Time: ${_selectedTime!.format(context)}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
