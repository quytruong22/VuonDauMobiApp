import 'package:flutter/material.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfilePic(),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text(
                        'Họ tên: ',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                    Text(
                        'Nguyễn Quý Trường',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text(
                        'Giới tính: ',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                    Text(
                        'Nam',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text(
                        'Ngày sinh: ',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                    Text(
                        '06/08/2000',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text(
                        'Số điện thoại: ',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 15.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                    Text(
                      '012031283',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                    ),
                    SizedBox(width: 10),
                    Text(
                        'k1695nguyentruong@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profileupdate');
                    },
                    color: Colors.lightGreenAccent,
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_outlined),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "Cập nhật thông tin cá nhân",
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/changepassword");
                    },
                    color: Colors.lightGreenAccent,
                    child: Row(
                      children: [
                        Icon(Icons.vpn_key_outlined),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "Đổi mật khẩu",
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                )
              ]
          ),
        )
    );
  }
}
