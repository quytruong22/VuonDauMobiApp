import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-farm-detail.dart';

class DetailFarm extends StatefulWidget {
  const DetailFarm({Key? key}) : super(key: key);

  @override
  _DetailFarmState createState() => _DetailFarmState();
}

class _DetailFarmState extends State<DetailFarm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Nông trại'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Farms"),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardFarmDetail(
                      description: "Mô tả: Nông trại Phan Nam thu hút khá đông các cặp đôi và gia đình đến quay phim chụp ảnh cưới, ảnh kỷ niệm và thu hút học sinh các trường trải nghiệm \"Chương trình 1 ngày làm nông dân\". Mới đây, Thành Đoàn phối hợp Nông trại Phan Nam tổ chức chương trình vui hội trung thu cùng nông trại cho 170 em học sinh xã Mỹ Khánh và Mỹ Hòa Hưng. Tại đây các em được tham quan nhà lưới trồng cây an toàn, trải nghiệm trồng hoa, làm lồng đèn giấy, chơi trò chơi... Em Trần Thị Ngọc Điệp, Trường tiểu học Nguyễn Trung Trực cho biết: em rất thích các hoạt động này giúp em trải nghiệm và tham quan thực tế.",
                      name: 'Nông trại Phan Nam',
                      img: 'https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg',
                      address: 'Địa chỉ: Mỹ Khánh, Thành phố Long Xuyên, An Giang',
                      ),
                ),
                RoundedButton(
                  text: "Tạo mùa vụ mới",
                  press: () {
                    Navigator.pushReplacementNamed(context, '/addharvest');
                  },
                ),
                Text(
                  'Các mùa vụ hiện tại',
                  style: TextStyle(

                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardHarvest(
                      cta: "Xem chi tiết",
                      title: 'Dâu',
                      img: 'https://cdn.tgdd.vn/Products/Images/8788/223378/bhx/dau-tay-hop-500g-202103180809491848.jpg',
                      quantity: 'Sản lượng còn lại: 50 Kg',
                      price: 'Giá: 50.000VND/Kg',
                      tap: () {
                        Navigator.pushNamed(context, '/detailharvest');
                      }),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardHarvest(
                      cta: "Xem chi tiết",
                      title: 'Dâu',
                      img: 'https://cdn.tgdd.vn/Products/Images/8788/223378/bhx/dau-tay-hop-500g-202103180809491848.jpg',
                      quantity: 'Sản lượng còn lại: 50 Kg',
                      price: 'Giá: 50.000VND/Kg',
                      tap: () {
                        Navigator.pushNamed(context, '/detailharvest');
                      }),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardHarvest(
                      cta: "Xem chi tiết",
                      title: 'Dâu',
                      img: 'https://cdn.tgdd.vn/Products/Images/8788/223378/bhx/dau-tay-hop-500g-202103180809491848.jpg',
                      quantity: 'Sản lượng còn lại: 50 Kg',
                      price: 'Giá: 50.000VND/Kg',
                      tap: () {
                        Navigator.pushNamed(context, '/detailharvest');
                      }),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardHarvest(
                      cta: "Xem chi tiết",
                      title: 'Dâu',
                      img: 'https://cdn.tgdd.vn/Products/Images/8788/223378/bhx/dau-tay-hop-500g-202103180809491848.jpg',
                      quantity: 'Sản lượng còn lại: 50 Kg',
                      price: 'Giá: 50.000VND/Kg',
                      tap: () {
                        Navigator.pushNamed(context, '/detailharvest');
                      }),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
