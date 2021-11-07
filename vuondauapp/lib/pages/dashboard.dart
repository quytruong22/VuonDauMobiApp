import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuondauapp/object/order_dto.dart';
import 'package:vuondauapp/services/http_service_order.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final HttpOrderService httpOrderService = HttpOrderService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Order'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
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
                    margin: EdgeInsets.fromLTRB(
                        size.width * 0.08, 5, size.width * 0.02, 0),
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(blurRadius: 1)],
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: Text(
                      '12\nORDERS',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        size.width * 0.02, 5, size.width * 0.08, 0),
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 5),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(blurRadius: 1)],
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: Text(
                      '200,000 VNĐ\nPROFIT',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              FutureBuilder(
                future: httpOrderService.getOrder(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<OrderDTO>> snapshot) {
                  if (snapshot.hasData) {
                    List<OrderDTO> orders = snapshot.requireData;
                    return Column(
                      children: orders
                          .map((OrderDTO dto) => Container(
                          margin: EdgeInsets.fromLTRB(
                              size.width * 0.08, 5, size.width * 0.08, 5),
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
                          width: size.width * 0.84,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [BoxShadow(blurRadius: 1)],
                            border:
                            Border.all(color: Colors.green, width: 1),
                          ),
                          child: Row(children: [
                            Text(
                              '#${orders.indexOf(dto) + 1}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${dto.customer["email"]}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],)

                      ))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
