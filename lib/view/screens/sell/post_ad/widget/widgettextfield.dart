import 'package:flutter/material.dart';

class addtextfield extends StatefulWidget {
  const addtextfield(String s, TextEditingController unitname, {Key? key})
      : super(key: key);

  @override
  State<addtextfield> createState() => _addtextfieldState();
}

class _addtextfieldState extends State<addtextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: (nmbr) =>
      //     nmbr != null && validate(nmbr) ? 'Enter a valid email' : null,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
