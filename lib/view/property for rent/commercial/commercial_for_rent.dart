import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';
import '../../filter_page_for_the_rest.dart';

class CommercialForRent extends StatefulWidget {
  const CommercialForRent({Key? key}) : super(key: key);

  @override
  _CommercialForRentState createState() => _CommercialForRentState();
}

class _CommercialForRentState extends State<CommercialForRent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  "com rent".tr(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "office rent".tr(),),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "Retail rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "indus rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "shop rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "ware rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "comm floor rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "comm bulid rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "comm villa rent".tr(),),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "factory rent".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  FilterPageTheRest()));}, title: "showroom rent".tr(),),
            ],
          ),
        ),
      ),
    );
  }
}

