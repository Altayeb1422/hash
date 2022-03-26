import 'package:flutter/material.dart';

import 'apartments_class.dart';



class ApartmentsCard extends StatelessWidget {
  const ApartmentsCard({Key? key, required this.onTap, required this.apartment}) : super(key: key);
  final VoidCallback onTap;
  final Apartments apartment;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Color(0xfff2f2f2),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Hero(
              tag: apartment.img,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    apartment.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    borderRadius:BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black26.withOpacity(0.1),
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius:BorderRadius.circular(8) ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(apartment.listing, style:  TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(apartment.type, style:  TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),),
                      Text(apartment.offer, style:  TextStyle(color: Colors.deepOrange, fontSize: 15, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
