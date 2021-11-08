import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:image_picker/image_picker.dart';

class AddHarvest extends StatefulWidget {
  final List<ProductDTO>  listproduct;
  final List<FarmDTO> listfarm;
  AddHarvest({required this.listproduct,required  this.listfarm});

  @override
  _AddHarvestState createState() => _AddHarvestState();
}

class _AddHarvestState extends State<AddHarvest> {
  String dropdownValue = 'Nông Trại Phan Nam';
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
  late ProductDTO _Chooseproduct;
  late  FarmDTO _Choosefarm;

  @override
  void initState() {
    super.initState();
    _Chooseproduct  = widget.listproduct.first;
    _Choosefarm = widget.listfarm.first;
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
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Mô tả",
                icon: Icons.info_rounded,
                onChanged: (value) {},
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
                      value == null ? DateTime.now() : datestart = value;
                      if(datestart.isAfter(dateend)){
                        dateend = datestart;
                      }
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
                  bool confirm = await showDialog(context: context, builder: (BuildContext context) {
                    return Confirm_Dialog(
                      title: 'Tạo mùa vụ',
                      content: 'Bạn muốn tạo mùa vụ mới?',
                    );
                  });
                  if(confirm){
                    await showDialog(
                        context: context,
                        builder: (BuildContext context)=>Message_Dialog(
                          title: 'Tạo mùa vụ',
                          content: 'Tạo mùa vụ thành công',
                        )
                    );
                    Navigator.pop(context);
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
