import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_password_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String  _oldpassword = '';
  String  _newpassword = '';
  String  _confirm  = '';

  Future<bool> validatePassword(String password) async {
    var firebaseUser = _auth.currentUser!;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email!, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = _auth.currentUser!;
    firebaseUser.updatePassword(password);
  }
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
              RoundedPasswordField(
                  onChanged: (value){
                    _oldpassword  = value;
                  },
                  hint: 'Mật khẩu cũ'),
              Text(
                'Điền mật khẩu mới',
                style: TextStyle(

                ),
              ),
              RoundedPasswordField(
                  onChanged: (value){
                    _newpassword  = value;
                  },
                  hint: 'Mật khẩu mới'),
              Text(
                'Xác nhận mật khẩu mới',
                style: TextStyle(

                ),
              ),
              RoundedPasswordField(
                  onChanged: (value){
                    _confirm  = value;
                  },
                  hint: 'Xác nhận mật khẩu'),
              RoundedButton(
                  text: 'Hoàn tất',
                  press: ()async{
                if(await validatePassword(_oldpassword)){
                  if(_newpassword == _confirm){
                    await updatePassword(_newpassword);
                    await showDialog(
                        context: context,
                        builder: (BuildContext context)=>Message_Dialog(title: 'Cập nhật thành công',content: 'Cập nhật mật khẩu thành công')
                    );
                    Navigator.pop(context);
                  } else  {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context)=>Message_Dialog(title: 'Xác nhận mật khẩu sai',content: 'Mật khẩu mới không trùng xác nhận mật khẩu')
                    );
                  }
                } else {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context)=>Message_Dialog(title: 'Sai mật khẩu',content: 'Mật khẩu hiện tại chưa đúng')
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
