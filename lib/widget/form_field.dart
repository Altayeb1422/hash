import 'package:flutter/material.dart';

class FormFeild extends StatelessWidget {
  FormFeild(
      {Key? key,
        required this.keyboard,
        required this.controller,
        required this.value,
        required this.valdiator,
        required this.hint,
        required this.icon})
      : super(key: key);
  dynamic value;
  dynamic controller;
  String hint;
  Icon icon;
  dynamic valdiator;
  TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onSaved: (val) {
          value = val;
        },
        keyboardType: keyboard,
        controller: controller,
        validator: (val) {
          valdiator;
        },
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.transparent,
          filled: true,
          prefixIcon: icon,
          hintStyle: const TextStyle(
              color: Colors.grey, fontFamily: 'Cairo', fontSize: 15),
        ));
  }
}
