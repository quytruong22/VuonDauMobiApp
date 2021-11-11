import 'package:flutter/material.dart';

class Message_Dialog extends StatelessWidget {
  final String title;
  final String content;

  Message_Dialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: RoundedRectangleBorder(
        side:  BorderSide(color: Colors.green,width: 3),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      actions: [
        ElevatedButton(
          child: Text("Đồng ý"),
          onPressed: (){
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green
          ),
        ),
      ],
    );
  }
}

class Confirm_Dialog extends StatelessWidget {

  final String title;
  final String content;

  Confirm_Dialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: RoundedRectangleBorder(
          side:  BorderSide(color: Colors.green,width: 3),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      actions: [
        ElevatedButton(
          child: Text("Đồng ý"),
          onPressed: (){
            Navigator.pop(context,true); // Return false
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.green
          ),
        ),
        ElevatedButton(
          child: Text("Hủy"),
          onPressed: (){
            Navigator.pop(context,false); // Return true
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.green
          ),
        ),
      ],
    );
  }
}

