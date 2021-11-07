import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/pages/farm/farm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  FarmerDTO farmer;

  Body({required this.farmer});


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        widget.farmer.full_name,
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
                        widget.farmer.gender ? 'Nữ':'Nam',
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
                        '${widget.farmer.birth_day.day}/${widget.farmer.birth_day.month}/${widget.farmer.birth_day.year}',
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
                      widget.farmer.phone,
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
                        widget.farmer.email,
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
                    onPressed: () async {
                      await Navigator.push(context,MaterialPageRoute(
                        builder: (context) => UpdateProfile(farmer:widget.farmer)
                      ));
                    },
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_outlined,
                          color: Colors.lightGreen
                        ),
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
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.vpn_key_outlined,
                            color: Colors.lightGreen
                        ),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      try {
                        final response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farms/${widget.farmer.id}'));
                        if (response.statusCode == 200) {
                          List<FarmDTO> list = ListFarms.fromJson(jsonDecode(response.body)).farms;
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => Farm(farmer:widget.farmer),
                            settings: RouteSettings(
                              arguments: list,
                            ),
                          ));
                        } else  if(response.statusCode == 404){
                          List<FarmDTO> list = [];
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => Farm(farmer:widget.farmer),
                            settings: RouteSettings(
                              arguments: list,
                            ),
                          ));
                        }
                        else {
                          throw Exception('Failed to load Farm');
                        }
                      } catch (e) {
                        print('caught error: $e');
                      }

                    },
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.home_outlined,
                            color: Colors.lightGreen
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "Nông trại",
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
                      Navigator.pushNamed(context, "/aboutus");
                    },
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.info_outlined,
                            color: Colors.lightGreen
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "About us",
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
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.logout,
                            color: Colors.lightGreen
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "Đăng Xuất",
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
