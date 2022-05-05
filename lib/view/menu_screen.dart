import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restart_app/restart_app.dart';
import '../main.dart';
import '../menu_items.dart';
import '../model/firebase_add_data.dart';
import '../model/menu_items_class.dart';
import 'home_page.dart';
import 'intro_screen.dart';
import 'login_screen.dart';

class MenuPage extends StatefulWidget {
  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(
                flex: 2,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hi, Altayeb Yousif'),
                  )
                ],
              ),
              const Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              const Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () async {
                        await EasyLocalization.of(context)!.setLocale(Locale('ar'));
                        print(Intl.getCurrentLocale());
                        Phoenix.rebirth(context);
                        //setState(()  {});
                        //Restart.restartApp();
                        print(Intl.getCurrentLocale());
                        print(context.locale);
                        ZoomDrawer.of(context)!.toggle();
                      },
                      child: const Text(
                        'العربية',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () async {
                        await EasyLocalization.of(context)!.setLocale(Locale("en"));
                        print(Intl.getCurrentLocale());
                        Phoenix.rebirth(context);
                        //setState(() async {});
                        //Restart.restartApp();
                        print(Intl.getCurrentLocale());
                        print(context.locale);
                        ZoomDrawer.of(context)!.toggle();
                      },
                      child: const Text(
                        'English',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.deepOrange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  label:  Text("log out".tr()),
                  onPressed: () async {
                    logout;
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ));
                    await loginSession(
                      login.toString(),
                      logout.toString(),
                    );
                    await FacebookAuth.i.logOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IntroScreen()));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) {
    return ListTileTheme(
      selectedColor: Colors.deepOrange.withOpacity(0.7),
      selectedTileColor: Colors.deepOrange,
      child: ListTile(
        selectedTileColor: Colors.black12,
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => widget.onSelectedItem(item),
      ),
    );
  }
}
