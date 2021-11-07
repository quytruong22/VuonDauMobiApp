import 'dart:convert';
import 'package:http/http.dart';
import 'package:vuondauapp/object/order_detail_dto.dart';
import 'package:vuondauapp/object/order_dto.dart';

class HttpOrderService {
  final String endPoint = "http://52.221.245.187:90/";
  Future<List<OrderDTO>> getOrder() async {
    Response res =
        await get(Uri.parse(endPoint + 'api/v1/orders'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<OrderDTO> listOrder =
          body.map((dynamic item) => OrderDTO.fromJson(item)).toList();
      return listOrder;
    } else {
      throw "Cannot get Order";
    }
  }


  Future<List<OrderDetailDTO>> getOrderDetailForFarmer() async {
    Response res =
    await get(Uri.parse(endPoint + 'api/v1/order-details'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<OrderDetailDTO> listOrderDetailDTO =
      body.map((dynamic item) => OrderDetailDTO.fromJson(item)).toList();
      return listOrderDetailDTO;
    } else {
      throw "Cannot get Order";
    }
  }
}
