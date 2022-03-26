import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hash/model/car_class.dart';
import 'package:hash/model/cars_card.dart';
import 'package:hash/model/real_estate_class.dart';
import 'package:hash/view/all_sedan.dart';
import 'package:hash/view/real_estate_card.dart';
import 'package:hash/view/real_estate_detailes.dart';
import 'package:hash/view/sedan_card.dart';
import '../model/sedan_class.dart';
import 'cars_details.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

DateTime logout = DateTime.now();

class AllAutomotive extends StatefulWidget {
  const AllAutomotive({Key? key}) : super(key: key);

  @override
  _AllAutomotiveState createState() => _AllAutomotiveState();
}

class _AllAutomotiveState extends State<AllAutomotive> {

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
        title: Center(child: Text('Automotive', style: TextStyle(color: Colors.black),)),
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
                    "Sedan",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                MaterialButton(
                  onPressed: () {Get.to(()=>AllSedan());},
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
              height: 10,
            ),
            MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  SedanCard(sedan: sedan[index], onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>CarsInfo(cars: cars[index])));},),
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
                    "Hatch back",
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

