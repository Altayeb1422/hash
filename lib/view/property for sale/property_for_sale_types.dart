import 'package:flutter/material.dart';
import 'package:hash/view/property%20for%20sale/residential/resdiential_for_sale.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../model/child.dart';
import '../../services/child_remote_services.dart';
import '../../widget/filters_card_widget.dart';


class PropertyForSaleTypes extends StatefulWidget {
  const PropertyForSaleTypes({Key? key, required this.parentId}) : super(key: key);
  final dynamic parentId ;
  @override
  _PropertyForSaleTypesState createState() => _PropertyForSaleTypesState();
}


class _PropertyForSaleTypesState extends State<PropertyForSaleTypes> {
  List<FilterTabs>? filterTabs;
  var isLoaded = false;

  @override
  void initState()  {
    super.initState();
      getChildData();
  }

  getChildData() async {
    filterTabs = await ChildRemoteService().postParentId(widget.parentId);
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
          icon: const Icon(Icons.arrow_back, color:  Colors.black,),
          onPressed: (){
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
              return
              CardWidget(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const ResdientialForSale()));}, icon: Icons.home, title: filterTabs![index].name, subtitle: 'apart'.tr(),);
            },
          ),
          replacement: const Center(child: CircularProgressIndicator(),),
        ),
      ),
    );

  }
}
