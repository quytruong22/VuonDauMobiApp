import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';

class UpdateHarvest extends StatefulWidget {
  const UpdateHarvest({Key? key}) : super(key: key);

  @override
  _UpdateHarvestState createState() => _UpdateHarvestState();
}

class _UpdateHarvestState extends State<UpdateHarvest> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cập nhật mùa vụ'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Farm"),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Nhập mới thông tin mùa vụ',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Tên mùa vụ",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Mô tả mùa vụ",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Điền thông tin sản phẩm',
                style: TextStyle(
                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Tên sản phẩm",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Mô tả sản phẩm",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Link ảnh sản phẩm",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Hoàn tất",
                press: () {
                  Navigator.pushReplacementNamed(context, '/harvest');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
