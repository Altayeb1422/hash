import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hash/main.dart';
import 'package:hash/services/remote_services.dart';
import 'package:hash/view/motor_detailes.dart';
import 'package:hash/view/property%20for%20rent/property_for_rent_types.dart';
import 'package:hash/view/property%20for%20sale/property_for_sale_types.dart';
import 'package:hash/view/real_estate_card.dart';
import 'package:hash/view/real_estate_detailes.dart';
import 'package:hash/view/single_car_page.dart';
import 'package:hash/view/single_property_page.dart';
import 'package:hash/widget/dubzill_card_design.dart';
import '../model/car_class.dart';
import '../model/cars_card.dart';
import '../model/real_estate_class.dart';
import 'package:easy_localization/easy_localization.dart';
import '../model/root.dart';
import 'motors/motors.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Tabs>? tabs;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    tabs = await RemoteService().getTabs();
    if (tabs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          "home".tr(),
          style: const TextStyle(color: Colors.black),
        )),
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
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () async {
                if (context.locale.toString() == 'ar') {
                  await EasyLocalization.of(context)!.setLocale(Locale('en'));
                  print(Intl.getCurrentLocale());
                  Phoenix.rebirth(context);
                  //setState(()  {});
                  //Restart.restartApp();
                  print(Intl.getCurrentLocale());
                  print(context.locale);
                  //ZoomDrawer.of(context)!.toggle();
                } else if (context.locale.toString() == 'en') {
                  await EasyLocalization.of(context)!.setLocale(Locale('ar'));
                  print(Intl.getCurrentLocale());
                  Phoenix.rebirth(context);
                }
              },
              icon: const Icon(Icons.g_translate_rounded)),
        ],
      ),
      body: SafeArea(
        child: Visibility(
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          visible: isLoaded,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: tabs?.length,
                  itemBuilder: (context, index) {
                    return DubzillCardWidget(
                      title: context.locale.toString() == 'ar'
                          ? tabs![index].arabicLabel
                          : tabs![index].englishLabel,
                      icon: tabs![index].icon,
                      onTap: () async {
                        print(Intl.getCurrentLocale());
                        if (tabs![index].id == '1') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PropertyForRentTypes(
                                        parentId: tabs![index].id,
                                      )));
                        } else if (tabs![index].id == '2') {
                          filterId.add(tabs![index].id);
                          filterName.add(tabs![index].name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PropertyForSaleTypes(
                                        parentId: tabs![index].id,
                                      )));
                        } else if (tabs![index].id == '3') {
                          filterId.add(tabs![index].id);
                          filterName.add(tabs![index].name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MotorsSale()));
                        }
                      },
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "property".tr(),
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .38,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PropertyCard(
                          img: 'assets/apart 4.jpg',
                          location: 'Bahri-Enqaz',
                          title: 'Studio apartment',
                          price: '10,000 SDG/Day',
                        ),
                        //SizedBox(width: 10,),
                        PropertyCard(
                          img: 'assets/apart 3.jpg',
                          location: 'khartoum-Gabra',
                          title: 'Furnished apartment',
                          price: '17,000 SDG/Day',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //propertyDisplay(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Text(
                  "motor".tr(),
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .38,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CarsCard(
                          location: 'Bahri-Crane',
                          title: 'Lancer',
                          price: '',
                          img: 'assets/sedan 1.jpg',
                          logo: 'assets/cars/mitsubishi.svg',
                        ),
                        CarsCard(
                          location: 'Omdurman-Muwrada',
                          title: 'Camery',
                          price: '',
                          img: 'assets/sedan 3.jpg',
                          logo: 'assets/cars/toyota.svg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //carsDisplay()
            ],
          ),
        ),
      ),
    );
  }

  Container carsDisplay() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) => AutomotiveCard(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MotorDetailes(cars: cars[index])));
          },
          cars: cars[index],
        ),
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 15,
      ),
    );
  }

  Container propertyDisplay() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: MasonryGridView.count(
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
    );
  }

  Container mainTabs() {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: tabs?.length,
        itemBuilder: (context, index) {
          return DubzillCardWidget(
            title: tabs![index].name,
            icon: tabs![index].icon,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          PropertyForSaleTypes(parentId: tabs![index].id)));
            },
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .9,
          mainAxisSpacing: 5,
          crossAxisSpacing: 8,
          crossAxisCount: 3,
        ),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key? key,
    required this.img,
    required this.title,
    required this.location,
    required this.price,
  }) : super(key: key);
  final String img;
  final String title;
  final String location;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePropertyDetailPage()));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .33,
          width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 10.0, color: Colors.grey.withOpacity(0.5))
              ],
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 12.0, color: Colors.grey.withOpacity(0.5))
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        img,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 15,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bathtub,
                          size: 17,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "1",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.hotel,
                          size: 17,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.zoom_out_map,
                          size: 17,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "120 m",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarsCard extends StatelessWidget {
  const CarsCard({
    Key? key,
    required this.img,
    required this.title,
    required this.location,
    required this.price,
    required this.logo,
  }) : super(key: key);
  final String img;
  final String title;
  final String location;
  final String price;
  final String logo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleCarDetailsPage()));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .35,
          width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 10.0, color: Colors.grey.withOpacity(0.5))
              ],
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 12.0, color: Colors.grey.withOpacity(0.5))
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        img,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.only(right: 12.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(width: 1.0, color: Colors.white24))),
                      child: SvgPicture.asset(
                        logo,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 15,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_gas_station,
                          size: 17,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Gasoline",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.speed,
                          size: 17,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "170,000 Km",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          size: 17,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Auto",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

