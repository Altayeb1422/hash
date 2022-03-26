import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userInfo(String userName, String address, String phone,
    String birthday, String email, String gender) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Personal Information');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  auth.currentUser!.email.toString();
  auth.currentUser?.emailVerified;
  users.add({
    'Name': userName,
    'uid': uid,
    'address': address,
    'phone': phone,
    'birthday': birthday,
    'email': email,
    'gender': gender
  });
  return;
}
Future<void> socialInfo() async {
  CollectionReference users = FirebaseFirestore.instance.collection('Personal Information Social');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  String email = auth.currentUser!.email.toString();
  String userName =auth.currentUser!.displayName.toString();
  String phone = auth.currentUser!.phoneNumber.toString();
  auth.currentUser?.emailVerified;
  users.add({
    'Name': userName,
    'uid': uid,
    'email': email,
    'phone': phone
  });
  return;
}
Future<void> accountInfo(String userName, String password, String Q1,
    String Q2, String Q3, String Ans1, String Ans2, String Ans3) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Personal Information');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  auth.currentUser!.email.toString();
  auth.currentUser?.emailVerified;
  users.add({
    'Name': userName,
    'uid': uid,
    'password': password,
    'question 1': Q1,
    'Answer 1': Ans1,
    'question 2': Q2,
    'Answer 2': Ans2,
    'question 3': Q3,
    'Answer 3': Ans3,
  });
  return;
}
Future<void> loginSession(
  String? login,
  String? logout,
) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Login Logs');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  String logId = auth.currentUser!.email.toString();
  await users.add({
    'uid': uid,
    'loginTime': login,
    "LogoutTime": logout,
    'logId': logId,
  });
  return;
}
