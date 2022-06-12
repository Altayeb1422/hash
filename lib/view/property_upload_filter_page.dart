import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../images_page.dart';
import '../services/image_upload_request.dart';
import '../widget/card_widget_filter_page.dart';
import 'package:filter_list/filter_list.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

late File propertyImage1;
late List<File> PropertyImages = [];
var adsId;

TextEditingController titleController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController spaceController = TextEditingController();
TextEditingController descController = TextEditingController();

class PropertyUploadFilterPage extends StatefulWidget {
  PropertyUploadFilterPage(
      {Key? key,
      this.allTextList,
      this.selectedUserList,
      this.select2,
      this.select3,
      this.select4,
      this.select2Name,
      this.select1Name})
      : super(key: key);
  final List<User>? allTextList;
  final List<User>? selectedUserList;
  final dynamic select2;
  final dynamic select3;
  final dynamic select4;
  final dynamic select2Name;
  final dynamic select1Name;
  @override
  _PropertyUploadFilterPageState createState() =>
      _PropertyUploadFilterPageState();
}

class _PropertyUploadFilterPageState extends State<PropertyUploadFilterPage> {

  final picker = ImagePicker();

  void openFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FilesPage(files: files, onOpenedFile: openFile)));
  }
  Widget buildFile(file) {
    //final kb = file.size/1024;
    // final mb = kb/1024;
    // final fileSize = mb>= 1? mb.toStringAsFixed(2): kb.toStringAsFixed(2);
    //final extension = file.extension??'none';
    final  img = file.path;
    return InkWell(
      onTap: ()=> OpenFile.open(file.path),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child:
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.file(File(img!)),
            )),
          ],
        ),
      ),
    );
  }
  Future<void> propertyMainUpload() async {
    var res = await http
        .post(Uri.parse("http://192.168.15.116/easy/insert_ads.php"), body: {
      "Client_ID": "",
      "AdsCode": "",
      "Select2": widget.select2.toString(),
      "Select3": widget.select3.toString(),
      "Select4": widget.select4.toString(),
      "Rooms": _rooms.toString(),
      "Bathrooms": _bathrooms.toString(),
      "Floors": _floors.toString(),
      "Currancy": currencySelectedValue.toString(),
      "Period": periodSelectedValue.toString(),
      "Titel": titleController.text.toString(),
      "Price": priceController.text.toString(),
      "Space": spaceController.text.toString(),
      "GeneralDescription": descController.text.toString(),
      "CityName": "Khartoum",
      "AreaName": "Buri",
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body);
      print("Post sucessful"); //print raw response on console
      var data = json.decode(res.body);
      adsId = data["AdsId"];
      print(data["AdsId"]); //decoding json to array
    } else {
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }


  postingList(String service) async {
    final uri = "http://192.168.15.116/easy/features.php";
    data = {"Ads_Id": adsId.toString(), "Desc_Name": service};
    http.Response response = await http.post(
      Uri.parse(uri),
      body: data,
    );
    if (response.statusCode == 200) {
      //show your outputs
      print(selectedUserList!.toString());
    } else {
      Fluttertoast.showToast(msg: "“Error Occurred”", timeInSecForIosWeb: 25);
    }
  }



  String? valueChoose;
  int tag = 1;
  List<User>? selectedUserList = [];
  // multiple choice value
  List<String> tags = [];
   String? hireID;
   Map<String, String>? data;
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
        Navigator.pop(context);
        print(selectedUserList);
      },

      /// uncomment below code to create custom choice chip
      // choiceChipBuilder: (context, item, isSelected) {
      //   return Container(
      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(28),
      //         border: Border.all(
      //       color: isSelected! ? Colors.teal[300]! : Colors.grey[300]!,
      //     )),
      //     child: Row(
      //       children: [
      //         Icon(
      //           item.icon,
      //           size: 18,
      //           color: Colors.teal,
      //         ),
      //         Text(
      //           item.service,
      //           style: TextStyle(
      //               color: isSelected ? Colors.black : Colors.grey[300]),
      //         ),
      //       ],
      //     ),
      //   );
      // },
    );
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();
  late List<String> formValue;
  var title, price, space, desc;
  late Timer _timer;
  var _rooms = 0;
  var _bathrooms = 0;
  var _floors = 0;
  var period;
  var currency;
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
  List<DropdownMenuItem<String>> periods = [
    DropdownMenuItem(
        child: Text(
          "Day",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        value: "Day"),
    DropdownMenuItem(
        child: Text(
          "Month",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        value: "Month"),
  ];
  String periodSelectedValue = "Month";
  String currencySelectedValue = "SDG";

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      propertyImage1 = File(pickedImage!.path);
    });
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
  @override
  Widget build(BuildContext context) {
    int length = PropertyImages.length-1;
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
            CardWidgetFilterPage(
                title: 'Category', onTap: () {}, choice: widget.select1Name),
            CardWidgetFilterPage(
                title: "type".tr(), onTap: () {}, choice: widget.select2Name),
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
                    onSaved: (val) {
                      title = val;
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.house_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  )),
            ),

            TitleWidget(title: "Amenities".tr()),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Aminties(
                    title: selectedUserList![index].service!,
                    icon: selectedUserList![index].icon!, onTap: () {postingList(selectedUserList![index].service!);},
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
                bottom: 10,
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
                      onSaved: (val) {
                        price = val;
                      },
                      controller: priceController,
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
                    onSaved: (val) {
                      currency = currencySelectedValue;
                    },
                    iconEnabledColor: Colors.teal,
                    items: menuItems,
                    value: currencySelectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        currencySelectedValue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: size.height * .1,
                  width: size.width * .17,
                  child: DropdownButtonFormField(
                    onSaved: (val) {
                      period = val;
                    },
                    iconEnabledColor: Colors.teal,
                    items: periods,
                    value: periodSelectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        periodSelectedValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
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
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
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
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
              child: Text(
                "Floors",
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
                      Icons.apartment_rounded,
                      size: 30.0,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "$_floors",
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
                              if (_floors > 0) _floors--;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                if (_floors > 0) _floors--;
                              });
                              print('value $_floors');
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
                              _floors++;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                _floors++;
                              });
                              print('value $_floors');
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
                  left: 25.0, right: 25, top: 10, bottom: 10),
              child: Text(
                "Space",
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
                      onSaved: (val) {
                        space = val;
                      },
                      controller: spaceController,
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
                  left: 25.0, right: 25, top: 10, bottom: 10),
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
              child: TextFormField(
                onSaved: (val) {
                  desc = val;
                },
                controller: descController,
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
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 25, bottom: 10),
              child: Text(
                "Images",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            InkWell(
              onTap: () async {
                final result = await FilePicker.platform
                    .pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: [
                      "jpg",
                      "png",
                      "jpeg"
                    ]);
                if (result != null) {
                  // Not sure if I should only get file path or complete data (this was in package documentation)
                  List<File> files = result.paths
                      .map((path) => File(path!))
                      .toList();
                  PropertyImages = files;
                } else {
                  // User canceled the picker
                }
                //open single file
                openFiles(result!.files);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25, top: 15),
                child: Container(
                    height: size.height * .2,
                    decoration: DottedDecoration(
                        shape: Shape.box,
                        strokeWidth: 2,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.teal),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: size.height,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal.withOpacity(0.07),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                  color: Colors.teal,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Upload Images',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * .2,
                          decoration: DottedDecoration(
                              shape: Shape.box,
                              strokeWidth: 2,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal),
                          child: GridView.builder(
                              padding: const EdgeInsets.all(6),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, ),
                              itemCount: PropertyImages.length,
                              itemBuilder:(context, index){
                                final file = PropertyImages[index];
                                return buildFile(file);
                              }),
                        ),

                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  onPressed: () async {
                    await propertyMainUpload();
                    for (int i = 0; i <= selectedUserList!.length-1; i++){
                      if(selectedUserList![i].service! != null){
                        await postingList(selectedUserList![i].service!);
                      }
                    };
                    if(PropertyImages.length > 5){
                      length = 5;
                    }
                    for (int i = 0; i <= length; i++){
                      await postImagesIds();
                      if(PropertyImages[i] != null){
                       await uploadMultipleImages(PropertyImages[i]);
                      }
                    }
                    print(length);
                  },
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

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 15),
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
    required this.title, required this.onTap,
  }) : super(key: key);
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.0, color: Colors.teal),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.teal,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        primary: Colors.black,
        //backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      ),
      onPressed: onTap,
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
