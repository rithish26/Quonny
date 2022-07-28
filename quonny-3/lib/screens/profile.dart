import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quonny_quonnect/screens/changeindustry.dart';
import 'package:quonny_quonnect/screens/notifications.dart';
import 'package:quonny_quonnect/screens/paymentdetails.dart';
import 'package:quonny_quonnect/screens/revealrequests.dart';
import 'package:quonny_quonnect/screens/security.dart';
import 'package:quonny_quonnect/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'editpersonaldetails.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String avatar_src = 'assets/images/avatars/avatar5.png';
  List<String> avatar_list = [
    "assets/images/avatars/avatar1.png",
    "assets/images/avatars/avatar2.png",
    "assets/images/avatars/avatar3.png",
    "assets/images/avatars/avatar4.png",
    "assets/images/avatars/avatar5.png"
  ];
  bool is_avatar_selected = false;
  bool isChecked = false;
  String avatar = "";
  String name = "";
  String nickname = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        setState(() {
          avatar = value['avatar'];
          name = value['name'];
          nickname = value['nickname'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Profile settings"
                              .text
                              .semiBold
                              .fontFamily(GoogleFonts.openSans().fontFamily!)
                              .textStyle(TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900))
                              .make()
                              .pLTRB(20, 20, 20, 0),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.share,
                                    color: Color(0xFFAAAAAA),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Notifications()),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.notifications,
                                    color: Color(0xFFAAAAAA),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          Colors.black.withOpacity(0.2), // red as border color
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Image.asset(
                            avatar,
                            fit: BoxFit.fitWidth,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        /*  onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0)),
                                  color: Colors.white,
                                ),
                                height: 300,
                                child: GridView.count(
                                  crossAxisCount: 5,
                                  // Generate 100 widgets that display their index in the List.
                                  children: List.generate(15, (index) {
                                    return IconButton(
                                        onPressed: () {
                                          setState(() {
                                            avatar_src = avatar_list[index % 5];
                                            is_avatar_selected = true;
                                          });
                                        },
                                        icon: Image.asset(
                                            avatar_list[index % 5]));
                                  }),
                                ),
                              );
                            },
                          );
                        }, */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 20, top: 30, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 5.0, left: 4),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 0.0, left: 4),
                            child: Text(
                              nickname,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 15),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonalDetails()),
                              );
                            },
                            child: Text(
                              'Edit personal details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('Change Industry',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Changeindustry()),
                    );
                  },
                ),
              ),
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('Security',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Security()),
                    );
                  },
                ),
              ),
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Container(
                        child: Text('Notifications',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Switch(
                  inactiveThumbColor: Colors.deepOrange,
                  activeColor: Colors.deepOrange,
                  activeTrackColor: Colors.deepOrange,
                  inactiveTrackColor: Colors.grey,
                  value: isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
              ],
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('Terms of use',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('Privacy policy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('Payment details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    /*  /*  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Paymentdetails()), */
                    ); */
                  },
                ),
              ),
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('Reveal requests',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Revealrequests()));
                  },
                ),
              ),
            ),
            Container(
                height: 1,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    child: Text('LogOut',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    final user = FirebaseAuth.instance.currentUser;
                    print(user);
                    Navigator.pushReplacementNamed(context, "/");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
