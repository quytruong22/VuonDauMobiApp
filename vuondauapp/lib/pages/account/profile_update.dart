import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Update Profile'),
          centerTitle: true,
          elevation: 0,
        ),
      body: TextButton.icon(
          onPressed: (){},
          icon: Icon(Icons.update),
          label: Text(
              'Update'
          ),
      ),
    );
  }
}
