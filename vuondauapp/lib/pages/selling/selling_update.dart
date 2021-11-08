import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/pages/selling/selling.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateSelling extends StatefulWidget {
  final HarvestSellingPriceDTO selling;

  UpdateSelling({required this.selling});
  @override
  _UpdateSellingState createState() => _UpdateSellingState();
}

class _UpdateSellingState extends State<UpdateSelling> {
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
  double weight=0;
  double  price=0;

  @override
  void initState() {
    super.initState();
    datestart=widget.selling.harvestSelling.dateOfCreate;
    dateend=widget.selling.harvestSelling.endDate;
    weight=widget.selling.harvestSelling.totalWeight;
    price=widget.selling.price;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cập nhật đợt bán'),
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
                        value == null ? DateTime.now() : datestart = value;
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
                hintText: "Sản lượng (Kg)",
                icon: Icons.add_shopping_cart,
                onChanged: (value) {
                  try{
                    weight = double.parse(value);
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
                  Map dataHarvestSelling = {
                    "harvest_id": widget.selling.harvestSelling.harvest.ID,
                    "campaign_id": "",
                    "start_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(datestart),
                    "end_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(dateend),
                    "min_weight": 0,
                    "total_weight": 0,
                    "status": 1
                  };
                  var bodyHarvestSelling = json.encode(dataHarvestSelling);
                  final http.Response response = await http.put(
                      Uri.parse('http://52.221.245.187:90/api/v1/harvest-sellings/${widget.selling.harvestSelling.id}'),
                      headers: {"Content-Type": "application/json-patch+json"},
                      body: bodyHarvestSelling
                  );
                  if(response.statusCode==200){
                    Map data = {
                      "price": price,
                      "harvest_selling_id": widget.selling.harvestSelling.id,
                      "status": 1
                    };
                    var body = json.encode(data);
                    final http.Response response2 = await http.put(
                        Uri.parse('http://52.221.245.187:90/api/v1/harvest-selling-prices/${widget.selling.id}'),
                        headers: {"Content-Type": "application/json-patch+json"},
                        body: body
                    );
                    if(response2.statusCode==200){
                      await showDialog(
                          context: context,
                          builder: (BuildContext context)=>Message_Dialog(
                            title: 'Cập nhật đợt bán',
                            content: 'Cập nhật đợt bán thành công',
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
