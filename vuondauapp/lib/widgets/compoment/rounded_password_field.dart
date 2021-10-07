import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.green,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.green,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}