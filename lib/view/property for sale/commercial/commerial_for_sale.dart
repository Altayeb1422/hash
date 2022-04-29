import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';
import '../../filter_page_for_the_rest.dart';

class CommercialForSale extends StatefulWidget {
  const CommercialForSale({Key? key}) : super(key: key);

  @override
  _CommercialForSaleState createState() => _CommercialForSaleState();
}

class _CommercialForSaleState extends State<CommercialForSale> {
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
                  "com sale".tr(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));},title: "office sale".tr(),),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "Retail sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));},  title: "indus sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "shop sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "ware sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "comm floor sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "comm bulid sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "comm villa sale".tr(),),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "factory sale".tr(), ),
              CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPageTheRest()));}, title: "showroom sale".tr(),),
            ],
          ),
        ),
      ),
    );
  }
}

