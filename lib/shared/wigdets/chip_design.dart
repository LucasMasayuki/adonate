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
      child: Chip(
        label: Text(
          this.label,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: this.color,
        elevation: 4,
        shadowColor: Colors.grey[50],
        padding: EdgeInsets.all(4),
      ),
    );
  }
}