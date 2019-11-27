import 'package:flutter/material.dart';

class ChipDesign extends StatelessWidget {
  final String label;
  final Color color;

  const ChipDesign({
    Key key,
    this.label,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      child: Chip(
        label: Text(
          this.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: this.color,
        elevation: 8,
        shadowColor: Colors.grey[50],
        padding: EdgeInsets.all(0),
      ),
    );
  }
}