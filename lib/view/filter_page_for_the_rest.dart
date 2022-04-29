import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../widget/card_widget_filter_page.dart';

class FilterPageTheRest extends StatefulWidget {
   FilterPageTheRest({Key? key, this.select2, this.select3, this.select4, this.select2Name, this.select1Name}) : super(key: key);
  final dynamic select2;
  final dynamic select3;
  final dynamic select4;
  final dynamic select2Name;
  final dynamic select1Name;
  @override
  _FilterPageTheRestState createState() => _FilterPageTheRestState();
}

class _FilterPageTheRestState extends State<FilterPageTheRest> {
  Future<void> sendData() async {
    var res = await http.post(Uri.parse("http://192.168.15.100/easy/insert_ads.php"), body: {
      "Select2": widget.select2,
      "Select3": widget.select3,
      "Select4": widget.select4,
      "Date": DateTime.now().toString(),
      "AdsCode": 'RS01',
      "Space": 123.toString(),
      "CityName": 'Khartoum'

    }); //sending post request with header data

    if(res.statusCode == 200){
      debugPrint("Data posted successfully");
      print(res.body);
      //json.decode(res.body);
      var jason = res.body;
    }else{
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardWidgetFilterPage(title: 'Category', onTap: (){}, choice: widget.select1Name),
              CardWidgetFilterPage(title: "type".tr(), onTap: (){}, choice: widget.select2Name),
              CardWidgetFilterPage(title: "City".tr(), onTap: (){}, choice: ''),
              const SizedBox(height: 20,),
               TitleWidget(title: "neighbour".tr()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "e.g".tr(),
                    contentPadding: const EdgeInsets.all(18.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                  ),
                ),
              ),
               TitleWidget(title: "price".tr()),
              const MaxMinBoxes(),

               TitleWidget(title: "space".tr()),
              const MaxMinBoxes(),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MaterialButton(
                    onPressed: () async {sendData();},
                    elevation: 26,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                            "Upload",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaxMinBoxes extends StatelessWidget {
  const MaxMinBoxes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                hintText: "min".tr(),
                contentPadding: const EdgeInsets.all(18.0),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent)
                ),
              ),
            ),
          ),
          const SizedBox(width: 25,),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                hintText: "max".tr(),
                contentPadding: const EdgeInsets.all(18.0),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key, required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}



