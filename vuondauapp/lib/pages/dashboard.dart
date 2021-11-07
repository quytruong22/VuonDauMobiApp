import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/order_detail_dto.dart';
import 'package:vuondauapp/object/order_dto.dart';
import 'package:vuondauapp/services/http_service_order.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final HttpOrderService httpOrderService = HttpOrderService();
  final LocalStorage storage = LocalStorage('farmer_info');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String farmerID = "";
    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }

    Color getStatusColor(status) {
      if (status == 0) return Colors.red;
      if (status == 1) return Colors.blue;
      if (status == 2) return Colors.cyanAccent;
      return Colors.green;
    }

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
              FutureBuilder(
                  future: httpOrderService.getOrderDetailForFarmer(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<OrderDetailDTO>> snapshot) {
                    if(snapshot.hasData){
                      List<OrderDetailDTO> orderDetail = snapshot.requireData;
                      List<OrderDetailDTO> orderDetailFilter = [];
                      double profit = 0;
                      orderDetail.forEach((OrderDetailDTO dto) {
                        if (dto.harvestselling["harvest"]["farm"]["farmer"]
                        ["id"] ==
                            farmerID) {
                          orderDetailFilter.add(dto);
                          profit += dto.price * dto.weight;
                        }
                      });
                      return Row(
                        children: [
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
                              'TOTAL ORDER:\n${orderDetailFilter.length}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                size.width * 0.02, 5, size.width * 0.08, 0),
                            padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [BoxShadow(blurRadius: 1)],
                              border: Border.all(color: Colors.green, width: 1),
                            ),
                            child: Text(
                              'YOUR PROFIT:\n${profit} VNĐ',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  'Your Recent Orders',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              FutureBuilder(
                future: httpOrderService.getOrderDetailForFarmer(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<OrderDetailDTO>> snapshot) {
                  if (snapshot.hasData) {
                    List<OrderDetailDTO> orderDetail = snapshot.requireData;
                    List<OrderDetailDTO> orderDetailFilter = [];
                    orderDetail.forEach((OrderDetailDTO dto) {
                      if (dto.harvestselling["harvest"]["farm"]["farmer"]
                              ["id"] ==
                          farmerID) {
                        orderDetailFilter.add(dto);
                      }
                    });
                    return Column(
                      children: orderDetailFilter
                          .map((OrderDetailDTO dto) => Container(
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(children: [
                                            Text(
                                              '#${orderDetail.indexOf(dto) + 1} ',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${dto.order["customer"]["full_name"]}',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Total price: ${dto.price * dto.weight}',
                                            style: TextStyle(
                                              color: Colors.red[500],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Harvest: ${dto.harvestselling["harvest"]["name"]}',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Product: ${dto.harvestselling["harvest"]["product"]["name"]}',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Status: ${dto.status == 0 ? "Đã Hủy" : dto.status == 1 ? "Đã Đặt" : dto.status == 2 ? "Đang giao" : "Đã Nhận"}',
                                        style: TextStyle(
                                          color: getStatusColor(dto.status),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )))
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
