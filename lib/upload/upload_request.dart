// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class upload {
//   Future<void> sendData() async {
//     var res = await http.post(Uri.parse("http://192.168.15.100/easy/insert_ads.php"), body: {
//       "Select2": namectl.text,
//       "Select3": addressctl.text,
//       "Select4": classctl.text,
//
//     }); //sending post request with header data
//
//     if (res.statusCode == 200) {
//       print(res.body);
//       print("Post sucessful"); //print raw response on console
//       var data = json.decode(res.body); //decoding json to array
//     }
//   }
// }