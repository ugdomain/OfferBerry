import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/excel_file/excel_page_controller.dart';

import '../../../../controllers/sub_category_attr_controller.dart';


class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({Key? key, this.index, required this.radiokey}) : super(key: key);

  final int? index;

  final ValueKey radiokey;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {

  final SubCategoryAttrController _attrController = Get.find();

  final ExcelController _excelController = Get.find();

  int value = 0;

  int itemIndex = -1;

  // Map<String, dynamic> radioButtonMap = {};

  Map<String, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    return Builder(
          builder: (context) {
            itemIndex = -1;
            return Row(
            children: [
              ..._attrController.attrList.first.attrs![widget.index!].controlOptions!.map((e){
                itemIndex++;
                if(_attrController.radioButtonMap.isEmpty || _attrController.radioButtonMap.length < _attrController.attrList.first.attrs!.length){_attrController.radioButtonMap.addAll(Map.from(
                    {_attrController.attrList.first.attrs![widget.index!].controlName:
                    _attrController.attrList.first.attrs![widget.index!].controlOptions![0]}));}
                map.addAll(Map.from({e:itemIndex}));
                return
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                        onPressed: (){
                          setState((){
                            itemIndex = 0;
                            var controlName = _attrController.attrList.first.attrs![widget.index!].controlName;
                            value = map[e];
                            var selectedValue = map.keys.firstWhere((element) => map[element] == value);
                            if(_attrController.radioButtonMap.containsKey(controlName))
                              {
                                _attrController.radioButtonMap[controlName] = selectedValue;
                              }else{
                              _attrController.radioButtonMap.addAll(Map.from({controlName: selectedValue}));
                            }
                          });
                    },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all((value == itemIndex) ? Colors.blue : Colors.grey),
                        ),
                        child: Text(e,style: TextStyle(color: Colors.white,))
    ),
                  );}).toList()
            ],
      );
          }
        );
  }
}
