import 'package:flutter/material.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FlatButton(
            padding: EdgeInsets.all(20),
            shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profileupdate');
            },
            color: Colors.lightGreenAccent,
            child: Row(
              children: [
                Icon(Icons.account_circle_outlined),
                SizedBox(width: 20),
                Expanded(child: Text(
                    "My Account",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FlatButton(
            padding: EdgeInsets.all(20),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {

            },
            color: Colors.lightGreenAccent,
            child: Row(
              children: [
                Icon(Icons.vpn_key_outlined),
                SizedBox(width: 20),
                Expanded(child: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.bodyText1,
                )
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
