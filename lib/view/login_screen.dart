import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hash/view/forget_password_page.dart';
import 'package:hash/view/registeration_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

DateTime Login = DateTime.now();

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var mypassword, myphone;
  GlobalKey<FormState> formstate = GlobalKey();
  singIn() async {
    var FormData = formstate.currentState;
    if (FormData!.validate()) {
      FormData.save();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: myphone,
          password: mypassword,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('No user found for that email.'),
            ),
          ).show();
        } else if (e.code == 'wrong-password') {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Wrong password provided for that user.'),
            ),
          ).show();
        }
      }
    }
  }


  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final userData = GetStorage();
  String initialCountry = 'SD';
  PhoneNumber number = PhoneNumber(isoCode: 'SD');
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/Login_back.jpg',
                  ),
                ),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 5),
                duration: const Duration(milliseconds: 1000),
                builder: (context, double value, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.1)),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "sing in",
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "get lang",
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                        SizedBox(
                          height: size.height * .07,
                        ),
                        InternationalPhoneNumberInput(
                          cursorColor: Colors.deepOrangeAccent,
                          inputDecoration:   InputDecoration(
                            prefixIconColor: Colors.white,
                            fillColor: const Color(0xfff4f4f4),
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                                fontSize: 18),
                            iconColor: Colors.white70,
                            filled: true,
                            focusColor: Colors.deepOrangeAccent,
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.deepOrange, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never
                          ),

                          initialValue: number,
                          onSaved: (value){
                            myphone = value;
                          },
                          selectorTextStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Cairo',
                              fontSize: 18),
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,

                          ),
                          errorMessage: 'Invalid phone number',
                          textFieldController: phoneController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          onInputChanged: (PhoneNumber value) {  },
                        ),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        TextFormField(
                            onSaved: (val) {
                              mypassword = val;
                            },
                            validator: (val) {
                              if (val!.length < 5) {
                                return "password can not be less than 5 charchters";
                              }
                              if (val.length > 15) {
                                return "password can not be more than 15 charchters";
                              }
                              return null;
                            },
                            obscureText: _obscureText,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                            decoration: InputDecoration(
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.deepOrange, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "password",
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xff666666),
                              ),
                              fillColor: const Color(0xfff4f4f4),
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _toggle();
                                },
                                icon: _obscureText
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Color(0xff666666),
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Color(0xff666666),
                                      ),
                              ),
                              hintStyle: const TextStyle(
                                  color: Color(0xffb1b1b1),
                                  fontFamily: 'Cairo',
                                  fontSize: 18),
                            )),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgetPassword()),
                            );
                          },
                          child: Text(
                            "Forget password",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .025,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            Login;
                            var user = await singIn();
                            if (user != null) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "homepage", (route) => false);
                            }
                          },
                          elevation: 26,
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Sign in",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                               Expanded(
                                 child: Divider(
                                   // thickness of the line
                                  indent: 20, // empty space to the leading edge of divider.
                                  endIndent: 20, // empty space to the trailing edge of the divider.
                                  color: Colors.white, // The color to use when painting the line.
                                  height: 5, // The divider's height extent.
                              ),
                               ),
                              Center(
                                child: Text('Dont have an account?', style:TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'Cairo') ,),
                              ),
                              Expanded(
                                child: Divider(
                                  // thickness of the line
                                  indent: 20, // empty space to the leading edge of divider.
                                  endIndent: 20, // empty space to the trailing edge of the divider.
                                  color: Colors.white, // The color to use when painting the line.
                                  height: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MaterialButton(
                            onPressed: () {
                              Get.to(() => const Register());
                            },
                            elevation: 26,
                            color: Colors.red.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


