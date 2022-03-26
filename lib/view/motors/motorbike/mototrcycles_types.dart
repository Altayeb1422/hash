import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';
import 'package:easy_localization/easy_localization.dart';

class MotorcycleTypes extends StatefulWidget {
  const MotorcycleTypes({Key? key}) : super(key: key);


  @override
  _MotorcycleTypesState createState() => _MotorcycleTypesState();
}

class _MotorcycleTypesState extends State<MotorcycleTypes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:  Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              child: Text(
                "motorcycles".tr(),
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            CardWidgetNoSub(title: "sport bike".tr(), onTap: (){}),
            CardWidgetNoSub(title: "motorcycle".tr(), onTap: (){}),
            CardWidgetNoSub(title: "scooter".tr(), onTap: (){}),
          ],
        ),
      ),
    );
  }
}
