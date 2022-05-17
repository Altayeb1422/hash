import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 25.0, vertical: 15),
              child: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                "assets/user.svg",
                height:size.height * .20,
                width: size.width * .20,
              ),
            ),
            SizedBox(height: 10,),
            Center(child: Text("email.123@gmail.com", style: TextStyle(color: Colors.grey, fontSize: 15),)),
            SizedBox(height: 15,),
            Divider(color: Colors.grey, indent: 40, endIndent: 40,),
            OptionsCard(title: "Edit Profile", icon: Icon(Icons.person),),
            OptionsCard(title: "History", icon: Icon(Icons.history),),
            OptionsCard(title: "Settings", icon: Icon(Icons.settings),),
            OptionsCard(title: "Help", icon: Icon(Icons.help),),
            OptionsCard(title: "Contact us", icon: Icon(Icons.call),),
          ],
        ),
      ),
    );
  }
}

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key, required this.icon, required this.title,
  }) : super(key: key);
  final dynamic icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: Container(
          decoration:
          BoxDecoration(color: Color(0xfff2f2f2),borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            iconColor: Colors.teal,
            textColor: Colors.black,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0,  ),
            leading: icon,
            title: Text(title, style: TextStyle(
              fontSize: 20,
            ),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
