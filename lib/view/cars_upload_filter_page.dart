import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:open_file/open_file.dart';
import '../images_page.dart';
import '../services/image_upload_request.dart';
import '../widget/card_widget_filter_page.dart';
import 'package:filter_list/filter_list.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';


var carAdsId;

class CarsUploadFilterPage extends StatefulWidget {
  CarsUploadFilterPage({Key? key, this.allTextList, this.selectedUserList,this.select2,
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
  _CarsUploadFilterPageState createState() => _CarsUploadFilterPageState();
}

class _CarsUploadFilterPageState extends State<CarsUploadFilterPage> {
  late File carsImage1;
  late List<File> carsImages = [];
  final picker = ImagePicker();

  TextEditingController carNameController = TextEditingController();
  TextEditingController carPriceController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController carDistanceController = TextEditingController();
  TextEditingController carDescController = TextEditingController();


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

  Future<void> CarsMainUpload() async {
    var res = await http
        .post(Uri.parse("http://192.168.15.116/easy/car_ads.php"), body: {
      "Client_ID": "".toString(),
      "AdsCode": "".toString(),
      "Select2": widget.select2.toString(),
      "Select3": widget.select3.toString(),
      "Select4": widget.select4.toString(),
      "Title" : carNameController.text,
      "Price" : carPriceController.text,
      "Currency" : selectedCurrencyValue.toString(),
      "Seats" : _seats.toString(),
      "Engine" : _cylinders.toString(),
      "Model" : carModelController.text,
      "Color" : carColorController.text,
      "Distance" : carDistanceController.text,
      "Fuel" : fuelSelectedValue.toString(),
      "State" : conditionSelectedValue.toString(),
      "GeneralDescription" : carDescController.text,
      "CityName" : "Kh",
      "AreaName" : "",
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body);
      print("Post successful"); //print raw response on console
      var data = json.decode(res.body);
      carAdsId = data["AdsId"];
      print(data["AdsId"]); //decoding json to array
    } else {
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }

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
      enableOnlySingleSelection: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select Users',
      height: 500,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.name!.toLowerCase().contains(query.toLowerCase());
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
  List<DropdownMenuItem<String>> fuel = [
    DropdownMenuItem(
        child: Text(
          "Gasoline",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        value: "Gasoline"),
    DropdownMenuItem(
        child: Text(
          "Diesel",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        value: "Diesel"),
  ];
  List<DropdownMenuItem<String>> condition = [
    DropdownMenuItem(
        child: Text(
          "New",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        value: "New"),
    DropdownMenuItem(
        child: Text(
          "Used",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        value: "Used"),
  ];
  String selectedCurrencyValue = "SDG";
  String fuelSelectedValue = "Gasoline";
  String conditionSelectedValue = "Used";

  final formKey = GlobalKey<FormState>();
  late List<String> formValue;
  late Timer _timer;
  var _seats = 0;
  var _cylinders = 0;
  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      carsImage1 = File(pickedImage!.path);
    });
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
  @override
  Widget build(BuildContext context) {
    int length = carsImages.length-1;
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
            CardWidgetFilterPage(title: 'Category', onTap: () {}, choice: widget.select1Name),
            CardWidgetFilterPage(title: "type".tr(), onTap: () {}, choice: widget.select2Name),
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
            TitleWidget(title: "Name".tr()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: size.height * .1,
                    width: size.width * .7,
                    child: TextFormField(
                      controller: carNameController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.directions_car_outlined,
                          color: Colors.teal,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    )),
                SizedBox(
                  width: 10,
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BrandName(
                        title: selectedUserList![index].name!,
                        brand: selectedUserList![index].brand!,
                      ),
                    ],
                  );
                },
                //separatorBuilder: (context, index) => Divider(),
                itemCount: selectedUserList!.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
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
                      controller: carPriceController,
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
                    value: selectedCurrencyValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrencyValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
              child: Text(
                "Passengers",
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
                      Icons.airline_seat_recline_normal_outlined,
                      size: 30.0,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "$_seats",
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
                              if (_seats > 0) _seats--;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                if (_seats > 0) _seats--;
                              });
                              print('value $_seats');
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
                              _seats++;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                _seats++;
                              });
                              print('value $_seats');
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
                "Engine",
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
                      LineIcons.oilCan,
                      size: 30.0,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "$_cylinders",
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
                              if (_cylinders > 0) _cylinders--;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                if (_cylinders > 0) _cylinders--;
                              });
                              print('value $_cylinders');
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
                              _cylinders++;
                            });
                          },
                          onTapDown: (TapDownDetails details) {
                            print('down');
                            _timer = Timer.periodic(Duration(milliseconds: 100),
                                (t) {
                              setState(() {
                                _cylinders++;
                              });
                              print('value $_cylinders');
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
                "Model",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                  height: size.height * .1,
                  width: size.width * .25,
                  child: TextFormField(
                    controller: carModelController,
                    decoration: InputDecoration(
                      hintText: "2017",
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  )),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 10, bottom: 10),
              child: Text(
                "Color",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                  height: size.height * .1,
                  width: size.width * .25,
                  child: TextFormField(
                    controller: carColorController,
                    decoration: InputDecoration(
                      hintText: "White",
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                      icon: Icon(
                        Icons.format_color_fill_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 10, bottom: 10),
              child: Text(
                "Distance",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Container(
                      height: size.height * .1,
                      width: size.width * .25,
                      child: TextFormField(
                        controller: carDistanceController,
                        decoration: InputDecoration(
                          hintText: "85,000",
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          icon: Icon(
                            Icons.speed_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      )),
                ),
                Container(
                  height: size.height * .1,
                  width: size.width * .15,
                  child: Center(
                      child: Text(
                    "Km",
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
                "Fuel",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                  child: Icon(
                    Icons.local_gas_station_outlined,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: size.height * .1,
                  width: size.width * .2,
                  child: DropdownButtonFormField(
                    iconEnabledColor: Colors.teal,
                    items: fuel,
                    value: fuelSelectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        fuelSelectedValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 10, bottom: 10),
              child: Text(
                "Condition",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                  child: Icon(
                    Icons.manage_history,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: size.height * .1,
                  width: size.width * .2,
                  child: DropdownButtonFormField(
                    iconEnabledColor: Colors.teal,
                    items: condition,
                    value: conditionSelectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        conditionSelectedValue = newValue!;
                      });
                    },
                  ),
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
              child: TextField(
                controller: carDescController,
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
                  carsImages = files;
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
                              itemCount: carsImages.length,
                              itemBuilder:(context, index){
                                final file = carsImages[index];
                                return buildFile(file);
                              },
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  onPressed: () async {
                    ProgressDialog pd = ProgressDialog(context: context);
                    pd.show(
                      //hideValue: true,
                      progressType: ProgressType.normal,
                      barrierDismissible: true,
                      max: length,
                      msg: 'File Uploading...',
                      completed:
                      // Completed values can be customized
                      Completed(completedMsg: "Uploading Done !"),
                      progressBgColor: Colors.transparent,
                    );
                    await CarsMainUpload();
                    if(carsImages.length > 5){
                      length = 5;
                    }
                    for (int i = 0; i <= length; i++){
                      pd.update(value: i, msg: 'File uploading...');
                      if(carsImages[i] != null){
                        await uploadCarsImages(carsImages[i]);
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
                  ),
              ),
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
      padding:
          const EdgeInsets.only(left: 25.0, top: 30, right: 25, bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
  final String? name;
  final String? brand;
  User({this.name, this.brand});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<User> userList = [
  User(
    name: "Acura",
    brand: "assets/cars/acura.svg",
  ),
  User(
    name: "Alfa romeo",
    brand: "assets/cars/alfa.svg",
  ),
  User(
    name: "Audi",
    brand: "assets/cars/audi.svg",
  ),
  User(
    name: "BMW",
    brand: "assets/cars/bmw.svg",
  ),
  User(
    name: "BYD",
    brand: "assets/cars/BYD.svg",
  ),
  User(
    name: "Chevrolet",
    brand: "assets/cars/chevrolet.svg",
  ),
  User(
    name: "Daewoo",
    brand: "assets/cars/daewoo.svg",
  ),
  User(
    name: "Ford",
    brand: "assets/cars/ford.svg",
  ),
  User(
    name: "Geely",
    brand: "assets/cars/geely.svg",
  ),
  User(
    name: "Honda",
    brand: "assets/cars/honda.svg",
  ),
  User(
    name: "Hyundai",
    brand: "assets/cars/hyundai.svg",
  ),
  User(
    name: "Isuzu",
    brand: "assets/cars/isuzu.svg",
  ),
  User(
    name: "Lexus",
    brand: "assets/cars/lexus.svg",
  ),
  User(
    name: "Mazda",
    brand: "assets/cars/mazda.svg",
  ),
  User(
    name: "Mercedes",
    brand: "assets/cars/mercedes.svg",
  ),
  User(
    name: "Mitsubishi",
    brand: "assets/cars/mitsubishi.svg",
  ),
  User(
    name: "Nissan",
    brand: "assets/cars/nissan.svg",
  ),
  User(
    name: "Suzuki",
    brand: "assets/cars/suzuki.svg",
  ),
  User(
    name: "Toyota",
    brand: "assets/cars/toyota.svg",
  ),
  User(
    name: "Volkswagen",
    brand: "assets/cars/volkswagen.svg",
  ),
];

class BrandName extends StatelessWidget {
  const BrandName({
    Key? key,
    required this.brand,
    required this.title,
  }) : super(key: key);
  final String brand;
  final String? title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .1,
      width: size.width * .27,
      padding: const EdgeInsets.only(right: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.white24),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          brand,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
