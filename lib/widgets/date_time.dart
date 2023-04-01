import 'package:flutter/material.dart';

class DateTimePickerRow extends StatefulWidget {
  const DateTimePickerRow({Key? key}) : super(key: key);

  @override
  _DateTimePickerRowState createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

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
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 50),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: _selectDate,
              icon: Icon(Icons.calendar_today),
            ),
          ),
          Expanded(
            flex: 7,
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
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: _selectTime,
              icon: Icon(Icons.access_time),
            ),
          ),
          Expanded(
            flex: 7,
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
      ),
    );
  }
}
