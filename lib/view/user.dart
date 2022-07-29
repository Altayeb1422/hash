import 'package:flutter/material.dart';


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
        title: Text("Profile"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .20,
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(blurRadius: 7.0, color: Color(0xffa7a9af))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage("assets/user.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // "assets/user.svg",
                    // height:size.height * .20,
                    // width: size.width * .20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        "Altayeb",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Yousif",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),

                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Edit profile",
                            style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25),
              child: Text(
                "Dashboard",
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            OptionsCard(title: 'Calendar', icon: Icon(Icons.calendar_month_outlined, color: Colors.white,), color: Colors.green, onTap: () {  },),
            OptionsCard(title: 'Settings', icon: Icon(Icons.settings_outlined,color: Colors.white,), color: Colors.orange, onTap: () {  },),
            OptionsCard(title: 'Help', icon: Icon(Icons.help_outline,color: Colors.white,), color: Colors.blue, onTap: () {  },),
            OptionsCard(title: 'Contact Us', icon: Icon(Icons.call_outlined,color: Colors.white,), color: Colors.grey, onTap: () {  },),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25),
              child: Text(
                "My Account",
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key,
    required this.icon,
    required this.title, required this.color, required this.onTap,
  }) : super(key: key);
  final dynamic icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 28,
              minRadius: 28,
              foregroundColor: Colors.green,
              backgroundColor: color,
              child: Container(
                child: icon,
              ),
            ),
            SizedBox(width: 25,),
            Text(title, style:TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color:Colors.grey.withOpacity(0.6) ,size: 22,)
          ],
        ),
      ),
    );
  }
}
