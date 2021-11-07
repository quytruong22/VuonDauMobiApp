import 'package:flutter/material.dart';

class StatusHarvest extends StatelessWidget {
  final DateTime datestart;
  final DateTime dateend;

  StatusHarvest({required this.datestart, required this.dateend});

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
