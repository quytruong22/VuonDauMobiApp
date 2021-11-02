import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('About Us'),
            centerTitle: true
        ),
        body: Container(
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/iconVuondau.png",
                  height: size.height * 0.35,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Text(
                    'Vuon Dau Mobile là một app cung cấp các dịch vụ dành cho các Farmer. Cụ thể là Farmer có thể đưa nông trại của mình vào tại mục Farm, tạo các mùa thu hoạch ở mục Harvests và xem kết quả của các mùa thu hoạch đó ở Dashboard.',
                    style: TextStyle(
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
