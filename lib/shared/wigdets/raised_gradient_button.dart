import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Function onPressed;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.onPressed,
    this.margin,
    this.padding,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      child: Container(
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.all(Radius.circular(80.0))
        ),
        padding: this.padding,
        child: this.child,
        width: this.width,
      ),
    );
  }
}