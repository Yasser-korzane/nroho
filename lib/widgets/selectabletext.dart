import 'package:flutter/material.dart';



class SelectableTextWidget extends StatefulWidget {
  final String text;
  final bool isSelected;

  const SelectableTextWidget({
    Key? key,
    required this.text,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _SelectableTextWidgetState createState() => _SelectableTextWidgetState();
}

class _SelectableTextWidgetState extends State<SelectableTextWidget> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade300,
        ),
        padding: EdgeInsets.fromLTRB(10,15,10,15) ,
        child: Row(
          children: [
            Expanded(
              flex: 80,
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 20,
              child: Icon(
                _isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: _isSelected ? Colors.blue : Colors.grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
