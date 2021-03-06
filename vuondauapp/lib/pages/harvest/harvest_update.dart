import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestPicture.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_form_field.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:http/http.dart' as http;

class UpdateHarvest extends StatefulWidget {
  final List<ProductDTO>  listproduct;
  final List<FarmDTO> listfarm;
  final HarvestDTO  harvest;
  final HarvestPicture image;
  UpdateHarvest({required this.listproduct,required  this.listfarm,required this.harvest,required this.image});

  @override
  _UpdateHarvestState createState() => _UpdateHarvestState();
}

class _UpdateHarvestState extends State<UpdateHarvest> {
  File? image;
  final HttpService httpService = HttpService();
  final picker = ImagePicker();
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
  String  description = '';
  String  name='';
  late ProductDTO _Chooseproduct;
  late FarmDTO _Choosefarm;
  late HarvestDTO harvest;

  @override
  void initState() {
    super.initState();
    harvest = widget.harvest;
    datestart = harvest.start_date;
    dateend = harvest.end_date;
    description = harvest.description;
    name=harvest.name;
    widget.listproduct.forEach((element) {
      if(element.id==harvest.product.id){
        _Chooseproduct  = element;
      }
    });
    widget.listfarm.forEach((element) {
      if(element.ID==harvest.farm.ID){
        _Choosefarm  = element;
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
        title: Text('C???p nh???t m??a v???'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '??i???n th??ng tin m??a v???',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Ch???n v?????n/n??ng tr???i',
                style: TextStyle(

                ),
              ),
              TextFieldContainer(
                child: DropdownButton(
                  value: _Choosefarm,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (FarmDTO? newValue) {
                    setState(() {
                      _Choosefarm = newValue!;
                    });
                  },
                  items: widget.listfarm
                      .map((FarmDTO value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputForm(
                value: name,
                icon: Icons.drive_file_rename_outline,
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputForm(
                value: description,
                icon: Icons.info_rounded,
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                  width: size.width*0.8,
                  child: Text(
                    'Ng??y b???t ?????u m??a v???',
                    style: TextStyle(

                    ),
                    textAlign: TextAlign.left,
                  )
              ),
              RoundedDateInput(
                  text: 'Ng??y '+datestart.day.toString()+' th??ng '+datestart.month.toString()+' n??m '+datestart.year.toString(),
                  icon: Icons.date_range,
                  onPress: (){
                    showDatePicker(
                        context: context,
                        initialDate: datestart,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2023)
                    ).then((value) {
                      setState(() {
                        value == null ? datestart =datestart : datestart = value;
                        if(datestart.isAfter(dateend)){
                          dateend = datestart;
                        }
                      });
                    });
                  }
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                  width: size.width*0.8,
                  child: Text(
                    'Ng??y k???t th??c m??a v???',
                    style: TextStyle(

                    ),
                    textAlign: TextAlign.left,
                  )
              ),
              RoundedDateInput(
                  text: 'Ng??y '+dateend.day.toString()+' th??ng '+dateend.month.toString()+' n??m '+dateend.year.toString(),
                  icon: Icons.date_range,
                  onPress: (){
                    showDatePicker(
                        context: context,
                        initialDate: datestart,
                        firstDate: datestart,
                        lastDate: DateTime(2023)
                    ).then((value) {
                      setState(() {
                        value == null ? datestart : dateend= value;
                      });
                    });
                  }
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'S???n ph???m',
                style: TextStyle(
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: DropdownButton(
                  value: _Chooseproduct,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (ProductDTO? newValue) {
                    setState(() {
                      _Chooseproduct = newValue!;
                    });
                  },
                  items: widget.listproduct
                      .map((ProductDTO value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                '???nh m??a v???',
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
                  bool confirm = false;
                  confirm = await await showDialog(
                  context: context,
                  builder: (BuildContext context)=>Confirm_Dialog(
                  title: 'X??c nh???n',
                  content: 'B???n mu???n c???p nh???t m??a v????',
                  )
                  );
                  if(confirm) {
                    Map data = {
                      "name": name,
                      "farm_id": _Choosefarm.ID,
                      "product_id": _Chooseproduct.id,
                      "description": description,
                      "start_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(datestart),
                      "end_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(dateend),
                      "status": 1
                    };
                    var body = json.encode(data);
                    final http.Response response = await http.put(
                        Uri.parse('http://52.221.245.187:90/api/v1/harvests/${harvest.ID}'),
                        headers: {"Content-Type": "application/json-patch+json"},
                        body: body
                    );
                    if (response.statusCode == 200) {
                      if(image!=null){
                        bool uploadImage = await httpService.updateHarvestImage(image!, harvest.ID, widget.image.id);
                        if(uploadImage){
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  Message_Dialog(
                                    title: 'C???p nh???t m??a v???',
                                    content: 'C???p nh???t m??a v??? th??nh c??ng',
                                  )
                          );
                          Navigator.pop(context);
                        }
                      }
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              Message_Dialog(
                                title: 'C???p nh???t m??a v???',
                                content: 'C???p nh???t m??a v??? th??nh c??ng',
                              )
                      );
                      Navigator.pop(context);
                    }
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
