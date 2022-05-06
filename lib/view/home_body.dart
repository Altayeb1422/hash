import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hash/main.dart';
import 'package:hash/services/remote_services.dart';
import 'package:hash/view/motor_detailes.dart';
import 'package:hash/view/property%20for%20rent/property_for_rent_types.dart';
import 'package:hash/view/property%20for%20sale/property_for_sale_types.dart';
import 'package:hash/view/real_estate_card.dart';
import 'package:hash/view/real_estate_detailes.dart';
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
      backgroundColor: Colors.amber,
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
                if(context.locale.toString() == 'ar'){
                  await EasyLocalization.of(context)!.setLocale(Locale('en'));
                  print(Intl.getCurrentLocale());
                  Phoenix.rebirth(context);
                  //setState(()  {});
                  //Restart.restartApp();
                  print(Intl.getCurrentLocale());
                  print(context.locale);
                  //ZoomDrawer.of(context)!.toggle();
                }else if(context.locale.toString() == 'en'){
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
                      title: context.locale.toString() == 'ar'? tabs![index].arabicLabel: tabs![index].englishLabel,
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
              propertyDisplay(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Text(
                  "property".tr(),
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              carsDisplay()
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
