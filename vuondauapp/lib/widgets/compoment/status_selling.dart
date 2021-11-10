import 'package:flutter/material.dart';

class StatusSelling extends StatelessWidget {
  final DateTime datestart;
  final DateTime dateend;

  StatusSelling({required this.datestart, required this.dateend});

  Container Status(BuildContext context,String textbar, Color colorbar){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      width: 100,
      height: 20,
      decoration: BoxDecoration(
          color: colorbar,
          borderRadius: BorderRadius.circular(7.5)
      ),
      child: Text(
        textbar,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentdate = DateTime.now();
    if(datestart.isAfter(currentdate)){ //đang chuẩn bị
      return Status(context, 'Đang chuẩn bị', Colors.amber);
    }
    else if(dateend.isAfter(currentdate)){ //đang mở bán
      return Status(context, 'Đang mở bán', Colors.green);
    }
    else{ //đã kết thúc
      return Status(context, 'Đã kết thúc', Colors.red);
    }
  }
}
