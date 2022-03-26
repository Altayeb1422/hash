import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hash/view/real_estate_card.dart';
import 'package:hash/view/real_estate_detailes.dart';

import '../model/car_class.dart';
import '../model/cars_card.dart';
import '../model/real_estate_class.dart';
import 'cars_details.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 25.0, vertical: 15),
              child: Text(
                "Favorite",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              child: MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    Realestate(property: property[index], onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>PropertyInfo(property: property[index])));},),
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
              ),
            ),
            SizedBox(
              child: MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: ( context,  index) =>
                    AutomotiveCard(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>CarsInfo(cars: cars[index])));}, cars: cars[index],),
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
