import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/bar.dart';
import 'package:vuondauapp/widgets/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Profile'),
          centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Profile"),
      body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                        'Họ tên: ',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 20.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                    Text(
                        'Truong',
                        style: TextStyle(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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
                          fontSize: 20.0,
                          fontFamily: 'Playfair',
                        )
                    ),
                    Text(
                        '012031283',
                        style: TextStyle(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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
                        'k1695nguyentruong',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                TextButton.icon(
                    onPressed: (){
                      Navigator.pushNamed(context, '/profileupdate');
                    },
                    icon: Icon(Icons.update),
                    label: Text(
                      'Update Profile'
                    )
                ),
              ]
          )
      ),
      bottomNavigationBar: BarBottom(),
    );
  }
}
