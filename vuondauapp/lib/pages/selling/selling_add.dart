import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';
import 'package:vuondauapp/widgets/compoment/rounded_date_input.dart';
import 'package:image_picker/image_picker.dart';

class AddSelling extends StatefulWidget {

  @override
  _AddSellingState createState() => _AddSellingState();
}

class _AddSellingState extends State<AddSelling> {
  String dropdownValue = 'Vụ Dâu Đà Lạt Mùa Đông';
  DateTime datestart = DateTime.now();
  DateTime dateend = DateTime.now();
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
                    items: <String>['Vụ Dâu Đà Lạt Mùa Đông', 'Vụ Cà chua Đà Lạt Mùa Đông', 'Vụ rau Cải Thảo Đà Lạt Mùa Đông']
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
                hintText: "Tên đợt bán",
                icon: Icons.drive_file_rename_outline,
                onChanged: (value) {},
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
              RoundedInputField(
                hintText: "Sản lượng (Kg)",
                icon: Icons.add_shopping_cart,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Giá (VND)",
                icon: Icons.monetization_on,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Hoàn tất",
                press: () {
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
