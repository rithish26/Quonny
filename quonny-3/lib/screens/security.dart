import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  @override
  void initState() {
    super.initState();
    String userid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('Security')
        .doc(userid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        setState(() {
          isChecked1 = value['mobile'];
          isChecked2 = value['email'];
          isChecked4 = value['profile_pic'];
          isChecked3 = value['about'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.18,
            ),
            Text(
              'Security',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        "To ensure your privacy and security, what all data would you like to reveal if a user requests to see your profile ?"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(fontSize: 16))
                            .make()
                            .p(20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text('Mobile number',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.deepOrange,
                        activeColor: Colors.deepOrange,
                        activeTrackColor: Colors.deepOrange,
                        inactiveTrackColor: Colors.grey,
                        value: isChecked1,
                        onChanged: (bool value) {
                          setState(() {
                            isChecked1 = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text('Email ID',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.deepOrange,
                        activeColor: Colors.deepOrange,
                        activeTrackColor: Colors.deepOrange,
                        inactiveTrackColor: Colors.grey,
                        value: isChecked2,
                        onChanged: (bool value) {
                          setState(() {
                            isChecked2 = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text('About you',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.deepOrange,
                        activeColor: Colors.deepOrange,
                        activeTrackColor: Colors.deepOrange,
                        inactiveTrackColor: Colors.grey,
                        value: isChecked3,
                        onChanged: (bool value) {
                          setState(() {
                            isChecked3 = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, bottom: 17, top: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text('Profile pic',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.deepOrange,
                        activeColor: Colors.deepOrange,
                        activeTrackColor: Colors.deepOrange,
                        inactiveTrackColor: Colors.grey,
                        value: isChecked4,
                        onChanged: (bool value) {
                          setState(() {
                            isChecked4 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, double.infinity)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                    ),
                    onPressed: () {
                      final user = FirebaseAuth.instance.currentUser!.uid;
                      final r = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user)
                          .collection('Security')
                          .doc(user);
                      r.update({
                        'id': r.id,
                        'mobile': isChecked1,
                        'email': isChecked2,
                        'about': isChecked3,
                        'profile_pic': isChecked4,
                        'date_modified': new DateTime.now()
                      });
                      Navigator.pop(context);
                    },
                    child: "DONE".text.xl.make(),
                  ).p(20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
