import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../widget/filters_card_widget.dart';
import 'cars/cars_types.dart';
import 'heavy vehicles/heavy_vehicles_types.dart';
import 'motorbike/mototrcycles_types.dart';

class MotorsSale extends StatefulWidget {
  const MotorsSale({Key? key}) : super(key: key);

  @override
  _MotorsSaleState createState() => _MotorsSaleState();
}

class _MotorsSaleState extends State<MotorsSale> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Text(
                  "motor".tr(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const CarsTypes()));}, icon: Icons.directions_car_sharp, title: "cars".tr(), subtitle: "BYD".tr(),),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const MotorcycleTypes()));}, icon: Icons.motorcycle_rounded, title: "motorcycles".tr(), subtitle: "scooter".tr(),),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const HeavyVehicleTypes()));}, icon: Icons.local_shipping, title: "heavy vehicle".tr(), subtitle: "Buses".tr(),),
            ],
          ),
        ),
      ));
  }
}
