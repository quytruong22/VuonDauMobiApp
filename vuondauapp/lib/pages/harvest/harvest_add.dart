import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/text_field_container.dart';

class AddHarvest extends StatefulWidget {
  const AddHarvest({Key? key}) : super(key: key);

  @override
  _AddHarvestState createState() => _AddHarvestState();
}

class _AddHarvestState extends State<AddHarvest> {
  String dropdownValue = 'Nông Trại Phan Nam';
  String dropdownProduct = 'Dâu';
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
                hintText: "Mô tả mùa vụ",
                icon: Icons.info_rounded,
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Điền thông tin sản phẩm',
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
              RoundedInputField(
                hintText: "Link ảnh mùa vụ",
                icon: Icons.picture_in_picture,
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
