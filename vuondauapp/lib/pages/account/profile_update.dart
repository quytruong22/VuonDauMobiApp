import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_form_field.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  final FarmerDTO farmer;


  UpdateProfile({required this.farmer});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String full_name='';
  String phone = '';
  DateTime birthday = DateTime.now();
  String dropdownValue = 'Nam';

  @override
  void initState() {
    super.initState();
    full_name = widget.farmer.full_name;
    phone = widget.farmer.phone;
    birthday = widget.farmer.birth_day;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Cập nhật Profile'),
          centerTitle: true,
        ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0,),
              Text(
                'Điền thông tin mới',
                style: TextStyle(

                ),
              ),
              SizedBox(height: 8.0,),
              Container(
                width: size.width * 0.8,
                child: Text(
                  'Họ và tên:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RoundedInputForm(
                  onChanged: (value){
                    full_name=value;
                  },
                  value: full_name,
                  icon: Icons.drive_file_rename_outline,
              ),
              Container(
                width: size.width * 0.8,
                child: Text(
                  'Số điện thoại:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RoundedNumberInputForm(
                onChanged: (value){
                  phone=value;
                },
                value: phone,
                icon: Icons.phone,
              ),
              Container(
                width: size.width * 0.8,
                child: Text(
                  'Giới tính:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFieldContainer(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Nữ','Nam']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                  width: size.width*0.8,
                  child: Text(
                    'Ngày Sinh',
                    style: TextStyle(

                    ),
                    textAlign: TextAlign.left,
                  )
              ),
              RoundedDateInput(
                  text: 'Ngày '+birthday.day.toString()+' tháng '+birthday.month.toString()+' năm '+birthday.year.toString(),
                  icon: Icons.date_range,
                  onPress: (){
                    showDatePicker(
                        context: context,
                        initialDate: birthday,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                    ).then((value) {
                      setState(() {
                        birthday  = value!;
                        }
                      );
                    });
                  }
              ),
              RoundedButton(
                  text: 'Hoàn tất',
                  press: () async {
                    final int gender = dropdownValue == 'Nam'? 0 : 1;
                    Map data = {
                      "full_name": full_name,
                      "password": "",
                      "phone": phone,
                      "birth_day": DateFormat('yyyy-MM-ddThh:mm:ss').format(birthday),
                      "gender": gender,
                      "status": 1
                    };
                    var body = json.encode(data);
                    final http.Response response = await http.put(
                        Uri.parse('http://52.221.245.187:90/api/v1/farmers/${widget.farmer.id}'),
                        headers: {"Content-Type": "application/json"},
                        body: body
                    );
                    if(response.statusCode==200){
                      await showDialog(
                          context: context,
                          builder: (BuildContext context)=>Message_Dialog(title: 'Cập nhật thành công',content: 'Cập nhật thông tin cá nhân thành công')
                      );
                      Navigator.pop(context);
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
