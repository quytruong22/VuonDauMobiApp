import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
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
  UpdateHarvest({required this.listproduct,required  this.listfarm,required this.harvest});

  @override
  _UpdateHarvestState createState() => _UpdateHarvestState();
}

class _UpdateHarvestState extends State<UpdateHarvest> {
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cập nhật mùa vụ'),
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
                'Điền thông tin mùa vụ',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Chọn vườn/nông trại',
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
                    'Ngày thu hoạch dự kiến',
                    style: TextStyle(

                    ),
                    textAlign: TextAlign.left,
                  )
              ),
              RoundedDateInput(
                  text: 'Ngày '+datestart.day.toString()+' tháng '+datestart.month.toString()+' năm '+datestart.year.toString(),
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
                    'Ngày kết thúc mùa vụ',
                    style: TextStyle(

                    ),
                    textAlign: TextAlign.left,
                  )
              ),
              RoundedDateInput(
                  text: 'Ngày '+dateend.day.toString()+' tháng '+dateend.month.toString()+' năm '+dateend.year.toString(),
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
                'Sản phẩm',
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
              RoundedInputField(
                hintText: "Link ảnh mùa vụ",
                icon: Icons.picture_in_picture,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Hoàn tất",
                press: () async {
                  bool confirm = false;
                  confirm = await await showDialog(
                  context: context,
                  builder: (BuildContext context)=>Confirm_Dialog(
                  title: 'Xác nhận',
                  content: 'Bạn muốn cập nhật mùa vụ?',
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
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              Message_Dialog(
                                title: 'Cập nhật mùa vụ',
                                content: 'Cập nhật mùa vụ thành công',
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
