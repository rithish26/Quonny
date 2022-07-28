import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:quonny_quonnect/screens/confirmrequest.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'notifications.dart';

class Calander extends StatefulWidget {
  const Calander({Key? key}) : super(key: key);

  @override
  _CalanderState createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  bool isSearching = false;

  String valuee = "4:00 am-6:00 am";
  List<String> professional_chips = [
    'Dating',
    "Friendship",
    "Young guitarist",
    "Painter",
    "Mountaineer",
    "Cyclist",
    "Dancer",
    "Film director",
    "Engineer",
    "Random"
  ];
  String token = "";
  String channelname = "";
  int? _value2 = 1;
  static const _chars = 'abcdefghijklmnopqrstuvwxyz';
  Random _rnd = Random();
  Future<void> getToken() async {
    print('channelname:');
    print(channelname);
    String link =
        "https://agora-node-tokenserver.devarithish.repl.co/access_token?channelName=$channelname";
    print(link);

    Response _response = await get(Uri.parse(link));
    Map data = jsonDecode(_response.body);
    print("hello");
    print(data["token"]);
    setState(() {
      token = data["token"];
    });
    /*  _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: "7f82996573ee4635aa535bd251dd9db3",
          tokenUrl:
              "https://agora-node-tokenserver.devarithish.repl.co/access_token?channelName=test",
          channelName: "Test",
        ),
        enabledPermission: [Permission.camera, Permission.microphone]);
    Future.delayed(Duration(seconds: 1)).then(
      (value) => setState(() => _loading = false),
    ); */
  }

  void getRandomString(int length) {
    String p = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    setState(() {
      channelname = p;
    });
  }

  int number = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          isSearching = false;
        });
        return false;
      },
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(140),
              child: new AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: SafeArea(
                  child: new Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "Schedule call"
                                    .text
                                    .bold
                                    .fontFamily(
                                        GoogleFonts.openSans().fontFamily!)
                                    .textStyle(TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900))
                                    .make()
                                    .p(20),
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
                                  ],
                                )
                              ],
                            ),
                            TabBar(
                                indicatorColor: Colors.deepOrange,
                                unselectedLabelColor: Color(0xFFAAAAAA),
                                labelColor: Colors.deepOrange,
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                tabs: <Widget>[
                                  Tab(
                                      child: "set a call"
                                          .text
                                          .bold
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make()),
                                  Tab(
                                      child:
                                          "call match${number == 0 ? "" : (number)}"
                                              .text
                                              .bold
                                              .center
                                              .fontFamily(GoogleFonts.openSans()
                                                  .fontFamily!)
                                              .make()),
                                  Tab(
                                      child: "history"
                                          .text
                                          .bold
                                          .center
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make()),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                !isSearching
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              Text(
                                "Call scheduled",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                              "We will notify you whenever there's a match available in the scheduled time. You can edit it anytime you wish to"
                                  .text
                                  .center
                                  .fontFamily(
                                      GoogleFonts.openSans().fontFamily!)
                                  .textStyle(TextStyle(fontSize: 16))
                                  .make()
                                  .pLTRB(40, 20, 40, 20),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.deepOrange)),
                                    onPressed: () {
                                      setState(() {
                                        isSearching = true;
                                      });
                                    },
                                    child: "EDIT"
                                        .text
                                        .bold
                                        .textStyle(TextStyle(fontSize: 18))
                                        .white
                                        .make()),
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: SingleChildScrollView(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Time of availability',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10,
                                          bottom: 40,
                                          top: 10),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            elevation: 0,
                                            dropdownColor: Color(0xFFF5F5F5),
                                            hint: Text('$valuee'),
                                            items: <String>[
                                              '12:00 am-1:00 am',
                                              '1:00 am-2:00 am',
                                              '2:00 am-3:00 am',
                                              '3:00 am-4:00 am',
                                              '4:00 am-5:00 am',
                                              '5:00 am-6:00 am',
                                              '6:00 am-7:00 am',
                                              '7:00 am-8:00 am',
                                              '8:00 am-9:00 am',
                                              '9:00 am-10:00 am',
                                              '10:00 am-11:00 am',
                                              '11:00 am-12:00 pm',
                                              '12:00 pm-1:00 pm',
                                              '1:00 pm-2:00 pm',
                                              '2:00 pm-3:00 pm',
                                              '3:00 pm-4:00 pm',
                                              '5:00 pm-6:00 pm',
                                              '7:00 pm-8:00 pm',
                                              '8:00 pm-9:00 pm',
                                              '9:00 pm-10:00 pm',
                                              '10:00 pm-11:00 pm',
                                              '11:00 pm-12:00 am',
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            onChanged: (valueee) {
                                              setState(() {
                                                valuee = valueee!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Preferred catagories',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      children: List<Widget>.generate(
                                        10,
                                        (int index) {
                                          return ChoiceChip(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Color(0xFFCECECE),
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            backgroundColor: Color(0xFFF5F5F5),
                                            selectedColor: Colors.deepOrange,
                                            label: Text(
                                              professional_chips[index],
                                            ),
                                            labelStyle: TextStyle(
                                                color: _value2 == index
                                                    ? Colors.white
                                                    : Color(0xFF919191),
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    GoogleFonts.openSans()
                                                        .fontFamily),
                                            selected: _value2 == index,
                                            onSelected: (bool selected) {
                                              setState(() {
                                                _value2 =
                                                    selected ? index : null;
                                              });
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(double.infinity,
                                              double.infinity)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepOrange),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.black),
                                      // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isSearching = false;
                                      });
                                      FirebaseFirestore.instance
                                          .collection('Scheduled Calls')
                                          .where('isfull', isEqualTo: 'no')
                                          .where('time frame',
                                              isEqualTo: valuee)
                                          .get()
                                          .then((value) async {
                                        if (value.docs.isEmpty) {
                                          final refe = FirebaseFirestore
                                              .instance
                                              .collection('Scheduled Calls')
                                              .doc();
                                          String url = "";
                                          String name = "";
                                          String country = "";
                                          String avatar = "";
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get()
                                              .then((value) {
                                            setState(() {
                                              name = value['nickname'];
                                              country = value['country'];
                                              avatar = value['avatar'];
                                            });
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('image')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get()
                                              .then((value) {
                                            setState(() {
                                              url = value['url'];
                                            });
                                          });

                                          await refe.set({
                                            'id': refe.id,
                                            'schedulername': name,
                                            'scheduler user': FirebaseAuth
                                                .instance.currentUser!.uid,
                                            'scheduler location': country,
                                            'scheduler image': url,
                                            'isfull': 'no',
                                            'time frame': valuee,
                                            'date created': DateTime.now(),
                                            'avatar': avatar,
                                          });
                                        } else {
                                          String url = "";
                                          String name = "";
                                          String country = "";
                                          String avatar = "";
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get()
                                              .then((value) {
                                            name = value['nickname'];
                                            country = value['country'];
                                            avatar = value['avatar'];
                                          });
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('image')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get()
                                              .then((value) {
                                            url = value['url'];
                                          });

                                          for (int i = 0;
                                              i < value.docs.length;
                                              i++) {
                                            if (await FirebaseAuth.instance
                                                    .currentUser!.uid ==
                                                value.docs[i]
                                                    .data()['scheduler user']) {
                                              continue;
                                            }
                                            print(value.docs[i].data()['id']);
                                            final refe = FirebaseFirestore
                                                .instance
                                                .collection('Scheduled Calls')
                                                .doc(
                                                    value.docs[i].data()['id']);
                                            await refe
                                                .update({"isfull": "yes"});
                                            getRandomString(5);
                                            await getToken();
                                            final user1 =
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection(
                                                        'scheduled calls')
                                                    .doc()
                                                    .set({
                                              'matcheduser': value.docs[i]
                                                  .data()['schedulername'],
                                              'matchedlocation': value.docs[i]
                                                  .data()['scheduler location'],
                                              'matcheduserid': value.docs[i]
                                                  .data()['scheduler user'],
                                              'matchedurl': value.docs[i]
                                                  .data()['scheduler image'],
                                              'timeframe': value.docs[i]
                                                  .data()['time frame'],
                                              'channelname': channelname,
                                              'token': token,
                                              'avatar': value.docs[i]
                                                  .data()['avatar'],
                                            });
                                            final user2 =
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(value.docs[i].data()[
                                                        'scheduler user'])
                                                    .collection(
                                                        'scheduled calls')
                                                    .doc()
                                                    .set({
                                              'matcheduser': name,
                                              'matchedlocation': country,
                                              'matcheduserid': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'matchedurl': value.docs[i]
                                                  .data()['scheduler image'],
                                              'timeframe': value.docs[i]
                                                  .data()['time frame'],
                                              'channelname': channelname,
                                              'token': token,
                                              'avatar': avatar,
                                            });

                                            break;
                                          }
                                        }
                                      });
                                    },
                                    child: "SCHEDULE CALL".text.xl.make(),
                                  ).p(20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('scheduled calls')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final doc = snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100))),
                                                child: Image.asset(
                                                  doc['avatar'],
                                                  fit: BoxFit.fitWidth,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.012,
                                              ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(doc['matcheduser'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                            doc['matchedlocation'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                            )),
                                                      ],
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                          Text(
                                            doc['timeframe'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                          );
                        }),
                    /*  Container(
                        child: Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(bottom: 20),
                        primary: true,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.012,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('miss.darla',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                  ),
                                                  Text('China',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      )),
                                                ],
                                              ),
                                            ]),
                                      ],
                                    ),
                                    Text(
                                      '05:00 am',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.012,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('miss.darla',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                  ),
                                                  Text('China',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      )),
                                                ],
                                              ),
                                            ]),
                                      ],
                                    ),
                                    Text(
                                      '05:45 am',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.012,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('miss.darla',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                  ),
                                                  Text('China',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      )),
                                                ],
                                              ),
                                            ]),
                                      ],
                                    ),
                                    Text(
                                      '07:20 am',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.012,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('miss.darla',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                  ),
                                                  Text('China',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      )),
                                                ],
                                              ),
                                            ]),
                                      ],
                                    ),
                                    Text(
                                      '07:22 am',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )), */
                  ],
                ),
                Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Calls')
                            .where('myid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final doc = snapshot.data!.docs[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100))),
                                                child: Image.asset(
                                                  doc['avatar'],
                                                  fit: BoxFit.fitWidth,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.012,
                                              ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(doc['hisname'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    Text(
                                                      doc['hiscountry'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ]),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                              ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      DateFormat('dd MMM yy')
                                                          .format(
                                                              (doc['dateCreated']
                                                                      as Timestamp)
                                                                  .toDate()),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      'Last called',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    _buildPopupDialog(context,
                                                        "Not verified mail id"),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.deepOrange,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                          );
                        }),
                    /*  Container(
                      child: Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 20),
                          primary: true,
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialog(context,
                                                    "Not verified mail id"),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.deepOrange,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('miss.darla',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('China',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('19 oct\'21',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text('Last called',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    )),
                                              ]),
                                        ],
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), */
                  ],
                ),
              ],
            ),
          )),
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
