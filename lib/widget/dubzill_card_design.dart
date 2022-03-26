import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class DubzillCardWidget extends StatelessWidget {
  const DubzillCardWidget({
    Key? key, required this.title, required this.icon, required this.onTap,
  }) : super(key: key);
  final String title;
  final String icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context).index == 0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Wrap(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: MediaQuery.of(context).size.height*.156,
              width: MediaQuery.of(context).size.width*.289,
              decoration:
              BoxDecoration(color: const Color.fromRGBO(64, 75, 96, .9),borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                      child: SvgPicture.string(icon, color: Colors.deepOrangeAccent.shade100, height: 40, width: 40, ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}