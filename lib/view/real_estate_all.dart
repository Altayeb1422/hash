import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hash/model/car_class.dart';
import 'package:hash/model/cars_card.dart';
import 'package:hash/model/real_estate_class.dart';
import 'package:hash/view/real_estate_card.dart';
import 'package:hash/view/real_estate_detailes.dart';
import 'all_apartments.dart';
import 'apartments_card.dart';
import 'apartments_class.dart';
import 'cars_details.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

DateTime logout = DateTime.now();

class AllProperty extends StatefulWidget {
  const AllProperty({Key? key}) : super(key: key);

  @override
  _AllPropertyState createState() => _AllPropertyState();
}

class _AllPropertyState extends State<AllProperty> {

  getUser() {
    FirebaseAuth.instance.currentUser;
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Real estate', style: TextStyle(color: Colors.black),)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed:(){
              Get.back();
            }
        ),

      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: Text(
                    "Apartments",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                MaterialButton(
                  onPressed: () {Get.to(()=> AllApartment());},
                  child: const Text(
                    "View all",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            const SizedBox(
              height: 15,
            ),
            MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  ApartmentsCard(apartment: apartment[index], onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>PropertyInfo(property: property[index])));},),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
            ),

            const SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, right: 25.0, bottom: 15, top: 5),
                  child: Text(
                    "Offices",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    "View all",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: ( context,  index) =>
                  AutomotiveCard(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>CarsInfo(cars: cars[index])));}, cars: cars[index],),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
            ),
          ],
        ),
      ),
    );
  }
}

