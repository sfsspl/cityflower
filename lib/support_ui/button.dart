import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool fullSized;

  const Button(
      {Key key,
      @required this.onPressed,
      @required this.text,
      this.fullSized = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: fullSized ? double.infinity : null,
      height: 40,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.blue.shade300,
    );
  }
}
