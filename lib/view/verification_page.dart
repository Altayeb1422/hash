import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hash/model/firebase_add_data.dart';
import 'package:hash/view/login_screen.dart';
import 'package:hash/view/registeration_screen.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
   timer = Timer.periodic(const Duration(seconds: 5), (timer) {
     checkEmailVerified();
    });
    super.initState();
  }
  Future<void> checkEmailVerified () async{
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      await userInfo(
        fullNameController.text,
        addressController.text,
        phoneController.text,
        birthDayController.text,
        emailController.text,
        genderController.text,
      );
      Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
    }
    Login;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'An Email has been sent to the user ${user.email}, please verify'
              ),
            ],
          ),
        ),
      ),
    );
  }
}
