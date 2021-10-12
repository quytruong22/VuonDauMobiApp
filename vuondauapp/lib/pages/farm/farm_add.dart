import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';

class AddFarm extends StatefulWidget {
  const AddFarm({Key? key}) : super(key: key);

  @override
  _AddFarmState createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Thêm nông trại'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Điền thông tin nông trại',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Tên nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Địa chỉ nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Mô tả nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Link ảnh nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Hoàn tất",
                press: () {
                  Navigator.pushReplacementNamed(context, '/farm');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
