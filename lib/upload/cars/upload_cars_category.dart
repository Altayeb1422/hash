import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/upload/cars/upload_cars_type.dart';
import '../../model/child.dart';
import '../../services/child_remote_services.dart';
import '../../widget/filters_card_widget.dart';

class UploadCarsForSaleCategory extends StatefulWidget {
  const UploadCarsForSaleCategory({Key? key, this.select1, this.select1Name}) : super(key: key);
  final dynamic select1;
  final dynamic select1Name;
  @override
  _UploadCarsForSaleCategoryState createState() =>
      _UploadCarsForSaleCategoryState();
}

class _UploadCarsForSaleCategoryState
    extends State<UploadCarsForSaleCategory> {
  List<FilterTabs>? filterTabs;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getChildData();
  }

  getChildData() async {
    filterTabs = await ChildRemoteService().postParentId(widget.select1);
    if (filterTabs != null) {
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
                return CardWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UploadCarsForSaleTypes(
                              select2: filterTabs![index].id,select2Name:filterTabs![index].name,
                              select1: widget.select1,
                            )));
                  },
                  icon: Icons.directions_car,
                  title: filterTabs![index].name,
                  subtitle: "BYD",
                );
              },
            ),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ));
  }
}
