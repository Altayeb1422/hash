import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';
import '../../filter_page_residential.dart';

class ResdientialForSale extends StatefulWidget {
  const ResdientialForSale({Key? key}) : super(key: key);


  @override
  _ResdientialForSaleState createState() => _ResdientialForSaleState();
}

class _ResdientialForSaleState extends State<ResdientialForSale> {
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
                  "res sale".tr(),
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));},title: "apart sale".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));}, title: "villa/house sale".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));},  title: "Building sale".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));}, title: "floor sale".tr(), ),
            CardWidgetNoSub(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterPageResidential()));}, title: "villa complex".tr(),),
          ],
        ),
      ),
    );
  }
}

