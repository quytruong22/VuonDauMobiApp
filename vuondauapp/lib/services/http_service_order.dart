import 'dart:convert';
import 'package:http/http.dart';
import 'package:vuondauapp/object/order_dto.dart';

class HttpOrderService {
  Future<List<OrderDTO>> getOrder() async {
    Response res =
        await get(Uri.parse('http://52.221.245.187:90/api/v1/orders'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<OrderDTO> listOrder =
          body.map((dynamic item) => OrderDTO.fromJson(item)).toList();
      return listOrder;
    } else {
      throw "Cannot get Order";
    }
  }
}
