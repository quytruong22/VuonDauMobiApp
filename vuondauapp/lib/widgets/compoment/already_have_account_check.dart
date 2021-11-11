import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function() press;
  const AlreadyHaveAnAccountCheck({
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Bạn chưa có tài khoản ? " : "Đã có tài khoản ? ",
          style: TextStyle(color: Colors.lightGreenAccent[700]),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Đăng ký" : "Đăng nhập",
            style: TextStyle(
              color: Colors.lightGreenAccent[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}