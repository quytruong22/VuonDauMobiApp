import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/pages/farm/farm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vuondauapp/services/http_service.dart';
import '../profile.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final HttpService httpService = HttpService();
  final LocalStorage storage = LocalStorage('farmer_info');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String farmerID = "";
    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }
    return Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: FutureBuilder(
          future: httpService.getFarmer(farmerID),
          builder: (BuildContext context, AsyncSnapshot<FarmerDTO> snapshot){
            if(snapshot.hasData){
              FarmerDTO farmer = snapshot.requireData;
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ProfilePic(),
                      SizedBox(height: 8),
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
                              farmer.full_name,
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Playfair',
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
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
                              farmer.gender ? 'Nam':'Nữ',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Playfair',
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
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
                              '${farmer.birth_day.day}/${farmer.birth_day.month}/${farmer.birth_day.year}',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Playfair',
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
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
                            farmer.phone,
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.email,
                          ),
                          SizedBox(width: 10),
                          Text(
                              farmer.email,
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
                                builder: (context) => UpdateProfile(farmer:farmer)
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
                            Navigator.push(context,MaterialPageRoute(
                                builder: (context) => Farm()
                            ));
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
              );
            }
            if(snapshot.hasError){
              return  const Center(child: Text('Lỗi load thông tin tài khoản'));
            }
            return const Center(child: CircularProgressIndicator());
          }
        )
    );
  }
}
