
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hash/model/fetch_property_detailes_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/property_ads_photos_model.dart';
import '../model/property_amenities_model.dart';
import '../services/ads_details_http_request.dart';
import '../services/ads_features_http_request.dart';
import '../services/ads_photos_http_request.dart';
import '../widget/slider.dart';
import 'package:flutter_svg/svg.dart';

class SinglePropertyDetailPage extends StatefulWidget {
  const SinglePropertyDetailPage({Key? key, this.adId}) : super(key: key);
  final dynamic adId;

  @override
  State<SinglePropertyDetailPage> createState() =>
      _SinglePropertyDetailPageState();
}

class _SinglePropertyDetailPageState extends State<SinglePropertyDetailPage> {

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffF9521E),
        onPressed: () {},
        child: Icon(Icons.phone),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List<PropertyAdsPhotos>?>(
              future: AdsPhotosService().getPropertyAdPhotos(widget.adId),
               builder: (context, snapshot) {
                final imgs = snapshot.data;
                if(snapshot.error != null){
                  return Center(child: Text("No Pictures"));
                }else{
                  if (snapshot.hasData){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      // TODO: Handle this case.
                        break;
                      case ConnectionState.waiting:
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height:MediaQuery.of(context).size.height* .55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10.0, color: Colors.grey.withOpacity(0.5))
                                ],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Stack(
                                children: [
                                  CarouselSlider.builder(
                                      itemCount: 1,
                                      itemBuilder: (context, index, realIndex) {
                                        final img = "";
                                        return buildImage(img, index);
                                      },
                                      options: CarouselOptions(
                                          height: double.infinity,
                                          viewportFraction: 1,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) {
                                            // setState(() {
                                            //   activeIndex = 0;
                                            // });
                                          })),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: AnimatedSmoothIndicator(
                                        count: 1,
                                        activeIndex: activeIndex,
                                        effect: const ExpandingDotsEffect(
                                          dotHeight: 10,
                                          dotWidth: 10,
                                          activeDotColor: Color(0xffF9521E),
                                          dotColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0, left: 10),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.arrow_back_ios, size: 25,), color: Color(0xffF9521E),)),
                                  )
                                ],
                              ),
                            ));
                      case ConnectionState.active:
                      // TODO: Handle this case.
                        break;
                      case ConnectionState.done:
                        return buildImages(imgs);
                    }
                  }
                }

                return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height:MediaQuery.of(context).size.height* .55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0, color: Colors.grey.withOpacity(0.5))
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Stack(
                        children: [
                          CarouselSlider.builder(
                              itemCount: 1,
                              itemBuilder: (context, index, realIndex) {
                                final img = "";
                                return buildImage(img, index);
                              },
                              options: CarouselOptions(
                                  height: double.infinity,
                                  viewportFraction: 1,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeIndex = 0;
                                    });
                                  })),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AnimatedSmoothIndicator(
                                count: 1,
                                activeIndex: activeIndex,
                                effect: const ExpandingDotsEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotColor: Color(0xffF9521E),
                                  dotColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0, left: 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios, size: 25,), color: Color(0xffF9521E),)),
                          )
                        ],
                      ),
                    ));
              }
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Container(
                height: size.height * .439,
                width: size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder <FetchPropertyDetails?> (
                            future: AdsDetailsService().postPropertyAdID(widget.adId),
                            builder: (context, snapshot) {
                              final data = snapshot.data;
                              if(snapshot.error != null){
                                return Center(child: Text("No Details"));
                              }else{
                                if (snapshot.hasData){
                                  switch(snapshot.connectionState){
                                    case ConnectionState.none:
                                      return Text("No Connection");
                                    case ConnectionState.waiting:
                                      return Center(child: CircularProgressIndicator(),);
                                    case ConnectionState.active:
                                    // TODO: Handle this case.
                                      break;
                                    case ConnectionState.done:
                                      return details(data!);
                                  }
                                }
                              }
                              return Center(child: CircularProgressIndicator(),);
                            }
                        ),

                        FutureBuilder<List<PropertyAmenities>?>  (
                            future: AdsFeaturesService().adsFeatures(widget.adId),
                            builder: (context, snapshot) {
                              final data = snapshot.data;
                              if(snapshot.error != null){
                                return Center(child: Text("No Amenities"));
                              }else{
                                if (snapshot.hasData){
                                  switch(snapshot.connectionState){
                                    case ConnectionState.none:
                                      return Text("No Connection");

                                    case ConnectionState.waiting:
                                      return Center(child: CircularProgressIndicator(),);
                                    case ConnectionState.active:
                                    // TODO: Handle this case.
                                      break;
                                    case ConnectionState.done:
                                      return Amenities(data!);
                                  }
                                }
                              }

                              return Center(child: CircularProgressIndicator(),);
                            }
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImages(List<PropertyAdsPhotos>? imgs) {
    return Container(
      height:MediaQuery.of(context).size.height* .55,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 10.0, color: Colors.grey.withOpacity(0.5))
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: PhotoSlider(images: imgs!,),
    );
  }

  Widget details(FetchPropertyDetails data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.titel.toString(),
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
            Row(
              children: [
                Text(
                  data.price.toString(),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(width: 5,),
                Text(
                  "${data.currancy.toString()}/${data.period.toString()}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
        ),

        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              size: 17,
              color: Colors.teal,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${data.cityName}, ${data.areaName}",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Description",
          style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
         "${data.generalDescription}",
          style: TextStyle(
            fontSize: 19,
            color: Colors.black,
            //fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceEvenly,
          spacing:8.0,
          runSpacing: 8.0,
          // // crossAxisAlignment: WrapCrossAlignment.s,
          // textDirection: TextDirection.rtl,
          verticalDirection: VerticalDirection.up,
          children: [
            Aminties(
              title: '${data.rooms} Bedrooms',
              icon: Icons.hotel,
            ),
            Aminties(
              title: '${data.bathrooms} Bathroom',
              icon: Icons.bathtub,
            ),
            Aminties(
                icon: Icons.zoom_out_map, title: "${data.space} m"),
            Aminties(
                icon: Icons.domain, title: "${data.floors} floor"),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Amenities",
          style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget Amenities(List<PropertyAmenities>?  propertyAmenities) {
    return  GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: propertyAmenities!.length,
      itemBuilder: (context, index) {
        return OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1.0, color: Colors.teal),
            shape:  RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.teal,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            primary: Colors.black,
            //backgroundColor: Color.fromRGBO(64, 75, 96, .9),
          ),
          onPressed: () {},
          label: Text(
            "${propertyAmenities[index].name}",
            style: TextStyle(
                fontSize: 16,
                //color: Colors.grey,
                overflow: TextOverflow.ellipsis),
          ),
          icon: SvgPicture.string(propertyAmenities[index].icon.toString(), color: Colors.teal, height: 18, width: 18, ),
        );
      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20),
    );
  }
}

class Aminties extends StatelessWidget {
  const Aminties({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.0, color: Colors.teal),
        shape:  RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.teal,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        primary: Colors.black,
        //backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      ),
      onPressed: () {},
      label: Text(
        title,
        style: TextStyle(
            fontSize: 16,
            //color: Colors.grey,
            overflow: TextOverflow.ellipsis),
      ),
      icon: Icon(
        icon,
        size: 18,
        color: Colors.teal,
      ),
    );
  }
}
// class PropertyAmenities extends StatelessWidget {
//   const PropertyAmenities({
//     Key? key,
//     required this.icon,
//     required this.title,
//   }) : super(key: key);
//   final IconData icon;
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton.icon(
//       style: OutlinedButton.styleFrom(
//         side: BorderSide(width: 1.0, color: Colors.teal),
//         shape:  RoundedRectangleBorder(
//             side: BorderSide(
//               color: Colors.teal,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(20))),
//         primary: Colors.black,
//         //backgroundColor: Color.fromRGBO(64, 75, 96, .9),
//       ),
//       onPressed: () {},
//       label: Text(
//         title,
//         style: TextStyle(
//             fontSize: 16,
//             //color: Colors.grey,
//             overflow: TextOverflow.ellipsis),
//       ),
//       icon: Icon(
//         icon,
//         size: 18,
//         color: Colors.teal,
//       ),
//     );
//   }
// }
Widget buildImage(String imgs, int index) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage("assets/placeholder.png"),
                fit: BoxFit.contain)),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.grey.withOpacity(0.5))
            ],
          ),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.fill,
            image: "http://192.168.15.124/easy/image/${imgs}",
            placeholder: "assets/placeholder.png",
          ),
        ),
      ),
      // Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20),
      //     image: DecorationImage(image: NetworkImage("http://192.168.15.124/easy/image/${imgs}"), fit: BoxFit.fill),
      //   ),
      // ),
    ],
  );
}

