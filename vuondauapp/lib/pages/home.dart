import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';
import 'package:vuondauapp/widgets/compoment/square_button.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FarmDTO> listfarm = [
    FarmDTO(ID: 0,name: 'Nông trại Phan Nam',address: '',description: '', img: 'https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg'),
    FarmDTO(ID: 0, name: 'Nông trại Whiteface', address: '', description: '', img: 'https://kenh14cdn.com/M2JlccccccccccccEmJzVu2ZOVx8FL/Image/2015a/trangtrai/6-b1900.jpg'),
    FarmDTO(ID: 0, name: 'Trường Thành Farm', address: '', description: '', img: 'https://tamnhin.trithuccuocsong.vn/stores/news_dataimages/phonghv/072019/18/07/5336_20190715_145456.jpg')
  ];
  List<HarvestDTO> listharvest = [
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Dâu', description: '', price: 50000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Dâu', description: '', price: 50000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Dâu', description: '', price: 50000, quantity: 50),
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
      drawer: pageDrawer(currentPage: "Home"),
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                width: size.width,
                child: Text(
                  'Các dịch vụ chính',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    SquareButton(
                      text: 'Thêm nông trại',
                      icon: MyCustomIcons.farm,
                      color: Colors.orangeAccent,
                      press: (){Navigator.pushNamed(context, '/addfarm');},
                    ),
                    SquareButton(
                      text: 'Tạo đợt bán',
                      icon: Icons.agriculture,
                      color: Colors.black,
                      press: (){Navigator.pushNamed(context, '/addharvest');},
                    ),
                    SquareButton(
                      text: 'Xác nhận đơn hàng',
                      icon: Icons.shopping_cart,
                      color: Colors.red,
                      press: (){},
                    ),
                    SquareButton(
                      text: 'Thống kê',
                      icon: Icons.dashboard,
                      color: Colors.purple,
                      press: (){Navigator.pushReplacementNamed(context, '/dashboard');},
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                width: size.width,
                child: Text(
                  'Các đợt bán hiện tại của bạn',
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
                                  quantity: 'Số lượng còn lại: ${harvest.quantity} Kg',
                                  price: 'Giá: ${harvest.price}VND/Kg',
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
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                width: size.width,
                child: Text(
                  'Nông trại của bạn',
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
                      children: listfarm.map((farm) => Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: CardFarm(
                                  cta: "Xem chi tiết",
                                  title: farm.name,
                                  img: farm.img,
                                  tap: () {
                                    Navigator.pushNamed(context, '/detailfarm');
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
