import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hash/view/filter_page_for_the_rest.dart';
import 'package:hash/view/real_estate_all.dart';
import 'package:hash/view/real_estate_card.dart';
import 'package:hash/view/real_estate_detailes.dart';
import 'package:hash/view/property%20for%20sale/residential/resdiential_for_sale.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../model/real_estate_class.dart';
import '../../widget/filters_card_widget.dart';
import 'commercial/commerial_for_sale.dart';

class PropertyForSale extends StatefulWidget {
  const PropertyForSale({Key? key}) : super(key: key);


  @override
  _PropertyForSaleState createState() => _PropertyForSaleState();
}

class _PropertyForSaleState extends State<PropertyForSale> {
  @override
  Widget build(BuildContext context) {
    return
       SingleChildScrollView(
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
                child: Row(
                  children:  [
                    Text(
                      "filters".tr(),
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.filter_alt_outlined,
                      size: 32,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const ResdientialForSale()));}, icon: Icons.home, title: "for sale".tr(), subtitle: 'apart'.tr(),),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const  CommercialForSale()));}, icon: Icons.factory_outlined, title: "com sale".tr(), subtitle: 'shop'.tr(),),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) =>   FilterPageTheRest()));}, icon: Icons.landscape_outlined, title: "land sale".tr(), subtitle: 'land'.tr(),),
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) =>   FilterPageTheRest()));}, icon: Icons.location_city_outlined , title: "multi sale".tr(), subtitle: 'comp'.tr(),),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                    child: Row(
                      children:  [
                        Text(
                          "All".tr(),
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.clear_all,
                          size: 32,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AllProperty()));
                    },
                    child:  Text(
                      "view all".tr(),
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Realestate(
                  property: property[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PropertyInfo(property: property[index])));
                  },
                ),
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


class PropertySale {
  final String title;
  dynamic  sub;

  PropertySale(this.title,  this.sub);
}

List<PropertySale> genres =
GenresData.map((item) => PropertySale(item['title'].toString(), item['sub'])).toList();

//an array
var GenresData = [
  {'title': 'Horror', 'totMovies': 17},
  {'title': 'Action', 'totMovies': 25},
  {'name': 'Neo', 'totMovies': 13},
  {'name': 'Romance', 'totMovies': 17},
];