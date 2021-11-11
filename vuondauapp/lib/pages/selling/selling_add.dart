import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddSelling extends StatefulWidget {
  final List<HarvestDTO>  harvests;

  AddSelling({required this.harvests});

  @override
  _AddSellingState createState() => _AddSellingState();
}

class _AddSellingState extends State<AddSelling> {
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
  String  name='';
  double price=0;
  double minWeight=0;
  double  weight=0;
  late  HarvestDTO  _Chooseharvest;
  @override
  void initState() {
    super.initState();
    _Chooseharvest = widget.harvests.first;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Tạo đợt bán'),
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
                'Điền thông tin đợt bán',
                style: TextStyle(

                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Chọn mùa vụ:',
                style: TextStyle(

                ),
              ),
              TextFieldContainer(
                child: DropdownButton(
                  value: _Chooseharvest,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (HarvestDTO? newValue) {
                    setState(() {
                      _Chooseharvest = newValue!;
                    });
                  },
                  items: widget.harvests
                      .map((HarvestDTO value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: size.width*0.8,
                  child: Text(
                      'Ngày mở bán',
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
                      firstDate: DateTime(2021),
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
                   'Ngày kết thúc',
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
                       initialDate: dateend,
                       firstDate: datestart,
                       lastDate: DateTime(2023)
                   ).then((value) {
                     setState(() {
                       value == null ? dateend = datestart : dateend = value;
                     });
                   });
                 }
             ),
              SizedBox(height: size.height * 0.03),
              RoundedNumberInputField(
                hintText: "Sản lượng tối thiểu(Kg)",
                icon: Icons.add_shopping_cart,
                onChanged: (value) {
                  try{
                    weight  = double.parse(value);
                  }catch(e){

                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedNumberInputField(
                hintText: "Sản lượng tối đa(Kg)",
                icon: Icons.add_shopping_cart,
                onChanged: (value) {
                  try{
                    minWeight  = double.parse(value);
                  }catch(e){

                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedNumberInputField(
                hintText: "Giá (VND)",
                icon: Icons.monetization_on,
                onChanged: (value) {
                  try{
                    price = double.parse(value);
                  }catch(e){
                  }
                },
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
                        content: 'Bạn muốn tạo đợt bán?',
                      )
                  );
                  if(confirm){
                    Map dataHarvestSelling= {
                      "harvest_id": _Chooseharvest.ID,
                      "campaign_id": "",
                      "date_of_create": DateFormat('yyyy-MM-ddThh:mm:ss').format(datestart),
                      "end_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(dateend),
                      "min_weight": minWeight,
                      "total_weight": weight
                    };
                    var bodyHarvestSelling = json.encode(dataHarvestSelling);
                    final http.Response response = await http.post(
                        Uri.parse('http://52.221.245.187:90/api/v1/harvest-sellings'),
                        headers: {"Content-Type": "application/json"},
                        body: bodyHarvestSelling
                    );
                    if(response.statusCode==201){
                      Map dataHarvestSellingPrice= {
                        "price": price,
                        "harvest_selling_id": jsonDecode(response.body)['id']
                      };
                      var body = json.encode(dataHarvestSellingPrice);
                      final http.Response response2 = await http.post(
                          Uri.parse('http://52.221.245.187:90/api/v1/harvest-selling-prices'),
                          headers: {"Content-Type": "application/json"},
                          body: body
                      );
                      if(response2.statusCode==201){
                        await showDialog(
                            context: context,
                            builder: (BuildContext context)=>Message_Dialog(
                              title: 'Tạo đợt bán',
                              content: 'Tạo đợt bán thành công',
                            )
                        );
                        Navigator.pop(context);
                      }
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
