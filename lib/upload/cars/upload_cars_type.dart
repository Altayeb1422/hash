import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';
import '../../model/child.dart';
import '../../services/child_remote_services.dart';
import '../../view/cars_upload_filter_page.dart';
import '../../view/motors/CarCardWidget.dart';

class UploadCarsForSaleTypes extends StatefulWidget {
  const UploadCarsForSaleTypes({Key? key, required this.select1, required this.select2, this.select2Name}) : super(key: key);
  final dynamic select1;
  final dynamic select2;
  final dynamic select2Name;
  @override
  _UploadCarsForSaleTypesState createState() =>
      _UploadCarsForSaleTypesState();
}

class _UploadCarsForSaleTypesState extends State<UploadCarsForSaleTypes> {
  List<FilterTabs>? filterTabs;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getChildData();
  }

  getChildData() async {
    filterTabs = await ChildRemoteService().postParentId(widget.select2);
    if (filterTabs != null) {
      setState(() {
        isLoaded = true;
      });
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: Visibility(
            visible: isLoaded,
            child: ListView.builder(
              itemCount: filterTabs?.length,
              itemBuilder: (BuildContext context, int index) {
                return CarsCardWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>  CarsUploadFilterPage(select2:widget.select1, select3: widget.select2, select4: filterTabs![index].id, select2Name: widget.select2Name, select1Name: filterTabs![index].name,)));
                  },
                  title: filterTabs![index].name, logo: filterTabs![index].icon,
                );
              },
            ),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
