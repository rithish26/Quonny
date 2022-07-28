import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quonny_quonnect/screens/viewprofile.dart';
import 'package:velocity_x/velocity_x.dart';

class Confirm extends StatefulWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  bool isChecked = false;
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
              width: MediaQuery.of(context).size.width * 0.13,
            ),
            Text(
              'Confirm Request',
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Image.asset(
                                    'assets/images/avatars/avatar5.png',
                                    fit: BoxFit.fitWidth,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Aryan Yadav',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('@aryan yadav',
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Icon(Icons.reply_outlined, color: Colors.white),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  'assets/images/chip.png',
                                  fit: BoxFit.fitWidth,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Balance',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('2,875 coins',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 40),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text('updated 12 Mar\'21',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffEB7242),
                              Color(0xffEA654E),
                              /*  Color(0xff405DE6),
                Color(0xff5851DB),
                Color(0xff833AB4),
                Color(0xffC13584),
                Color(0xffE1306C),
                Color(0xffFD1D1D),
                Color(0xffF56040),
                Color(0xffF77737),
                Color(0xffFCAF45),
                Color(0xffFFDC80), */
                            ],
                          ),
                          color: Colors.grey[300],
                          boxShadow: [
                            /* BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0), */
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text('Paying For',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text('Profile revealing of user',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('@nick.y',
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text('Total amount',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text('1000 quonny coins',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text(
                              '*incase the request gets rejected, then all the quonny coins will be returned to your wallet within 24hours',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal))),
                    ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Viewprofile()),
                      );
                    },
                    child: "CONFIRM REQUEST".text.xl.make(),
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
