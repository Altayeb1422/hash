import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hash/model/facebook_sign_in.dart';
import 'package:hash/model/firebase_add_data.dart';
import 'package:hash/model/google_sign_in.dart';
import 'package:hash/model/validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


TextEditingController fullNameController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController birthDayController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController firstQuestionController = TextEditingController();
TextEditingController secondQuestionController = TextEditingController();
TextEditingController thirdQuestionController = TextEditingController();
TextEditingController firstAnswerController = TextEditingController();
TextEditingController secondAnswerController = TextEditingController();
TextEditingController thirdAnswerController = TextEditingController();

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var myusername,
      mypassword,
      myemail,
      mybirthday,
      myadress,
      mygender,
      myphone,
      myFullName,
      firstQ,
      secondQ,
      thirdQ,
      firstAns,
      secondAns,
      thirdAnsw;
  GlobalKey<FormState> formstate = GlobalKey();
  singUp() async {
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
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('The password provided is too weak.'),
            ),
          ).show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('The account already exists for that email.'),
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

  String userEmail = "";
  @override
  void initState() {
    birthDayController.text = "";
    super.initState();
  }
  String initialCountry = 'SD';
  PhoneNumber number = PhoneNumber(isoCode: 'SD');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/register_back.jpg',
                ),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height*.07,
                        ),
                        Text(
                          "register",
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        TextFormField(
                            onSaved: (val){
                              myFullName = val;
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) => rangeValidator(value!),
                            controller: fullNameController,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "Input your full name",
                              fillColor:const Color(0xfff4f4f4),
                              filled: true,
                              prefixIcon: const Icon(Icons.person, color: Color(0xff666666),),
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Cairo',
                                  fontSize: 18),
                            )),
                         SizedBox(
                          height: size.height*.03,
                        ),

                        TextFormField(
                          onSaved: (val) {
                            myemail = val;
                          },
                          validator: (value) {
                            validateEmail(value);
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          decoration:  InputDecoration(
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon:
                            const Icon(Icons.email,color: Color(0xff666666),), //icon of text field
                            hintText: "Enter Email adress",
                            fillColor: const Color(0xfff4f4f4),
                            filled: true,
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                                fontSize: 15),
                          ),

                        ),
                        SizedBox(
                          height: size.height*.03,
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
                              color: Colors.white,
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
                          height: size.height*.03,
                        ),

                        TextFormField(
                            onSaved: (val){
                              mypassword =val;
                            },
                            validator: (val){
                              if(val!.length < 5){
                                return "password can not be less than 5 charchters";
                              } if(val.length > 15){
                                return "password can not be more than 15 charchters";
                              }
                              return null;
                            },
                            obscureText: _obscureText,
                            controller: passwordController,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "password",
                              prefixIcon: const Icon(Icons.lock,color: Color(0xff666666),),
                              fillColor: const Color(0xfff4f4f4),
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _toggle();
                                }, icon: _obscureText? const Icon(Icons.visibility_off,color: Color(0xff666666),):const Icon(Icons.visibility,color: Color(0xff666666),),
                              ),
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Cairo',
                                  fontSize: 18),
                            )),

                        SizedBox(
                          height: size.height*.03,
                        ),
                        MaterialButton(
                            onPressed: () async {
                              var user = await singUp();
                              if (user != null) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "verify", (route) => false);
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
                                  "register",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const Expanded(
                                child: Divider(
                                  // thickness of the line
                                  indent: 20, // empty space to the leading edge of divider.
                                  endIndent: 20, // empty space to the trailing edge of the divider.
                                  color: Colors.white, // The color to use when painting the line.
                                  height: 5, // The divider's height extent.
                                ),
                              ),
                              Center(
                                child: Text("or", style:const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'Cairo') ,),
                              ),
                              const Expanded(
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
                          height: size.height*.03,
                        ),
                        Center(
                          child: SignInButton(
                            Buttons.FacebookNew,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            text: "Facebook",
                            elevation: 26,
                            padding: const EdgeInsets.all(8.0),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ));
                              await signInWithFacebook();
                              await socialInfo();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "homepage", (route) => false);

                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        Center(
                          child: SignInButton(
                            Buttons.Google,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            text: "Google",
                            elevation: 26,
                            padding: const EdgeInsets.all(8.0),
                            onPressed: () async {

                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ));
                             await googleSignup(context);
                              await socialInfo();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "homepage", (route) => false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



}


