import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;

  RoundedIconButton({
    required this.text,
    required this.press,
    this.color = Colors.green,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newIconButton(),
      ),
    );
  }


  Widget newIconButton() {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.plus_one,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}