import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';

import '../../filter_page_residential.dart';

class ResdientialForRent extends StatefulWidget {
  const ResdientialForRent({Key? key}) : super(key: key);


  @override
  _ResdientialForRentState createState() => _ResdientialForRentState();
}

class _ResdientialForRentState extends State<ResdientialForRent> {
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
                  "res rent".tr(),
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));},title: "apart rent".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));}, title: "villa/house rent".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));},  title: "Building rent".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));}, title: "floor rent".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));}, title: "villa  rent".tr(),),
          ],
        ),
      ),
    );
  }
}

