import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class CarsDetailsWidget extends StatelessWidget {
  const CarsDetailsWidget({
    Key? key, required this.title, required this.logo, required this.price, required this.currency,
  }) : super(key: key);
  final String title;
  final String logo;
  final String price;
  final String currency;
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context).index == 0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
      child: Container(
        decoration:
        BoxDecoration(color: const Color.fromRGBO(64, 75, 96, .9),borderRadius: BorderRadius.circular(30)),
        child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl ? math.pi : 0),
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.only(right: 12.0),
                decoration:   const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1.0, color: Colors.white24))),
                child: SvgPicture.asset(
                  logo,
                ),
              ),
            ),
            title:  Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
            ),

            trailing: Text(
              "${price} ${currency}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            )),

      ),
    );
  }
}