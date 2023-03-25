import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<int> options;

  CustomDropdown({required this.options});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      color: Colors.grey.shade300,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                labelText: "Le nombre des passagers",
                // suffixIcon: Icon(Icons.arrow_drop_down_circle),
              ),
              controller: TextEditingController(text: selectedOption.toString()),
            ),
          ),
          IconButton(
            onPressed: () {
              showOptions();
            },
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }

  void showOptions() async {
    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select an option'),
          children: widget.options
              .map((option) => SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, option);
            },
            child: Text(option.toString()),
          ))
              .toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedOption = result;
      });
    }
  }
}
