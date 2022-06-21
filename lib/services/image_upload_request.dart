import 'dart:convert';
import 'dart:io';
import 'package:hash/view/cars_upload_filter_page.dart';
import 'package:hash/view/property_upload_filter_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';



Future uploadMultipleImages(File img) async {

  var uri = Uri.parse("http://192.168.15.122/easy/upload_property_images.php?Ads_Id="+adsId.toString()+"&Client_ID="+89.toString()); //sending post request with header data
  http.MultipartRequest request = http.MultipartRequest('POST', uri,);
  List<MultipartFile> newList = [];
  File imageFile = File(img.path);
  var stream = http.ByteStream(imageFile.openRead())..cast();
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile("file",stream, length, filename: basename(imageFile.path,));
  print(imageFile.path);
  newList.add(multipartFile);
  request.files.addAll(newList);
  print(newList);
  var response = await request.send();
  if (response.statusCode == 200) {
    print("Image Uploaded");
    print(adsId.toString());
  } else {
    print("Upload Failed");
  }
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });

}


Future uploadCarsImages(File img) async {

  var uri = Uri.parse("http://192.168.15.122/easy/upload_cars_images.php?Ads_Id="+carAdsId.toString()+"&Client_ID="+89.toString()); //sending post request with header data
  http.MultipartRequest request = http.MultipartRequest('POST', uri,);
  List<MultipartFile> newList = [];
  File imageFile = File(img.path);
  var stream = http.ByteStream(imageFile.openRead())..cast();
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile("file",stream, length, filename: basename(imageFile.path,));
  print(imageFile.path);
  newList.add(multipartFile);
  request.files.addAll(newList);
  print(newList);
  var response = await request.send();
  if (response.statusCode == 200) {
    print("Image Uploaded");
    print(carAdsId.toString());
  } else {
    print("Upload Failed");
  }
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });

}
