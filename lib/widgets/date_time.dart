import 'package:flutter/material.dart';

class DateTimePickerRow extends StatefulWidget {
  DateTime monDateEtTime ;
  DateTimePickerRow(this.monDateEtTime);
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
      firstDate: DateTime(2023, 4),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.monDateEtTime = DateTime(
            picked.year, picked.month, picked.day,
            _selectedTime!.hour, _selectedTime!.minute
        );
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
        widget.monDateEtTime = DateTime(
            _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
            picked.hour, picked.minute
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Padding(
      // padding:  EdgeInsets.symmetric(vertical: 0, horizontal: screenWidth*0.075),
      padding: EdgeInsets.fromLTRB(screenWidth*0.07, 0, screenWidth*0.075, 0),
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
            flex: 3,
            child: TextField(
              readOnly: true,
              onTap: _selectDate,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: screenHeight*0.00001,left: screenWidth*0.04),
                hintText: _selectedDate == null
                    ? 'Select a date'
                    : '${_selectedDate!.toString().split(" ")[0]}',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
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
            flex: 3,
            child: TextFormField(
              readOnly: true,
              onTap: _selectTime,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: screenHeight*0.0001,left: screenWidth*0.04),
                hintText: _selectedTime == null
                    ? 'Select a time'
                    : '${_selectedTime!.format(context)}',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
