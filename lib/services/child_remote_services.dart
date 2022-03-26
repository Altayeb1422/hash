import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/child.dart';


class ChildRemoteService
{

  Future postParentId(id) async {
    var client = http.Client();
    var res = await client.post(Uri.parse("http://192.168.237.221/easy/Childs.php"), body:id);

    if(res.statusCode == 200){
      debugPrint("Data posted successfully");
      print(res.body);
      json.decode(res.body).toString();
    }else{
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }

  Future<List<FilterTabs>?> getFilterTabs() async
  {
    var client = http.Client();
    var response = await client.get(Uri.parse("http://192.168.237.221/easy/Childs.php"));
    if(response.statusCode == 200)
    {
      var jason = response.body;
      return filterTabsFromJson(jason);
    }
  }
}