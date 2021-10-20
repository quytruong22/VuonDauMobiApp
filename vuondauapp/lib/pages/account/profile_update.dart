import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_form_field.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String dropdownValue = 'Nam';
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
                  'Họ:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RoundedInputForm(
                  onChanged: (value){},
                  value: 'Nguyễn',
                  icon: Icons.drive_file_rename_outline,
              ),
              Container(
                width: size.width * 0.8,
                child: Text(
                  'Tên:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RoundedInputForm(
                onChanged: (value){},
                value: 'Quý Trường',
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
              RoundedInputForm(
                onChanged: (value){},
                value: '81723712',
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
                  items: <String>['Nam','Nữ']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              RoundedButton(text: 'Hoàn tất', press: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
