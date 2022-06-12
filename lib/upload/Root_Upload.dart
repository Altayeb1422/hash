import 'package:flutter/material.dart';
import 'package:hash/upload/property%20for%20rent%20upload/upload_property_rent_catigory.dart';
import '../main.dart';
import '../model/root.dart';
import '../services/remote_services.dart';
import '../view/property for sale/property_for_sale_types.dart';
import '../widget/dubzill_card_design.dart';
import 'cars/upload_cars_category.dart';

class UploadProperty extends StatefulWidget {
   UploadProperty({Key? key, required this.adsCode}) : super(key: key);
  //final userId = auth.currentUser!.uid.toString();
  final String adsCode ;
  @override
  State<UploadProperty> createState() => _UploadPropertyState();
}

class _UploadPropertyState extends State<UploadProperty> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color:  Colors.black,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            itemCount: tabs?.length,
            itemBuilder: (context, index) {
              return DubzillCardWidget(
                title: tabs![index].name,
                icon: tabs![index].icon,
                onTap: () async {
                  if (tabs![index].id == '1') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UploadPropertyForRentCatigory(
                              select1: tabs![index].id,
                              select1Name: tabs![index].name,
                            )));
                  } else if (tabs![index].id == '2') {
                    filterId.add(tabs![index].id);
                    filterName.add(tabs![index].name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UploadPropertyForRentCatigory(
                              select1: tabs![index].id,
                              select1Name: tabs![index].name,
                            )));
                  }else if (tabs![index].id == '3') {
                    filterId.add(tabs![index].id);
                    filterName.add(tabs![index].name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UploadCarsForSaleCategory(
                              select1: tabs![index].id,
                              select1Name: tabs![index].name,
                            )));
                  }
                },
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ),);
  }
}
