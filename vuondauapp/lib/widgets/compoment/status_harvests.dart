import 'package:flutter/material.dart';

class StatusHarvest extends StatelessWidget {
  final int status;

  StatusHarvest({required this.status});

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
    if(status==1){ //đang mở bán
      return Status(context, 'Đang mở', Colors.green);
    }
    else{ //đã kết thúc
      return Status(context, 'Đã đóng', Colors.red);
    }
  }
}
