import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/pages/home.dart';
import 'package:vuondauapp/pages/account/profile.dart';
import 'package:vuondauapp/pages/harvest/harvest.dart';
import 'package:vuondauapp/pages/dashboard.dart';
import 'package:vuondauapp/pages/selling/selling.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';
import 'package:http/http.dart' as http;

class NavigationPage extends StatefulWidget {
  final FarmerDTO farmer;

  NavigationPage({required this.farmer});

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
  List<FarmDTO>  listFarms=[];
  List<HarvestDTO> listHarvests=[];
  List<HarvestSellingPriceDTO> listSellings=[];

  Future<void> loadData() async{
    final responseFarm = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farms/${widget.farmer.id}'));
    if(responseFarm.statusCode==200){
      listFarms = ListFarms.fromJson(jsonDecode(responseFarm.body)).farms;
      listFarms.forEach((farm) async {
        final responseHarvest = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvests/${farm.ID}'));
        if(responseHarvest.statusCode==200){
          final listgetharvest  = ListHarvests.fromJson(jsonDecode(responseHarvest.body)).harvests;
          listHarvests.addAll(listgetharvest);
          listgetharvest.forEach((harvest) async {
            final responseHarvestSelling = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvest-sellings/${harvest.ID}'));
            if(responseHarvestSelling.statusCode==200){
              final listgetHarvestSelling  = ListHarvestSelling.fromJson(jsonDecode(responseHarvestSelling.body)).harvestsellings;
              listgetHarvestSelling.forEach((harvestSelling) async {
                final responseHarvestSellingPrice = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvest-selling-prices/${harvestSelling.id}'));
                if(responseHarvestSellingPrice.statusCode==200){
                  final harvestSellingPrice = ListHarvestSellingPrice.fromJson(jsonDecode(responseHarvestSellingPrice.body)).harvestsellingprice;
                  listSellings.addAll(harvestSellingPrice);
                }
              });
            }
          });
        }
      });
    }
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Home(listselling: listSellings,listharvest: listHarvests,farmer: widget.farmer),
          Dashboard(),
          Selling(sellings: listSellings,harvests:listHarvests),
          Harvest(harvests: listHarvests,farms:listFarms),
          Profile(farmer: widget.farmer)
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
