import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:http/http.dart' as http;

class AddFarm extends StatefulWidget {
  final List<AreaDTO> listArea;
  final List<FarmType> listFarmType;

  AddFarm({required this.listArea, required this.listFarmType});

  @override
  _AddFarmState createState()  {
    return _AddFarmState();
  }
}

class _AddFarmState extends State<AddFarm> {
  String  name = '';
  String  address = '';
  String  description = '';
  String  link = '';
  late  AreaDTO area;
  late  FarmType farmType;

  @override
  Widget build(BuildContext context) {
    final FarmerDTO farmer=ModalRoute.of(context)!.settings.arguments as FarmerDTO;
    Size size = MediaQuery.of(context).size;
    area  = widget.listArea.first;
    farmType  = widget.listFarmType.first;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Thêm nông trại'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width-20,
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
              TextFieldContainer(
                child: DropdownButton<AreaDTO>(
                  value: area,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (AreaDTO? newValue) {
                    setState(() {
                      area = newValue!;
                    });
                  },
                  items: widget.listArea.map<DropdownMenuItem<AreaDTO>>((AreaDTO area) => DropdownMenuItem(
                      value: area,
                      child: Text(area.name)
                  )).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: DropdownButton<FarmType>(
                  value: farmType,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (FarmType? newValue) {
                    setState(() {
                      farmType = newValue!;
                    });
                  },
                  items: widget.listFarmType.map<DropdownMenuItem<FarmType>>((FarmType farmType) => DropdownMenuItem(
                      value: farmType,
                      child: Text(farmType.name)
                  )).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.drive_file_rename_outline,
                hintText: "Tên nông trại",
                onChanged: (value) {
                  name  = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.location_on,
                hintText: "Địa chỉ nông trại",
                onChanged: (value) {
                  address = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.description,
                hintText: "Mô tả nông trại",
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.picture_in_picture,
                hintText: "Link ảnh nông trại",
                onChanged: (value) {
                  link  = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Hoàn tất",
                press: () async {
                  bool confirm = await showDialog(context: context, builder: (BuildContext context) {
                    return Confirm_Dialog(
                      title: 'Tạo nông trại',
                      content: 'Bạn muốn tạo nông trại mới?',
                    );
                  });
                  if(confirm){
                    try {
                      Map data = {
                        "farm_type_id": "${farmType.id}",
                        "farmer_id": "${farmer.id}",
                        "area_id": "${area.ID}",
                        "name": "$name",
                        "address": "$address",
                        "description": "$description",
                      };
                      var body = json.encode(data);
                      final http.Response response = await http.post(
                          Uri.parse('http://52.221.245.187:90/api/v1/farms'),
                          headers: {"Content-Type": "application/json-patch+json"},
                          body: body
                      );
                      if (response.statusCode==200) {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context)=>Message_Dialog(
                              title: 'Tạo nông trại',
                              content: 'Tạo nông trại thành công',
                            )
                        );
                        Navigator.pop(context);
                      }
                    } on Exception catch (e) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context)=>Message_Dialog(title: 'Lỗi tạo nông trại',content: e.toString())
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
