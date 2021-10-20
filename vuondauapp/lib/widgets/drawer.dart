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
  /*            DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacementNamed(context, '/home');
                  },
                  iconColor: Colors.orangeAccent,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),*/
              DrawerTile(
                  icon: Icons.dashboard,
                  onTap: () {
                    if (currentPage != "Dashboard")
                      Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  iconColor: Colors.orangeAccent,
                  title: "Bảng thống kê",
                  isSelected: currentPage == "Dashboard" ? true : false),
              DrawerTile(
                  icon: MyCustomIcons.farm,
                  onTap: () {
                    if (currentPage != "Farms")
                      Navigator.pushReplacementNamed(context, '/farm');
                  },
                  iconColor: Colors.orangeAccent,
                  title: "Nông trại",
                  isSelected: currentPage == "Farms" ? true : false),
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Harvests")
                      Navigator.pushReplacementNamed(context, '/harvest');
                  },
                  iconColor: Colors.green,
                  title: "Mùa vụ",
                  isSelected: currentPage == "Harvests" ? true : false),
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Products")
                      Navigator.pushReplacementNamed(context, '/product');
                  },
                  iconColor: Colors.green,
                  title: "Sản phẩm",
                  isSelected: currentPage == "Products" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushReplacementNamed(context, '/profile');
                  },
                  iconColor: Colors.blue,
                  title: "Thông tin cá nhân",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.contact_support,
                  onTap: () {
                    if (currentPage != "AboutUs")
                      Navigator.pushReplacementNamed(context, '/aboutus');
                  },
                  iconColor: Colors.yellow,
                  title: "About us",
                  isSelected: currentPage == "AboutUs" ? true : false),
              DrawerTile(
                  icon: Icons.logout,
                  onTap: () {
                     Navigator.pushReplacementNamed(context, '/login');
                  },
                  iconColor: Colors.red,
                  title: "Đăng xuất",
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
