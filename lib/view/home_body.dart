import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hash/main.dart';
import 'package:hash/services/remote_services.dart';
import 'package:hash/view/property%20for%20rent/property_for_rent_types.dart';
import 'package:hash/view/property%20for%20sale/property_for_sale_types.dart';
import 'package:hash/view/single_car_page.dart';
import 'package:hash/view/single_property_page.dart';
import 'package:hash/widget/dubzill_card_design.dart';
import '../model/cars_card_view_model.dart';
import '../model/property_card_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import '../model/root.dart';
import '../services/front_card_view_http_request.dart';
import '../widget/cars_homePage_card.dart';
import 'cars_upload_filter_page.dart';
import 'motors/motors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  RefreshController _shimmerRefreshController = RefreshController(initialRefresh: false);

  List<Tabs>? tabs;
  List<CarsCardView>? _carsFrontCard;
  List<PropertyCardView>? _propertyFrontCard;

  var isLoaded = false;
  var isLoadedCars = false;
  var isLoadedProperty = false;

  @override
  void initState() {
    super.initState();
    getData();
    getCarsData();
    getPropertyData();
  }

  getPropertyData() async {
    _propertyFrontCard = await FrontViewCard().propertyCardView();
    if (_propertyFrontCard != null) {
      setState(() {
        isLoadedProperty = true;
      });
    }
  }

  getCarsData() async {
    _carsFrontCard = await FrontViewCard().carsCardView();
    if (_carsFrontCard != null) {
      setState(() {
        isLoadedCars = true;
      });
      // return tabsFromJson(_carsFrontCard.toString());
    }
  }

  getData() async {
    tabs = await RemoteService().getTabs();
    if (tabs != null) {
      setState(() {
        isLoaded = true;
      });

    }
  }

  Future<void> _Refresh() async {
    await getData();
    await getCarsData();
    await getPropertyData();
    _refreshController.refreshCompleted();
    print("refresh");
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CarsUploadFilterPage()));
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
          replacement: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(
              backgroundColor: Color.fromRGBO(64, 75, 96, .9),
              distance: 100,
            ),
            onRefresh: _Refresh,
            controller: _shimmerRefreshController,
            physics: BouncingScrollPhysics(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: DubzillCardWidget(
                                title: "", icon: "", onTap: () {})),
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: DubzillCardWidget(
                                title: "", icon: "", onTap: () {})),
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: DubzillCardWidget(
                                title: "", icon: "", onTap: () {})),
                      ],
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .37,
                  width: MediaQuery.of(context).size.width * .1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: PropertyCard(
                            price: "",
                            img: "",
                            location: "",
                            title: "",
                            onTap: () {},
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: PropertyCard(
                            price: "",
                            img: "",
                            location: "",
                            title: "",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //propertyDisplay(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .37,
                  width: MediaQuery.of(context).size.width * .1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: CarsCard(
                            price: "",
                            img: "",
                            location: "",
                            title: "",
                            logo: "",
                            onTap: () {},
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: CarsCard(
                            price: "",
                            img: "",
                            location: "",
                            title: "",
                            logo: "",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //carsDisplay()
              ],
            ),
          ),
          visible: isLoaded,
          child: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(
              backgroundColor: Color.fromRGBO(64, 75, 96, .9),
              distance: 100,
            ),
            onRefresh: _Refresh,
            controller: _refreshController,
            physics: BouncingScrollPhysics(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                FutureBuilder<List<Tabs>?>(
                    future: RemoteService().getTabs(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        // TODO: Handle this case.
                          break;
                        case ConnectionState.waiting:
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .15,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: DubzillCardWidget(
                                          title: "", icon: "", onTap: () {})),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: DubzillCardWidget(
                                          title: "", icon: "", onTap: () {})),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: DubzillCardWidget(
                                          title: "", icon: "", onTap: () {})),
                                ],
                              ),
                            ),
                          );
                        case ConnectionState.active:
                        // TODO: Handle this case.
                          break;
                        case ConnectionState.done:
                          return buildTabs(data);
                      }
                      return Center(child: CircularProgressIndicator(),);
                    }
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
                Visibility(
                  replacement: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: PropertyCard(
                      price: "",
                      img: "",
                      location: "",
                      title: "",
                      onTap: () {},
                    ),
                  ),
                  visible: isLoadedProperty,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width * .1,
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _propertyFrontCard?.length,
                      itemBuilder: (context, index) {
                        return PropertyCard(
                          price: _propertyFrontCard![index].price.toString(),
                          img: _propertyFrontCard![index].fronPhoto.toString(),
                          location: _propertyFrontCard![index].areaName.toString(),
                          title: _propertyFrontCard![index].titel.toString(),
                          onTap: ()  async {
                            if(isLoadedProperty){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SinglePropertyDetailPage(
                                          adId: _propertyFrontCard![index]
                                              .id
                                              .toString(),
                                        )));}
                            else{
                              Center(child: CircularProgressIndicator(),);
                            }
                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.25,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 5,
                      ),
                    ),
                  ),
                ),
                //propertyDisplay(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
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
                Visibility(
                  replacement: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: CarsCard(
                      price: "",
                      img: "",
                      location: "",
                      title: "",
                      logo: "",
                      onTap: () {},
                    ),
                  ),
                  visible: isLoadedCars,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width * .1,
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _carsFrontCard?.length,
                      itemBuilder: (context, index) {
                        return CarsCard(
                          price: _carsFrontCard![index].price.toString(),
                          img: _carsFrontCard![index].fronPhoto.toString(),
                          location: _carsFrontCard![index].id.toString(),
                          title: _carsFrontCard![index].title.toString(),
                          logo: _carsFrontCard![index].logo.toString(),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleCarDetailsPage(
                                      adId: _carsFrontCard![index]
                                          .id
                                          .toString(),
                                    )));

                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.25,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 0,
                      ),
                    ),
                  ),
                ),

                //carsDisplay()
              ],
            ),
          ),
        ),
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

  Widget buildTabs(List<Tabs>? data) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: data?.length,
        itemBuilder: (context, index) {
          return DubzillCardWidget(
            title: context.locale.toString() == 'ar'
                ? data![index].arabicLabel
                : data![index].englishLabel,
            icon: data[index].icon,
            onTap: () async {
              print(Intl.getCurrentLocale());
              if (data[index].id == '1') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PropertyForRentTypes(
                          parentId: data[index].id,
                        )));
              } else if (data[index].id == '2') {
                filterId.add(data[index].id);
                filterName.add(data[index].name);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PropertyForSaleTypes(
                          parentId: data[index].id,
                        )));
              } else if (data[index].id == '3') {
                filterId.add(data[index].id);
                filterName.add(data[index].name);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MotorsSale()));
              }
            },
          );
        },
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
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
    required this.onTap,
  }) : super(key: key);
  final String img;
  final String title;
  final String location;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: InkWell(
        onTap: onTap,
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
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("assets/placeholder.png"),
                              fit: BoxFit.cover)),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 12.0,
                                color: Colors.grey.withOpacity(0.5))
                          ],
                        ),
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          image: "http://192.168.15.124/easy/image/${img}",
                          placeholder: "assets/placeholder.png",
                        ),
                      ),
                    ),
                  ],
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


