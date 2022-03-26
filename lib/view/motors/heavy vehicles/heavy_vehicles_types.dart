import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';


class HeavyVehicleTypes extends StatefulWidget {
  const HeavyVehicleTypes({Key? key}) : super(key: key);


  @override
  _HeavyVehicleTypesState createState() => _HeavyVehicleTypesState();
}

class _HeavyVehicleTypesState extends State<HeavyVehicleTypes> {
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
                "heavy vehicle".tr(),
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            CardWidgetNoSub(title: "truck".tr(), onTap: (){}),
            CardWidgetNoSub(title: "Buses".tr(), onTap: (){}),
            CardWidgetNoSub(title: "trailer".tr(), onTap: (){}),
            CardWidgetNoSub(title: "tanker".tr(), onTap: (){}),
            CardWidgetNoSub(title: "cranes".tr(), onTap: (){}),
            CardWidgetNoSub(title: "Forklifts".tr(), onTap: (){}),
          ],
        ),
      ),
    );
  }
}
