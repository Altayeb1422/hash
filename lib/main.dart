import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hash/local/local_controller.dart';
import 'package:hash/view/drwer_routing_page.dart';
import 'package:hash/view/registeration_screen.dart';
import 'package:hash/view/verification_page.dart';
import 'view/forget_password_page.dart';
import 'view/intro_screen.dart';
import 'view/login_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

bool? isLoggedIn;
List filterId = [];
List filterName = [];

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  var user = FirebaseAuth.instance.currentUser;
  if(user == null){
    isLoggedIn == false;
  }else{
    isLoggedIn == true;
  }
  runApp(
      EasyLocalization(
      path: 'assets/lang',
  supportedLocales: const [
    Locale('en'),
    Locale('ar'),
  ],
  saveLocale: true,
  //fallbackLocale: const Locale('en'),
  child: Phoenix(child: const MyApp())));
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        login;
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocalController controller = Get.put(MyLocalController());
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      navigatorKey: navigatorKey,
      title: 'Hash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        cardColor: const Color(0xfff2f2f2),
      ),
      initialRoute: FirebaseAuth.instance.currentUser != null?"homepage":"homepage",
      home: const IntroScreen(),
      routes: {
        "login": (context) => const SignIn(),
        "signup": (context) => const Register(),
        "homepage": (context) => const ZoomDrawerRoute(),
        "intro": (context) => const IntroScreen(),
        "verify": (context) => const VerificationPage(),
        "forget": (context) => const ForgetPassword(),
      },
    );
  }

}
class RestartWidget extends StatefulWidget {
  const RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}