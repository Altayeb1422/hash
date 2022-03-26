import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formstate = GlobalKey();
  final emailController = TextEditingController();


  Future resetPassword()async{
    var FormData = formstate.currentState;
    if(FormData!.validate()){
      FormData.save();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=> Center(child: CircularProgressIndicator(),)
      );
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      } on FirebaseAuthException catch(e){
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('No user found for that email.'),
            ),
          ).show();
        }
      }
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Form(
        key: formstate,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Recive an Email to reset your password"),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: emailController,
                      validator: (value) => validateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 22),
                      decoration: InputDecoration(
                        hintText: "email",
                        fillColor: Colors.transparent,
                        filled: true,
                        prefixIcon: const Icon(Icons.email),
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Cairo',
                            fontSize: 18),
                      )),
                ),
                const SizedBox(height: 20,),
                MaterialButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context)=> const Center(child: CircularProgressIndicator(),)
                      );
                      await resetPassword();
                      Navigator.pop(context);
                      },
                    elevation: 26,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: const Padding(
                      padding:  EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Send Email",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }


String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}}