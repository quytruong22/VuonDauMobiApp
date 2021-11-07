import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/feedback_dto.dart';
import 'package:vuondauapp/services/http_service_order.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final HttpOrderService httpOrderService = HttpOrderService();
  final LocalStorage storage = LocalStorage('farmer_info');

  String feedbackDescription = '';

  bool disable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String farmerID = "";

    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String orderID = "";
    String customerName = "";
    String harvestID = "";
    if (arguments != null) {
      List<String> dataTmp = arguments['dataForFeedback'].split('/');
      orderID = dataTmp[0];
      harvestID = dataTmp[1];
      customerName = dataTmp[2];
    }

    Future<void> createFeedback() async {
      Map data = {
        'order_id': '$orderID',
        'harvest_id': '$harvestID',
        'farmer_id': '$farmerID',
        'description': '$feedbackDescription',
      };
      var body = json.encode(data);
      Response res = await post(
          Uri.parse('http://52.221.245.187:90/api/v1/feedbacks'),
          headers: {"Content-Type": "application/json"},
          body: body);
      if (res.statusCode == 201) {
        Navigator.pop(context);
      } else {
        throw "Cannot get create feedback";
      }
    }

    Future<void> updateFeedback(feedbackFarmerId) async {
      Map data = {
        'order_id': '$orderID',
        'harvest_id': '$harvestID',
        'farmer_id': '$farmerID',
        'description': '$feedbackDescription',
        'status': 1
      };
      var body = json.encode(data);
      Response res = await put(
          Uri.parse('http://52.221.245.187:90/api/v1/feedbacks/$feedbackFarmerId'),
          headers: {"Content-Type": "application/json"},
          body: body);
      if (res.statusCode == 200) {
        disable = false;
        setState(() {});
      } else {
        throw "Cannot get create feedback";
      }
    }

    String enableUpdate() {
      if(disable) return "Cập nhật";
      return "";
    }

    String enableEdit() {
      if(disable) return "Tắt chỉnh sửa";
      return "Bật chỉnh sửa";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Đánh giá'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Đánh giá từ người dùng',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.fromLTRB(
                      size.width * 0.02, 5, size.width * 0.02, 0),
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(blurRadius: 10)],
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: httpOrderService.getFeedback(orderID),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<FeedbackDTO>> snapshot) {
                            if (snapshot.hasData) {
                              List<FeedbackDTO> feedback = snapshot.requireData;
                              List<FeedbackDTO> feedbackFilter = [];
                              feedback.forEach((FeedbackDTO dto) {
                                if (dto.harvest["id"] == harvestID) {
                                  feedbackFilter.add(dto);
                                }
                              });
                              if (feedbackFilter.length == 1) {
                                List<String> dateTmp =
                                    feedbackFilter[0].date_of_create.split('T');
                                ;
                                String dateTime = '${dateTmp[0]} ${dateTmp[1]}';
                                return (Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customerName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            size.width * 0,
                                            10,
                                            size.width * 0,
                                            0),
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 10, 5),
                                        width: size.width * 0.8,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(blurRadius: 1)
                                          ],
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(feedbackFilter[0]
                                                  .description),
                                              const SizedBox(height: 10),
                                              Text(dateTime,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  )),
                                            ])),
                                    const SizedBox(height: 25),
                                    const Text(
                                      'Phản hồi:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          size.width * 0,
                                          10,
                                          size.width * 0,
                                          0),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 5),
                                      width: size.width * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(blurRadius: 1)
                                        ],
                                        border: Border.all(
                                            color: Colors.lightBlueAccent,
                                            width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              feedbackDescription = value;
                                            },
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'PLEASE ENTER YOUR RESPONSE',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          size.width * 0.08,
                                          10,
                                          size.width * 0.08,
                                          0),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 5),
                                      width: size.width * 0.5,
                                      child: RoundedButton(
                                        text: "PHẢN HỒI",
                                        press: () {
                                          createFeedback();
                                        },
                                      ),
                                    )
                                  ],
                                ));
                              } else if (feedbackFilter.length == 2) {
                                List<String> dateTmp =
                                    feedbackFilter[0].date_of_create.split('T');
                                ;
                                String dateTime = '${dateTmp[0]} ${dateTmp[1]}';
                                String customerFeedback = "";
                                String farmerFeedback = "";
                                String feedbackFarmerid = "";
                                if (feedbackFilter[0].farmer == null) {
                                  customerFeedback =
                                      feedbackFilter[0].description;
                                  farmerFeedback =
                                      feedbackFilter[1].description;
                                  feedbackFarmerid = feedbackFilter[1].id;
                                } else {
                                  farmerFeedback =
                                      feedbackFilter[0].description;
                                  customerFeedback =
                                      feedbackFilter[1].description;
                                  feedbackFarmerid = feedbackFilter[0].id;
                                }
                                feedbackDescription = farmerFeedback;
                                return (Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customerName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            size.width * 0,
                                            10,
                                            size.width * 0,
                                            0),
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 10, 5),
                                        width: size.width * 0.8,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(blurRadius: 1)
                                          ],
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(customerFeedback),
                                              const SizedBox(height: 10),
                                              Text(dateTime,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  )),
                                            ])),
                                    const SizedBox(height: 25),
                                    const Text(
                                      'Phản hồi:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          size.width * 0,
                                          10,
                                          size.width * 0,
                                          0),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 5),
                                      width: size.width * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(blurRadius: 1)
                                        ],
                                        border: Border.all(
                                            color: Colors.lightBlueAccent,
                                            width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            initialValue: farmerFeedback,
                                            onChanged: (value) {
                                              feedbackDescription = value;
                                            },
                                            textAlign: TextAlign.left,
                                            enabled: disable,
                                            maxLines: 3,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'PLEASE ENTER YOUR RESPONSE',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        FlatButton(
                                            onPressed: () {
                                              disable = !disable;
                                              setState(() {});
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  size.width * 0,
                                                  10,
                                                  size.width * 0,
                                                  0),
                                              width: size.width * 0.3,
                                              child: Text(
                                                enableEdit(),
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                        FlatButton(
                                            onPressed: () {
                                              updateFeedback(feedbackFarmerid);
                                              setState(() {});
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  size.width * 0,
                                                  10,
                                                  size.width * 0,
                                                  0),
                                              width: size.width * 0.3,
                                              child: Text(
                                                enableUpdate(),
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ));
                              }
                            } else {
                              return const Text(
                                "Khách hàng chưa đánh giá",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
