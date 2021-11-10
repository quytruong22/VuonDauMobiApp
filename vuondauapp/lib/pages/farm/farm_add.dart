import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:http/http.dart' as http;

class AddFarm extends StatefulWidget {
  final List<AreaDTO> listArea;
  final List<FarmType> listFarmType;
  final String farmerID;

  AddFarm({required this.listArea, required this.listFarmType,required this.farmerID});

  @override
  _AddFarmState createState()  {
    return _AddFarmState();
  }
}

class _AddFarmState extends State<AddFarm> {
  File? image;
  final HttpService httpService = HttpService();
  final picker = ImagePicker();
  String  name = '';
  String  address = '';
  String  description = '';
  late AreaDTO _Choosearea;
  late FarmType _ChoosefarmType;

  @override
  void initState() {
    super.initState();
    _ChoosefarmType = widget.listFarmType.first;
    _Choosearea = widget.listArea.first;
  }

  Future  pickImage(ImageSource source) async {
    try{
      final image = await picker.pickImage(source: source);
      if(image==null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch(e){
      print('failed to pick image: '+e.toString());
    }
  }

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
              Text(
                'Vùng của nông trại',
                style: TextStyle(

                ),
              ),
              TextFieldContainer(
                child: DropdownButton(
                  value: _Choosearea,
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
                      _Choosearea = newValue!;
                    });
                  },
                  items: widget.listArea
                      .map((AreaDTO value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Loại nông trại',
                style: TextStyle(

                ),
              ),
              TextFieldContainer(
                child: DropdownButton(
                  value: _ChoosefarmType,
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
                      _ChoosefarmType = newValue!;
                    });
                  },
                  items: widget.listFarmType
                      .map((FarmType value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
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
              image!=null? Image.file(image!,width: 150,height: 150,fit: BoxFit.cover): Text('no image selected'),
              IconButton(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt_outlined)
              ),
              IconButton(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image_outlined)
              ),
              RoundedButton(
                text: "Hoàn tất",
                press: () async {
                    try {
                      Map data = {
                        "farm_type_id": "${_ChoosefarmType.id}",
                        "farmer_id": "${widget.farmerID}",
                        "area_id": "${_Choosearea.ID}",
                        "name": "$name",
                        "address": "$address",
                        "description": "$description",
                      };
                      var body = json.encode(data);
                      final http.Response response = await http.post(
                          Uri.parse('http://52.221.245.187:90/api/v1/farms'),
                          headers: {"Content-Type": "application/json"},
                          body: body
                      );
                      if (response.statusCode==201) {
                        final String farmID  = jsonDecode(response.body)['id'];
                        bool uploadImage = await httpService.postFarmImage(image!, farmID);
                        if (uploadImage) {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context)=>Message_Dialog(
                                title: 'Tạo nông trại',
                                content: 'Tạo nông trại thành công',
                              )
                          );
                          Navigator.pop(context);
                        }
                      }
                    } on Exception catch (e) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context)=>Message_Dialog(title: 'Lỗi tạo nông trại',content: e.toString())
                      );
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
