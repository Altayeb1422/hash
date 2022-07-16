import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/child.dart';


class ChildRemoteService
{

  Future postParentId(id) async {
    var client = http.Client();
    var res = await client.get(Uri.parse("http://192.168.15.124/easy/Childs.php?parentId="+id),);

    if(res.statusCode == 200){
      debugPrint("Data posted successfully");
      print(res.body);
      json.decode(res.body).toString();
      var jason = res.body;
      return filterTabsFromJson(jason);
    }else{
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }

  Future<List<FilterTabs>?> getFilterTabs() async
  {
    var client = http.Client();
    var response = await client.get(Uri.parse("http://192.168.15.124/easy/Childs.php"),);
    if(response.statusCode == 200)
    {
      var jason = response.body;
      return filterTabsFromJson(jason);
    }
  }
}