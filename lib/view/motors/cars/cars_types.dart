import 'package:flutter/material.dart';
import '../CarCardWidget.dart';
import 'package:easy_localization/easy_localization.dart';

class CarsTypes extends StatefulWidget {
  const CarsTypes({Key? key}) : super(key: key);


  @override
  _CarsTypesState createState() => _CarsTypesState();
}

class _CarsTypesState extends State<CarsTypes> {
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
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              child: Text(
                "cars".tr(),
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            CarsCardWidget(title: "audi".tr(), onTap: () {  }, logo: "assets/cars/audi.svg"),
            CarsCardWidget(title: "baic".tr(), onTap: () {  }, logo: "assets/cars/acura.svg"),
            CarsCardWidget(title: "BYD".tr(), onTap: () {  }, logo: "assets/cars/BYD.svg"),
            CarsCardWidget(title: "BMW".tr(), onTap: () {  }, logo: "assets/cars/bmw.svg"),
            CarsCardWidget(title: "chev".tr(), onTap: () {  }, logo: "assets/cars/chevrolet.svg"),
            CarsCardWidget(title: "daewoo".tr(), onTap: () {}, logo: "assets/cars/daewoo.svg"),
            CarsCardWidget(title: "ford".tr(), onTap: () {  }, logo: "assets/cars/ford.svg"),
            CarsCardWidget(title: "geely".tr(), onTap: () {  }, logo: "assets/cars/acura.svg"),
            CarsCardWidget(title: "hond".tr(), onTap: () {  }, logo: "assets/cars/honda.svg"),
            CarsCardWidget(title: "hyundai".tr(), onTap: () {  }, logo: "assets/cars/hyundai.svg"),
            CarsCardWidget(title: "isuzu".tr(), onTap: () {  }, logo: "assets/cars/isuzu.svg"),
            CarsCardWidget(title: "kia".tr(), onTap: () {  }, logo: "assets/cars/kia.svg"),
            CarsCardWidget(title: "Lexus".tr(), onTap: () {  }, logo: "assets/cars/lexus.svg"),
            CarsCardWidget(title: "Mazda".tr(), onTap: () {  }, logo: "assets/cars/mazda.svg"),
            CarsCardWidget(title: "mercedes".tr(), onTap: () {  }, logo: "assets/cars/mercedes.svg"),
            CarsCardWidget(title: "mitsubishi".tr(), onTap: () {  }, logo: "assets/cars/mitsubishi.svg"),
            CarsCardWidget(title: "nissan".tr(), onTap: () {  }, logo: "assets/cars/nissan.svg"),
            CarsCardWidget(title: "suzuki".tr(), onTap: () {  }, logo: "assets/cars/suzuki.svg"),
            CarsCardWidget(title: "toyota".tr(), onTap: () {  }, logo: "assets/cars/toyota.svg"),
            CarsCardWidget(title: "volkswagen".tr(), onTap: () {  }, logo: "assets/cars/volkswagen.svg"),
          ],
        ),
      ),
    );
  }
}
