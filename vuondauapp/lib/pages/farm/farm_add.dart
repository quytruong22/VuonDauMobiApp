import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
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
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width,
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
                icon: Icons.drive_file_rename_outline,
                hintText: "Tên nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.location_on,
                hintText: "Địa chỉ nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.description,
                hintText: "Mô tả nông trại",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.picture_in_picture,
                hintText: "Link ảnh nông trại",
                onChanged: (value) {},
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
                    await showDialog(
                        context: context,
                        builder: (BuildContext context)=>Message_Dialog(
                          title: 'Tạo nông trại',
                          content: 'Tạo nông trại thành công',
                        )
                    );
                    Navigator.pop(context);
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
