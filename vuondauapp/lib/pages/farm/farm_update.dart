import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmPicture.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';

class UpdateFarm extends StatefulWidget {
  final List<AreaDTO> listArea;
  final List<FarmType> listFarmType;
  final FarmDTO farm;
  final FarmPicture image;

  UpdateFarm({required this.listArea, required this.listFarmType,required this.farm,required this.image});

  @override
  _UpdateFarmState createState() => _UpdateFarmState();
}

class _UpdateFarmState extends State<UpdateFarm> {
  File? image;
  final HttpService httpService = HttpService();
  final picker = ImagePicker();
  String  name = '';
  String  address = '';
  String  description = '';
  String  link = '';
  late AreaDTO _Choosearea;
  late FarmType _ChoosefarmType;
  late FarmDTO farm;

  @override
  void initState() {
    super.initState();
    farm  = widget.farm;
    address=farm.address;
    description=farm.description;
    name=farm.name;
    widget.listArea.forEach((area) {
      if(area.ID==farm.area.ID){
        _Choosearea=area;
      }
    });
    widget.listFarmType.forEach((farmtype) {
      if(farmtype.id==farm.farmType.id){
        _ChoosefarmType=farmtype;
      }
    });
  }

  Future  pickImage(ImageSource source) async {
    try{
      final image = await picker.pickImage(source: source);
      if(image==null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch(e){
      print('failed to pick image: '+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('C???p nh???t n??ng tr???i'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width-20,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Nh???p m???i th??ng tin n??ng tr???i',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'V??ng c???a n??ng tr???i',
                style: TextStyle(

                ),
              ),
              TextFieldContainer(
                child: DropdownButton(
                  value: _Choosearea,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (AreaDTO? newValue) {
                    setState(() {
                      _Choosearea = newValue!;
                    });
                  },
                  items: widget.listArea
                      .map((AreaDTO value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Lo???i n??ng tr???i',
                style: TextStyle(

                ),
              ),
              TextFieldContainer(
                child: DropdownButton(
                  value: _ChoosefarmType,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (FarmType? newValue) {
                    setState(() {
                      _ChoosefarmType = newValue!;
                    });
                  },
                  items: widget.listFarmType
                      .map((FarmType value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'T??n n??ng tr???i',
                style: TextStyle(

                ),
              ),
              RoundedInputForm(
                icon: Icons.drive_file_rename_outline,
                value: name,
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                '?????a ch??? n??ng tr???i',
                style: TextStyle(

                ),
              ),
              RoundedInputForm(
                icon: Icons.location_on,
                value: address,
                onChanged: (value) {
                  address = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'M?? t??? n??ng tr???i',
                style: TextStyle(

                ),
              ),
              RoundedInputForm(
                icon: Icons.description,
                value: description,
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                '???nh n??ng tr???i',
                style: TextStyle(

                ),
              ),
              Container(
                width: 150,
                height: 150,
                child: image!=null? Image.file(image!,width: 150,height: 150,fit: BoxFit.cover): Image.network(widget.image.src,width: 150,height: 150,fit: BoxFit.cover),
                decoration: BoxDecoration(
                    border: Border.all(width: 1)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera_alt_outlined)
                  ),
                  IconButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image_outlined)
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Ho??n t???t",
                press: () async {
                  try {
                    Map data = {
                      "farm_type_id": "${_ChoosefarmType.id}",
                      "farmer_id": "${farm.farmer.id}",
                      "area_id": "${_Choosearea.ID}",
                      "name": "$name",
                      "address": "$address",
                      "description": "$description",
                      "status": farm.status
                    };
                    var body = json.encode(data);
                    final http.Response response = await http.put(
                        Uri.parse('http://52.221.245.187:90/api/v1/farms/${farm.ID}'),
                        headers: {"Content-Type": "application/json-patch+json"},
                        body: body
                    );
                    if (response.statusCode==200) {
                      if(image!=null){
                        bool updateImage = await httpService.updateFarmImage(image!, farm.ID, widget.image.id);
                        if(updateImage){
                          await showDialog(
                              context: context,
                              builder: (BuildContext context)=>Message_Dialog(
                                title: 'C???p nh???t n??ng tr???i',
                                content: 'C???p nh???t n??ng tr???i th??nh c??ng',
                              )
                          );
                          Navigator.pop(context);
                        }
                      }
                      await showDialog(
                          context: context,
                          builder: (BuildContext context)=>Message_Dialog(
                            title: 'C???p nh???t n??ng tr???i',
                            content: 'C???p nh???t n??ng tr???i th??nh c??ng',
                        )
                      );
                      Navigator.pop(context);
                    }
                  } on Exception catch (e) {
                    Message_Dialog(title: 'L???i',content: 'L???i c???p nh???t n??ng tr???i:${e.toString()}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
