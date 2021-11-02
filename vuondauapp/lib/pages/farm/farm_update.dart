import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_form_field.dart';

class UpdateFarm extends StatefulWidget {
  const UpdateFarm({Key? key}) : super(key: key);

  @override
  _UpdateFarmState createState() => _UpdateFarmState();
}

class _UpdateFarmState extends State<UpdateFarm> {
  @override
  Widget build(BuildContext context) {
    final FarmDTO farm = ModalRoute.of(context)!.settings.arguments as FarmDTO;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cập nhật nông trại'),
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
                'Nhập mới thông tin nông trại',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputForm(
                icon: Icons.drive_file_rename_outline,
                value: farm.name,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputForm(
                icon: Icons.location_on,
                value: farm.address,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputForm(
                icon: Icons.description,
                value: farm.description,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.picture_in_picture_alt,
                hintText: "Link ảnh nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Hoàn tất",
                press: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context)=>Message_Dialog(
                        title: 'Cập nhật nông trại',
                        content: 'Cập nhật nông trại thành công',
                    )
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
