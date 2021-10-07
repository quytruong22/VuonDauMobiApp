import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';
import 'package:vuondauapp/widgets/drawer-tile.dart';

class pageDrawer extends StatelessWidget {
  final String currentPage;

  pageDrawer({required this.currentPage});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
      color: Colors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset('assets/images/iconVuondau.png'),
                ),
              ),
            )
        ),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: MyCustomIcons.farm,
                  onTap: () {
                    if (currentPage != "Farms")
                      Navigator.pushReplacementNamed(context, '/farmlist');
                  },
                  iconColor: Colors.orangeAccent,
                  title: "Farms",
                  isSelected: currentPage == "Farms" ? true : false),
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Harvests")
                      Navigator.pushReplacementNamed(context, '');
                  },
                  iconColor: Colors.green,
                  title: "Harvests",
                  isSelected: currentPage == "Harvests" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Products")
                      Navigator.pushReplacementNamed(context, '');
                  },
                  iconColor: Colors.blue,
                  title: "Products",
                  isSelected: currentPage == "Products" ? true : false),
              DrawerTile(
                  icon: Icons.contact_support,
                  onTap: () {
                    if (currentPage != "About us")
                      Navigator.pushReplacementNamed(context, '');
                  },
                  iconColor: Colors.yellow,
                  title: "About us",
                  isSelected: currentPage == "About us" ? true : false),
              DrawerTile(
                  icon: Icons.logout,
                  onTap: () {
                     Navigator.pushReplacementNamed(context, '/login');
                  },
                  iconColor: Colors.red,
                  title: "Sign out",
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
