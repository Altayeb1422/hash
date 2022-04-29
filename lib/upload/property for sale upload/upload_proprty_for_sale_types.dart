import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/widget/filters_card_widget_no_sub.dart';

import '../../model/child.dart';
import '../../services/child_remote_services.dart';
import '../../view/filter_page_for_the_rest.dart';

class UploadPropertyForSaleTypes extends StatefulWidget {
  const UploadPropertyForSaleTypes({Key? key, required this.select1, required this.select2, this.select2Name}) : super(key: key);
  final dynamic select1;
  final dynamic select2;
  final dynamic select2Name;
  @override
  _UploadPropertyForSaleTypesState createState() =>
      _UploadPropertyForSaleTypesState();
}

class _UploadPropertyForSaleTypesState extends State<UploadPropertyForSaleTypes> {
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
                return CardWidgetNoSub(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>  FilterPageTheRest(select2:widget.select1, select3: widget.select2, select4: filterTabs![index].id, select1Name: widget.select2Name, select2Name: filterTabs![index].name,)));
                  },
                  title: filterTabs![index].name,
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
