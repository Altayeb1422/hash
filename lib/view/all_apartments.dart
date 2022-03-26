import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hash/view/apartments_card.dart';
import 'apartments_class.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

DateTime logout = DateTime.now();

class AllApartment extends StatefulWidget {
  const AllApartment({Key? key}) : super(key: key);

  @override
  _AllApartmentState createState() => _AllApartmentState();
}

class _AllApartmentState extends State<AllApartment> {

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
          itemCount: apartment.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              ApartmentsCard(apartment: apartment[index], onTap: () {},),
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}

