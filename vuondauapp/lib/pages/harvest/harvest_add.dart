import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:http/http.dart' as http;

class AddHarvest extends StatefulWidget {
  final List<ProductDTO>  listproduct;
  final List<FarmDTO> listfarm;
  AddHarvest({required this.listproduct,required  this.listfarm});

  @override
  _AddHarvestState createState() => _AddHarvestState();
}

class _AddHarvestState extends State<AddHarvest> {
  File? image;
  final HttpService httpService = HttpService();
  final picker = ImagePicker();
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
  String  description = '';
  String  name='';
  late ProductDTO _Chooseproduct;
  late FarmDTO _Choosefarm;

  @override
  void initState() {
    super.initState();
    _Chooseproduct  = widget.listproduct.first;
    _Choosefarm = widget.listfarm.first;
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
        title: Text('Tạo mùa vụ'),
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
              RoundedInputField(
                hintText: "Tên mùa vụ",
                icon: Icons.drive_file_rename_outline,
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Mô tả",
                icon: Icons.info_rounded,
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: size.width*0.8,
                  child: Text(
                      'Ngày bắt đầu mùa vụ',
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
              SizedBox(height: size.height * 0.03),
              Text(
                'Ảnh mùa vụ',
                style: TextStyle(

                ),
              ),
              Container(
                width: 150,
                height: 150,
                child: image!=null? Image.file(image!,width: 150,height: 150,fit: BoxFit.cover): Center(child:Text('no image selected')),
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
                text: "Hoàn tất",
                press: () async {
                  bool confirm = false;
                  confirm = await await showDialog(
                  context: context,
                  builder: (BuildContext context)=>Confirm_Dialog(
                  title: 'Xác nhận',
                  content: 'Bạn muốn tạo mùa vụ?',
                  )
                  );
                  if(confirm) {
                    Map data = {
                      "name": "$name",
                      "farm_id": "${_Choosefarm.ID}",
                      "product_id": "${_Chooseproduct.id}",
                      "description": "$description",
                      "start_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(datestart),
                      "end_date": DateFormat('yyyy-MM-ddThh:mm:ss').format(dateend)
                    };
                    var body = json.encode(data);
                    final http.Response response = await http.post(
                        Uri.parse('http://52.221.245.187:90/api/v1/harvests'),
                        headers: {"Content-Type": "application/json"},
                        body: body
                    );
                    if (response.statusCode == 201) {
                      final String harvestID  = jsonDecode(response.body)['id'];
                      bool uploadImage = await httpService.postHarvestImage(image!, harvestID);
                      if (uploadImage) {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                Message_Dialog(
                                  title: 'Tạo mùa vụ',
                                  content: 'Tạo mùa vụ thành công',
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
