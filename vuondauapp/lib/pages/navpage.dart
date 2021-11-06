import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/pages/home.dart';
import 'package:vuondauapp/pages/account/profile.dart';
import 'package:vuondauapp/pages/harvest/harvest.dart';
import 'package:vuondauapp/pages/dashboard.dart';
import 'package:vuondauapp/pages/selling/selling.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';

class NavigationPage extends StatefulWidget {
  final List<FarmDTO> farms;
  final List<HarvestDTO> harvests;
  final List<HarvestSellingPriceDTO>  sellings;
  final FarmerDTO farmer;


  NavigationPage({required this.harvests, required this.sellings,required this.farms,required this.farmer});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final FarmerDTO farmer=ModalRoute.of(context)!.settings.arguments as FarmerDTO;
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Home(listselling: widget.sellings,listharvest: widget.harvests),
          Dashboard(),
          Selling(sellings: widget.sellings),
          Harvest(harvests: widget.harvests),
          Profile(farmer: farmer)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ',backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Hóa đơn',backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'Đợt bán',backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(MyCustomIcons.farm), label: 'Mùa vụ',backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Hồ sơ',backgroundColor: Colors.green),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
