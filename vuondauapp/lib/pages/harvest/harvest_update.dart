import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/dialog.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';

class UpdateHarvest extends StatefulWidget {
  const UpdateHarvest({Key? key}) : super(key: key);

  @override
  _UpdateHarvestState createState() => _UpdateHarvestState();
}

class _UpdateHarvestState extends State<UpdateHarvest> {
  String dropdownValue = 'Nông Trại Phan Nam';
  String dropdownProduct = 'Dâu';
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
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
              TextFieldContainer(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Nông Trại Phan Nam', 'Nông trại Whiteface', 'Trường Thành Farm']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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
                child: DropdownButton<String>(
                  value: dropdownProduct,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                      height: 0
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownProduct = newValue!;
                    });
                  },
                  items: <String>['Dâu', 'Cải xanh', 'Cà tím']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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
                  await showDialog(
                      context: context,
                      builder: (BuildContext context)=>Message_Dialog(
                    title: 'Cập nhật mùa vụ',
                    content: 'Cập nhật mùa vụ thành công',
                  )
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
