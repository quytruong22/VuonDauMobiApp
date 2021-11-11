import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
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
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';

class NavigationPage extends StatefulWidget {

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final HttpService httpService = HttpService();
  int _selectedIndex=0;
  PageController pageController = PageController();
  final LocalStorage storage = LocalStorage('farmer_info');
  String farmerID = "";

  void onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Home(),
          Dashboard(),
          sellingPage(context),
          harvestPage(context),
          Profile()
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

  Widget sellingPage(BuildContext context){
    return FutureBuilder(
        future: httpService.getAllSellings(farmerID),
        builder: (BuildContext context, AsyncSnapshot<List<HarvestSellingPriceDTO>> snapshot){
          if(snapshot.hasData){
            List<HarvestSellingPriceDTO> list=snapshot.requireData;
            return Selling(listSelling: list);
          }
          if(snapshot.hasError){
            return  Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  title: Text('Đợt bán'),
                  centerTitle: true,
                ),
                body: Center(child: Text('Chưa có đợt bán nào'))
            );
          }
          return Scaffold(
              appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Đợt bán'),
          centerTitle: true,
          ),
          body: Center(child: CircularProgressIndicator())
          );
        });
  }
  Widget harvestPage(BuildContext context){
    return FutureBuilder(
        future: httpService.getListAllHarvests(farmerID),
        builder: (BuildContext context, AsyncSnapshot<List<HarvestDTO>> snapshot){
          if(snapshot.hasData){
            List<HarvestDTO> list=snapshot.requireData;
            return Harvest(listHarvest: list);
          }
          if(snapshot.hasError){
            return  Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  title: Text('Đợt bán'),
                  centerTitle: true,
                ),
                body: Center(child: Text('Chưa có mùa vụ nào'))
            );
          }
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: Text('Mùa vụ'),
                centerTitle: true,
              ),
              body: Center(child: CircularProgressIndicator())
          );
        });
  }
}
