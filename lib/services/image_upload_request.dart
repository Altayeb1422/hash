import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hash/view/property_upload_filter_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';


Future uploadmultipleimage(File img) async {
  var uri = Uri.parse("http://192.168.15.116/easy/upload_file.php"); //sending post request with header data

  http.MultipartRequest request = http.MultipartRequest('POST', uri,);
  //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
  List<MultipartFile> newList = [];
  File imageFile = File(img.path);
  var stream =
  http.ByteStream(imageFile.openRead())..cast();
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile("file",stream, length,
      filename: basename(imageFile.path,));
  print(imageFile.path);
  newList.add(multipartFile);
  request.files.addAll(newList);
  print(newList);
  var response = await request.send();
  await postImagesIds();
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

postImagesIds() async {
  final uri = "http://192.168.15.116/easy/upload_file.php";
  http.Response response = await http.post(
    Uri.parse(uri),
    body: {"Ads_Id": adsId.toString(),"Client_ID":"hi".toString()},
  );
  if (response.statusCode == 200) {
    //showa your outputs
    print(adsId.toString());
  } else {
    print("Error ${response.statusCode}");
  }
}