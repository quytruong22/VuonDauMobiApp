import 'package:flutter/material.dart';

class BarBottom extends StatelessWidget {
  static const List<String> pages = <String>['/home', '/profile'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: (int index){
        Navigator.pushReplacementNamed(context, pages[index]);
      },
    );
  }
}
