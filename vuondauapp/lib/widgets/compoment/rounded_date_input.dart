import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';

class RoundedDateInput extends StatefulWidget {
  String text;
  final IconData icon;
  final Function() onPress;
  RoundedDateInput({
    required this.text,
    this.icon = Icons.person,
    required this.onPress
  });

  @override
  State<RoundedDateInput> createState() => _RoundedDateInputState();
}

class _RoundedDateInputState extends State<RoundedDateInput> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
                  widget.icon,
                  color: Colors.green,
                ),
            Text(
                widget.text,
                style: TextStyle(
                  color: Colors.black
                ),
            )
          ],
        ),
        onPressed: widget.onPress,
        style: ElevatedButton.styleFrom(
          primary: Colors.lightGreenAccent[100],
          elevation: 0
        )
      )
    );
  }
}
/*
(){
          showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2023)
          ).then((value) {
            setState(() {
              widget.hintText = value.toString();
            });
          });
        }
 */
