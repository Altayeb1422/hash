import 'dart:math' as math;
import 'package:flutter/material.dart';

class CardWidgetFilterPage extends StatelessWidget {
  const CardWidgetFilterPage({
    Key? key, required this.title, required this.onTap,required this.choice,
  }) : super(key: key);
  final String title;
  final String choice;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context).index == 0;
    return InkWell(
      onTap: onTap,
      child: Card(
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
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
              leading: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                child: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  decoration:  const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child:  const Icon(Icons.filter_list_sharp, color: Colors.deepOrangeAccent,),
                ),
              ),
              title:  Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),

              trailing: Wrap(

                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(choice, style: const TextStyle(color: Colors.white70, fontSize: 15,),textAlign: TextAlign.center,),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRtl ? math.pi : 0),
                    child: const Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}