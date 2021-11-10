import 'package:flutter/material.dart';

class StatusFarm extends StatelessWidget {
  final int status;

  StatusFarm({required this.status});

  Container Status(BuildContext context,String textbar, Color colorbar){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.5),
      width: 70,
      height: 15,
      decoration: BoxDecoration(
          color: colorbar,
          borderRadius: BorderRadius.circular(7.5)
      ),
      child: Text(
        textbar,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 8,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(status==2){
      return Status(context, 'Chờ phê duyệt', Colors.amber);
    }
    else if(status==1){
      return Status(context, 'Đang hoạt đông', Colors.green);
    }
    else{
      return Status(context, 'Ngưng hoạt động', Colors.red);
    }
  }
}
