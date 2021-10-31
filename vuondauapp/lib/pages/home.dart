import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-selling.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';
import 'package:vuondauapp/widgets/compoment/square_button.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HarvestDTO> listharvest = [
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Vụ Dâu Đà Lạt Mùa Đông', description: '', price: 100000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Cà Chua', description: '', img: 'https://hoayeuthuong.com/hinh-hoa-tuoi/moingay/11894_ca-chua-kg.jpg',
        date: DateTime.now()), name: 'Vụ Cà chua Đà Lạt Mùa Đông', description: '', price: 50000, quantity: 100),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Cải thảo', description: '', img: 'https://images.unsplash.com/photo-1614540527480-1a0818eafcbb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80',
        date: DateTime.now()), name: 'Vụ rau Cải Thảo Đà Lạt Mùa Đông', description: '', price: 20000, quantity: 70),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Trang chủ'),
        centerTitle: true
      ),
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Container(
              //  padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
              //  width: size.width,
              //  child: Text(
              //    'Các dịch vụ chính',
              //    textAlign: TextAlign.left,
              //    style: TextStyle(
              //      fontWeight: FontWeight.bold
              //    ),
              //  ),
              //),
              Container(
                child: Row(
                  children: [
                    SquareButton(
                      text: 'Thêm nông trại',
                      icon: MyCustomIcons.farm,
                      color: Colors.lightGreen,
                      press: (){Navigator.pushNamed(context, '/addfarm');},
                    ),
                    SquareButton(
                      text: 'Tạo đợt bán',
                      icon: Icons.agriculture,
                      color: Colors.lightGreen,
                      press: (){Navigator.pushNamed(context, '/addharvest');},
                    ),
                    SquareButton(
                      text: 'Xác nhận đơn hàng',
                      icon: Icons.shopping_cart,
                      color: Colors.lightGreen,
                      press: (){},
                    ),
                    SquareButton(
                      text: 'Thống kê',
                      icon: Icons.dashboard,
                      color: Colors.lightGreen,
                      press: (){Navigator.pushReplacementNamed(context, '/dashboard');},
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                width: size.width,
                child: Text(
                  'Các đợt bán hiện tại',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                  width: size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: listharvest.map((harvest) => Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: CardSelling(
                                  cta: "Xem chi tiết",
                                  title: harvest.name,
                                  img: harvest.product.img,
                                  nameProduct: 'Sản phẩm: '+harvest.product.name,
                                  quantity: 'Tổng sản lượng: ${harvest.quantity} Kg',
                                  sold: 'Số lượng đã bán: 10 Kg',
                                  price: 'Giá: ${harvest.price}VND/Kg',
                                  tap: () {
                                    Navigator.pushNamed(context, '/detailselling');
                                  }),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                width: size.width,
                child: Text(
                  'Các mùa vụ của bạn',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                width: size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: listharvest.map((harvest) => Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: CardHarvest(
                                  cta: "Xem chi tiết",
                                  title: harvest.name,
                                  img: harvest.product.img,
                                  nameFarm: "Nông trại Phan Nam",
                                  sold: DateTime.now(),
                                  tap: () {
                                    Navigator.pushNamed(context, '/detailharvest');
                                  }),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
