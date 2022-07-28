import 'package:flutter/material.dart';

import 'confirmrequest.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
            ),
            Text(
              'Notifications',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: ListView(
            primary: true,
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Login reward recieved',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Hurray !! Match found',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/avatars/avatar2.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        /* mainAxisAlignment: MainAxisAlignment.start, */
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Someone viewed your profile',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _buildPopupDialog(context,
                                                          "Not verified mail id"),
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                child: Center(
                                                  child: Text('View Profile',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red)),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.red,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Hurray !! Match found',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Money added to wallet Successfully',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/avatars/avatar3.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        /* mainAxisAlignment: MainAxisAlignment.start, */
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Someone viewed your profile',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                child: Center(
                                                  child: Text('View Profile',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red)),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.red,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 10, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        /* mainAxisAlignment: MainAxisAlignment.start, */
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('New app update !!',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                child: Center(
                                                  child: Text('Update now',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red)),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.red,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Money added to wallet Successfully',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('13 Mar\'21',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              )),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String text) {
  return new AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
    ),
    title: Text('Reveal Profile',
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height * 0.08;
        var width = MediaQuery.of(context).size.width * 2;
        return Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'To reveal this profile you have to pay 1000 quonny coins. Do you want to reveal this profile?',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        );
      },
    ),
    actions: <Widget>[
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Confirm()),
                  );
                },
                child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      border: Border.all(
                        color: Colors.deepOrange,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text('Yes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('NO',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
