import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePic extends StatelessWidget{
  const ProfilePic({
    Key? key,
}) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height:115,
      width:115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_image.jpg"),
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    primary: Colors.black54,
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {},
                  child: Icon(Icons.camera_alt_rounded),
                ),
            ),
          )
        ],
      ),
    );
  }
}