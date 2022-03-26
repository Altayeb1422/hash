import 'package:flutter/material.dart';
import 'package:hash/model/real_estate_class.dart';
import 'dart:math' as math;


class Realestate extends StatelessWidget {
  const Realestate({Key? key, required this.onTap, required this.property}) : super(key: key);
  final VoidCallback onTap;
  final Property property;
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context).index == 0;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: const Color(0xfff2f2f2),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Hero(
              tag: property.img,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    property.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    borderRadius:BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black26.withOpacity(0.1),
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius:BorderRadius.circular(8) ,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                          child: Text(property.type, style:  const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text(property.offer, style:  const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
