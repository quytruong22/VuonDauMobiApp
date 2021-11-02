import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: Text(
                  'Overview',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.08, 5, size.width * 0.02, 0),
                    padding: EdgeInsets.fromLTRB(15,10,10,5),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1
                        )],
                      border: Border.all(
                          color: Colors.green,
                          width: 1
                      ),
                    ),
                    child: Text(
                      '4\nORDERS',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.02, 5, size.width * 0.08, 0),
                    padding: EdgeInsets.fromLTRB(15,10,10,5),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1
                        )],
                      border: Border.all(
                          color: Colors.green,
                          width: 1
                      ),
                    ),
                    child: Text(
                      '100000\nTOTAL SALES',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.08, 5, size.width * 0.02, 0),
                    padding: EdgeInsets.fromLTRB(15,10,10,5),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1
                        )],
                      border: Border.all(
                          color: Colors.green,
                          width: 1
                      ),
                    ),
                    child: Text(
                      '2\nALL CUSTOMERS',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.02, 5, size.width * 0.08, 5),
                    padding: EdgeInsets.fromLTRB(15,10,10,10),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1
                        )],
                      border: Border.all(
                          color: Colors.green,
                          width: 1
                      ),
                    ),
                    child: Text(
                      '30\nTOTAL PRODUCTS',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width * 0.08, 5, size.width * 0.08, 5),
                padding: EdgeInsets.fromLTRB(15,10,10,5),
                width: size.width * 0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1
                    )],
                  border: Border.all(
                      color: Colors.green,
                      width: 1
                  ),
                ),
                child: Text(
                  '#001 (10 items) | 05/10/2021 05:57 PM\nHuyền\n50.000 VND\n',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width * 0.08, 5, size.width * 0.08, 5),
                padding: EdgeInsets.fromLTRB(15,10,10,5),
                width: size.width * 0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1
                    )],
                  border: Border.all(
                      color: Colors.green,
                      width: 1
                  ),
                ),
                child: Text(
                  '#021 (10 items) | 05/10/2021 05:57 PM\nHuyền\n50.000 VND\n',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width * 0.08, 5, size.width * 0.08, 5),
                padding: EdgeInsets.fromLTRB(15,10,10,5),
                width: size.width * 0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1
                    )],
                  border: Border.all(
                      color: Colors.green,
                      width: 1
                  ),
                ),
                child: Text(
                  '#219 (10 items) | 05/10/2021 05:57 PM\nHuyền\n50.000 VND\n',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.width * 0.08, 5, size.width * 0.08, 5),
                padding: EdgeInsets.fromLTRB(15,10,10,5),
                width: size.width * 0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1
                    )],
                  border: Border.all(
                      color: Colors.green,
                      width: 1
                  ),
                ),
                child: Text(
                  '#244 (10 items) | 05/10/2021 05:57 PM\nHuyền\n50.000 VND\n',
                  style: TextStyle(
                    color: Colors.grey[700],
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

