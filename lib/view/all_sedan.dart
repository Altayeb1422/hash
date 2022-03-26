import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hash/view/apartments_card.dart';
import 'package:hash/view/sedan_card.dart';
import '../model/car_class.dart';
import '../model/sedan_class.dart';
import 'apartments_class.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'cars_details.dart';

DateTime logout = DateTime.now();

class AllSedan extends StatefulWidget {
  const AllSedan({Key? key}) : super(key: key);

  @override
  _AllSedanState createState() => _AllSedanState();
}

class _AllSedanState extends State<AllSedan> {

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
        title: const Center(child: Text('Apartments', style: TextStyle(color: Colors.black),)),
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
        child: MasonryGridView.count(
          itemCount: sedan.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              SedanCard(sedan: sedan[index], onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>CarsInfo(cars: cars[index])));},),
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}

