import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';

class RoundedInputForm extends StatelessWidget {
  final IconData icon;
  final ValueChanged<String> onChanged;
  final value;
  RoundedInputForm({
    this.icon = Icons.person,
    required this.onChanged,
    this.value = ''
  });
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.green,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedNumberInputForm extends StatelessWidget {
  final IconData icon;
  final ValueChanged<String> onChanged;
  final value;
  RoundedNumberInputForm({
    this.icon = Icons.person,
    required this.onChanged,
    this.value = ''
  });
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: value,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.green,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

