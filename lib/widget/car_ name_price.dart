import 'package:flutter/material.dart';
import 'dart:math' as math;

class VehicleNamePrice extends StatelessWidget {
  const VehicleNamePrice({
    Key? key, required this.title,required this.price,
  }) : super(key: key);
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context).index == 0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
        BoxDecoration(color: const Color.fromRGBO(64, 75, 96, .9),borderRadius: BorderRadius.circular(30)),
        child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0),
            title:  Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),

            trailing: Text(price, style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}