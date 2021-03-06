import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/order_detail_dto.dart';
import 'package:vuondauapp/object/order_dto.dart';
import 'package:vuondauapp/services/http_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final HttpService httpOrderService = HttpService();
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

    final oCcy = new NumberFormat("#,##0.00", "en_US");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Hóa đơn'),
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
                  'Thống kê',
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
                    if (snapshot.hasData) {
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
                                border:
                                    Border.all(color: Colors.green, width: 1),
                              ),
                              child: Column(children: [
                                Text(
                                  'TỔNG ĐƠN HÀNG',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${orderDetailFilter.length}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.02, 5, size.width * 0.08, 0),
                              padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [BoxShadow(blurRadius: 1)],
                                border:
                                    Border.all(color: Colors.green, width: 1),
                              ),
                              child: Column(children: [
                                Text(
                                  'DOANH THU',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  '${oCcy.format(profit)}đ',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ])),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  'Lịch sử đơn hàng',
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
                          .map(
                            (OrderDetailDTO dto) => Container(
                                margin: EdgeInsets.fromLTRB(
                                    size.width * 0.08, 5, size.width * 0.08, 5),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 10, 5),
                                width: size.width * 0.84,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [BoxShadow(blurRadius: 1)],
                                  border:
                                      Border.all(color: Colors.green, width: 1),
                                ),
                                child: FlatButton(
                                    onPressed: () {
                                      if (dto.order['status'] == 3) {
                                        Navigator.pushNamed(
                                            context, '/feedback',
                                            arguments: {
                                              'dataForFeedback':
                                                  '${dto.order["id"]}/${dto.harvestselling["harvest"]["id"]}/${dto.order["customer"]["full_name"]}'
                                            });
                                      }
                                    },
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${dto.order["customer"]["full_name"]}',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ])
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Tổng: ${oCcy.format(dto.price * dto.weight)}đ',
                                                  style: TextStyle(
                                                    color: Colors.red[700],
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
                                              'Mùa vụ: ${dto.harvestselling["harvest"]["name"]}',
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
                                              'Sản phẩm: ${dto.harvestselling["harvest"]["product"]["name"]}',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Trạng thái: ${dto.order['status'] == 0 ? "Đã Hủy" : dto.order['status'] == 1 ? "Đã Đặt" : dto.order['status'] == 2 ? "Đang giao" : "Đã Nhận"}',
                                              style: TextStyle(
                                                color: getStatusColor(
                                                    dto.order['status']),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ))),
                          )
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
