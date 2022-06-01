import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widget/card_widget_filter_page.dart';
import 'package:filter_list/filter_list.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class PropertyUploadFilterPage extends StatefulWidget {
  PropertyUploadFilterPage({Key? key, this.allTextList, this.selectedUserList,this.select2, this.select3, this.select4, this.select2Name, this.select1Name})
      : super(key: key);
  final List<User>? allTextList;
  final List<User>? selectedUserList;
  final dynamic select2;
  final dynamic select3;
  final dynamic select4;
  final dynamic select2Name;
  final dynamic select1Name;
  @override
  _PropertyUploadFilterPageState createState() => _PropertyUploadFilterPageState();
}

class _PropertyUploadFilterPageState extends State<PropertyUploadFilterPage> {
  String? valueChoose;
  int tag = 1;
  List<User>? selectedUserList = [];
  // multiple choice value
  List<String> tags = [];

  // list of string options
  void _openFilterDialog() async {
    await FilterListDialog.display<User>(
      context,
      hideSelectedTextCount: true,
      //enableOnlySingleSelection: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select Users',
      height: 500,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.service,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.service!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        print(list);
        Navigator.pop(context);
      },

      /// uncomment below code to create custom choice chip
      /*choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
            color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          )),
          child: Text(
            item.name,
            style: TextStyle(
                color: isSelected ? Colors.blue[300] : Colors.grey[300]),
          ),
        );
      },*/
    );
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();
  late List<String> formValue;
  // final _formKey = GlobalKey<FormState>();
  // final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  // final _multiKey = GlobalKey<DropdownSearchState<String>>();
  // Future<void> sendData() async {
  //   var res = await http.post(Uri.parse("http://192.168.15.100/easy/insert_ads.php"), body: {
  //     "Select2": widget.select2,
  //     "Select3": widget.select3,
  //     "Select4": widget.select4,
  //     "Date": DateTime.now().toString(),
  //     "AdsCode": 'RS01',
  //     "Space": 123.toString(),
  //     "CityName": 'Khartoum'
  //
  // //   }); //sending post request with header data
  //
  //   if(res.statusCode == 200){
  //     debugPrint("Data posted successfully");
  //     print(res.body);
  //     //json.decode(res.body);
  //     var jason = res.body;
  //   }else{
  //     debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
  //   }
  // }
  late Timer _timer;
  var _rooms = 0;
  var _bathrooms = 0;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "USD",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          value: "USD"),
      DropdownMenuItem(
          child: Text(
            "SDG",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          value: "SDG"),
    ];
    String selectedValue = "SDG";
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardWidgetFilterPage(title: 'Category', onTap: () {}, choice: ""),
            CardWidgetFilterPage(title: "type".tr(), onTap: () {}, choice: "k"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                    height: size.height * .1,
                    width: size.width * .5,
                    child: CardWidgetFilterPage(
                        title: "City".tr(), onTap: () {}, choice: '')),
                Container(
                    height: size.height * .1,
                    width: size.width * .5,
                    child: CardWidgetFilterPage(
                        title: "Area".tr(), onTap: () {}, choice: '')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 30, bottom: 10),
              child: Text(
                "Title",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                  height: size.height * .1,
                  width: size.width * .7,
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.house_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  )),
            ),

            TitleWidget(title: "Amenities".tr()),
            // TextButton.icon(
            //   onPressed: _openFilterDialog,
            //   icon: Icon(Icons.add),
            //   label: Text(
            //     "Amenities",
            //     style: TextStyle(color: Colors.black),
            //   ),
            //   // style: ButtonStyle(
            //   //     backgroundColor: MaterialStateProperty.all(Colors.blue)),
            //   // color: Colors.blue,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Aminties(
                    title: selectedUserList![index].service!,
                    icon: selectedUserList![index].icon!,
                  );
                },
                //separatorBuilder: (context, index) => Divider(),
                itemCount: selectedUserList!.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    childAspectRatio: .4 / .15,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: _openFilterDialog,
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                top: 30,
                right: 25,
              ),
              child: Text(
                "Price",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: size.height * .1,
                    width: size.width * .4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.payments_outlined,
                          color: Colors.teal,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    )),
                Container(
                  height: size.height * .1,
                  width: size.width * .15,
                  child: DropdownButtonFormField(
                    iconEnabledColor: Colors.teal,
                    items: menuItems,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
                top: 10
              ),
              child: Text(
                "Rooms",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.meeting_room_outlined,
                      size: 30.0,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "$_rooms",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                width: 15,
                                height: 2.0,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_rooms > 0) _rooms--;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                if (_rooms > 0) _rooms--;
                              });
                              print('value $_rooms');
                            });
                          },
                          onTapUp: (TapUpDetails details) {
                            print('up');
                            _timer.cancel();
                          },
                          onTapCancel: () {
                            print('cancel');
                            _timer.cancel();
                          },
                        ),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _rooms++;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                _rooms++;
                              });
                              print('value $_rooms');
                            });
                          },
                          onTapUp: (TapUpDetails details) {
                            print('up');
                            _timer.cancel();
                          },
                          onTapCancel: () {
                            print('cancel');
                            _timer.cancel();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
                  top: 10
              ),
              child: Text(
                "Bathrooms",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.bathtub_outlined,
                      size: 30.0,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "$_bathrooms",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                width: 15,
                                height: 2.0,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_bathrooms > 0) _bathrooms--;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                if (_bathrooms > 0) _bathrooms--;
                              });
                              print('value $_bathrooms');
                            });
                          },
                          onTapUp: (TapUpDetails details) {
                            print('up');
                            _timer.cancel();
                          },
                          onTapCancel: () {
                            print('cancel');
                            _timer.cancel();
                          },
                        ),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _bathrooms++;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                _bathrooms++;
                              });
                              print('value $_bathrooms');
                            });
                          },
                          onTapUp: (TapUpDetails details) {
                            print('up');
                            _timer.cancel();
                          },
                          onTapCancel: () {
                            print('cancel');
                            _timer.cancel();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
                  top: 10,
                  bottom: 10
              ),
              child: Text(
                "Area",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: size.height * .1,
                    width: size.width * .4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.zoom_out_map,
                          color: Colors.teal,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    )),
                Container(
                  height: size.height * .1,
                  width: size.width * .15,
                  child: Center(
                      child: Text(
                    "sq m",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
                  top: 10,
                  bottom: 10
              ),
              child: Text(
                "Description",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 15),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25, bottom: 10),
              child: Text(
                "Images",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 15),
              child: Container(
                height: size.height*.2,
                  decoration: DottedDecoration(
                      shape: Shape.box,
                      strokeWidth: 2,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal),
                  child: Center(
                    child: Container(
                      height: size.height,
                      width: size.width,

                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(20),
                        color: Colors.teal.withOpacity(0.07),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined, size: 50, color: Colors.teal,),
                          SizedBox(height: 15,),
                          Text('Upload Images', style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                        ],
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  onPressed: () async {},
                  elevation: 10,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  child: Padding(
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
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, this.allTextList, this.selectedUserList})
      : super(key: key);
  final List<User>? allTextList;
  final List<User>? selectedUserList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FilterListWidget<User>(
        themeData: FilterListThemeData(context),
        hideSelectedTextCount: true,
        listData: userList,
        controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
        selectedListData: selectedUserList,
        onApplyButtonClick: (list) {
          Navigator.pop(context, list);
        },
        choiceChipLabel: (item) {
          /// Used to print text on chip
          return item!.service;
        },
        // choiceChipBuilder: (context, item, isSelected) {
        //   return Container(
        //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //     decoration: BoxDecoration(
        //         border: Border.all(
        //       color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
        //     )),
        //     child: Text(item.name),
        //   );
        // },
        validateSelectedItem: (list, val) {
          ///  identify if item is selected or not
          return list!.contains(val);
        },
        onItemSearch: (user, query) {
          /// When search query change in search bar then this method will be called
          ///
          /// Check if items contains query
          return user.service!.toLowerCase().contains(query.toLowerCase());
        },
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
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent)),
              ),
            ),
          ),
          // const SizedBox(
          //   width: 25,
          // ),
          // Expanded(
          //   child: TextField(
          //     decoration: InputDecoration(
          //       isDense: true,
          //       hintText: "max".tr(),
          //       contentPadding: const EdgeInsets.all(18.0),
          //       filled: true,
          //       fillColor: Colors.white,
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //           borderSide: const BorderSide(color: Colors.redAccent)),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25, bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });
}

class User {
  final String? service;
  final IconData? icon;
  User({this.service, this.icon});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<User> userList = [
  User(
    service: "Oven",
    icon: Icons.microwave,
  ),
  User(
    service: "Parking",
    icon: Icons.local_parking_rounded,
  ),
  User(
    service: "Elevator",
    icon: Icons.elevator_rounded,
  ),
  User(
    service: "Generator",
    icon: Icons.bolt_rounded,
  ),
  User(
    service: "tv",
    icon: Icons.tv,
  ),
  User(
    service: "AC",
    icon: Icons.ac_unit_rounded,
  ),
  User(
    service: "Kitchen",
    icon: Icons.kitchen_rounded,
  ),
  User(
    service: "Wi-Fi",
    icon: Icons.wifi,
  ),
  User(
    service: "Iron",
    icon: Icons.iron_rounded,
  ),
  User(
    service: "utinsels",
    icon: Icons.flatware,
  ),
  User(
    service: "Pool",
    icon: Icons.pool_rounded,
  ),
  User(
    service: "Yard",
    icon: Icons.deck_rounded,
  ),
  User(
    service: "Garden",
    icon: Icons.grass,
  ),
  User(
    service: "Security",
    icon: Icons.security_rounded,
  ),
  User(
    service: "Furnished",
    icon: Icons.chair_rounded,
  ),
  User(
    service: "Door bell",
    icon: Icons.doorbell_rounded,
  ),
  User(
    service: "Garage",
    icon: Icons.garage_rounded,
  ),
  User(
    service: "Cameras",
    icon: Icons.camera_outdoor_rounded,
  ),
  User(
    service: "Gas",
    icon: Icons.propane_tank,
  ),
  User(
    service: "Heater",
    icon: Icons.hot_tub_rounded,
  ),
];

class Aminties extends StatelessWidget {
  const Aminties({
    Key? key,
    this.icon,
    required this.title,
  }) : super(key: key);
  final IconData? icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        primary: Colors.white,
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      ),
      onPressed: () {},
      label: Text(
        title,
        style: TextStyle(
            fontSize: 5,
            //color: Colors.grey,
            overflow: TextOverflow.ellipsis),
      ),
      icon: Icon(
        icon,
        size: 17,
        color: Colors.teal,
      ),
    );
  }
}
