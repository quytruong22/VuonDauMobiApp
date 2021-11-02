import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-selling.dart';
import 'package:vuondauapp/widgets/compoment/search_widget.dart';

class Selling extends StatefulWidget {
  const Selling({Key? key}) : super(key: key);

  @override
  _SellingState createState() => _SellingState();
}

class _SellingState extends State<Selling> {
  List<HarvestDTO> data = [
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Vụ Dâu Đà Lạt Mùa Đông', description: '', price: 100000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Cà Chua', description: '', img: 'https://hoayeuthuong.com/hinh-hoa-tuoi/moingay/11894_ca-chua-kg.jpg',
        date: DateTime.now()), name: 'Vụ Cà chua Đà Lạt Mùa Đông', description: '', price: 50000, quantity: 100),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Cải thảo', description: '', img: 'https://images.unsplash.com/photo-1614540527480-1a0818eafcbb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80',
        date: DateTime.now()), name: 'Vụ rau Cải Thảo Đà Lạt Mùa Đông', description: '', price: 20000, quantity: 70),
  ];
  late List<HarvestDTO> list;
  String query = '';

  @override
  void initState() {
    super.initState();

    list = data;
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Tên đợt bán',
    onChanged: searchSelling,
  );

  void searchSelling(String query) {
    list = data.where((selling) {
      final namelower = selling.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return namelower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.list=list;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Đợt bán'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/addselling');
        },
        icon: Icon(Icons.add),
        label: Text('Đợt bán mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildSearch(),
              Column(
                children: list.map((harvest) => Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
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
              SizedBox(height: 45,)
            ],
          ),
        ),
      ),
    );
  }
}