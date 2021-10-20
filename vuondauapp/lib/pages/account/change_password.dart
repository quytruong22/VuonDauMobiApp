import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_password_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Thay đổi mật khẩu'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Text(
                'Điền mật khẩu cũ',
                style: TextStyle(

                ),
              ),
              RoundedPasswordField(onChanged: (value){}, hint: 'Mật khẩu cũ'),
              Text(
                'Điền mật khẩu mới',
                style: TextStyle(

                ),
              ),
              RoundedPasswordField(onChanged: (value){}, hint: 'Mật khẩu mới'),
              Text(
                'Xác nhận mật khẩu mới',
                style: TextStyle(

                ),
              ),
              RoundedPasswordField(onChanged: (value){}, hint: 'Xác nhận mật khẩu'),
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
