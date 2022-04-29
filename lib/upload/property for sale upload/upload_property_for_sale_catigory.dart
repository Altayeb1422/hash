import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hash/upload/property%20for%20sale%20upload/upload_proprty_for_sale_types.dart';
import '../../model/child.dart';
import '../../services/child_remote_services.dart';
import '../../widget/filters_card_widget.dart';

class UploadPropertyForSaleCategory extends StatefulWidget {
  const UploadPropertyForSaleCategory({Key? key, this.select1, this.select1Name}) : super(key: key);
  final dynamic select1;
  final dynamic select1Name;
  @override
  _UploadPropertyForSaleCategoryState createState() =>
      _UploadPropertyForSaleCategoryState();
}

class _UploadPropertyForSaleCategoryState
    extends State<UploadPropertyForSaleCategory> {
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
                            builder: (_) => UploadPropertyForSaleTypes(
                              select2: filterTabs![index].id,select2Name:filterTabs![index].name,
                              select1: widget.select1,
                            )));
                  },
                  icon: Icons.home,
                  title: filterTabs![index].name,
                  subtitle: 'apart'.tr(),
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
