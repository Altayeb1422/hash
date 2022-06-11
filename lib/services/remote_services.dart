import 'package:flutter/cupertino.dart';
import 'package:hash/model/root.dart';
import 'package:http/http.dart' as http;
import '../model/root.dart';


class RemoteService
{

  Future postParentId(id) async {
    var res = await http.post(Uri.parse("http://192.168.1.41/easy/Childs.php"), body:id);
    if(res.statusCode == 200){
      debugPrint("Data posted successfully");
    }else{
      debugPrint("Something went wrong! Status Code is: ${res.statusCode}");
    }
  }

  Future<List<Tabs>?> getTabs() async
  {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.1.41/easy/Root.php");
    var response = await client.get(uri);
    if(response.statusCode == 200)
      {
        var json = response.body;
        return tabsFromJson(json);
      }

  }
}