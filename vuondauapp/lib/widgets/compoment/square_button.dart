import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String text;
  final Function() press;
  final IconData icon;
  final Color color;

  SquareButton({required this.text, required this.press, required this.icon,required this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width-20) * 0.25,
      height: (size.width-20) * 0.25,
      child: ElevatedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                icon,
                color: color,
                size: size.width*0.1,
              ),
              Container(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width*0.03,

                  ),
                ),
              ),
            ],
          ),
          onPressed: press,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 1,
          ),
      ),
    );
  }
}
