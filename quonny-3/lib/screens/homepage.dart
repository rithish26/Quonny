import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quonny_quonnect/cons/dailog_box.dart';
import 'package:quonny_quonnect/src/pages/call.dart';
import 'package:quonny_quonnect/src/pages/index.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart';
import 'notifications.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late AnimationController controller;
  String token = "";
  String channelname = "";
  String w = "Calling the";
  int totalQuoin = 0;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    getTotalQuoin();
    super.initState();
  }

  bool flag = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

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

  // get total coins
  getTotalQuoin() {
    print("jsdjsd");
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        setState(() {
          totalQuoin = value['total_quoin'];
        });
      }
    });
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user?.uid)
    //     .get()
    //     .then((DocumentSnapshot value) {
    //   if (value.exists) {
    //     print("value");
    //     setState(() {
    //       totalQuoin = value['total_quoin'];
    //       print("calltotalcoins==>$totalQuoin");
    //     });
    //   }
    // });
  }

  static const _chars = 'abcdefghijklmnopqrstuvwxyz';
  Random _rnd = Random();

  void getRandomString(int length) {
    String p = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    setState(() {
      channelname = p;
    });
  }

  bool isSearching = false;
  bool isSearchingp = false;
  void showAlertDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 100),
      context: context,
      pageBuilder: (_, __, ___) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              child: SizedBox.expand(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'A user named @cool.abhishek ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Raleway'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'has just requested to reveal your profile. You can hidecertain details if you wish to in Settings',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                await getToken();
                                print('token:');
                                print(token);
                                await _handleCameraAndMic(Permission.camera);
                                await _handleCameraAndMic(
                                    Permission.microphone);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CallPage(
                                      token: token,
                                      channelName: 'test',
                                      role: ClientRole.Broadcaster,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Center(
                                  child: Text('ACCEPT',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange)),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.deepOrange,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 40,
                                width: 50,
                                child: Center(
                                  child: Text('Deny',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    border:
                                        Border.all(color: Colors.deepOrange),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              margin: EdgeInsets.only(bottom: 70, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                              "Hey there,"
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
                                      onPressed: () {
                                        showAlertDialog();
                                      },
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
                                    child: "Casual"
                                        .text
                                        .bold
                                        .fontFamily(
                                            GoogleFonts.openSans().fontFamily!)
                                        .make()),
                                Tab(
                                    child: "Professional"
                                        .text
                                        .bold
                                        .center
                                        .fontFamily(
                                            GoogleFonts.openSans().fontFamily!)
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
                              height: 50,
                            ),
                            Text(
                              "Casual Connect",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            "connect on a 5-min call with people from casual industry"
                                .text
                                .center
                                .fontFamily(GoogleFonts.openSans().fontFamily!)
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepOrange)),
                                onPressed: () {
                                  print("searching");
                                  transection(context, totalQuoin, () {
                                    setState(() {
                                      isSearching = true;
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 1000),
                                        () async {
                                      await _handleCameraAndMic(
                                          Permission.camera);
                                      await _handleCameraAndMic(
                                          Permission.microphone);
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      final ref = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .collection('Status')
                                          .doc(user.uid);
                                      ref.set({
                                        'id': ref.id,
                                        'isproffesional': false,
                                        'isonline': true,
                                      });
                                      FirebaseFirestore.instance
                                          .collection('Rooms')
                                          .where('isfull', isEqualTo: 'no')
                                          .where('isproffesional',
                                              isEqualTo: false)
                                          .get()
                                          .then((value) async {
                                        print("1");
                                        if (value.docs.isEmpty) {
                                          print("not there");
                                          getRandomString(5);
                                          await getToken();

                                          print('token:');
                                          print(token);
                                          print('channelname:');
                                          print(channelname);

                                          final refe = FirebaseFirestore
                                              .instance
                                              .collection('Rooms')
                                              .doc();
                                          /*    String  */
                                          refe.set({
                                            'id': refe.id,
                                            'Token': token,
                                            'isproffesional': false,
                                            'channel name': channelname,
                                            'isfull': 'no',
                                            'incomingid': 'null',
                                            'outgoingid': FirebaseAuth
                                                .instance.currentUser!.uid,
                                          });
                                          setState(() {
                                            w = "Waiting for the";
                                          });
                                          var time = const Duration(seconds: 1);
                                          Timer.periodic(time, (timer) {
                                            if (flag == true) timer.cancel();
                                            print('asdfhsd');
                                            final refee = FirebaseFirestore
                                                .instance
                                                .collection('Rooms')
                                                .doc(refe.id)
                                                .get()
                                                .then((DocumentSnapshot value) {
                                              if (value.exists) {
                                                if (value['isfull'] == 'Yes') {
                                                  print(token);
                                                  print(
                                                      "Coalljoiningchannelname====>$channelname");
                                                  setState(() {
                                                    isSearching = false;
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CallPage(
                                                        reference: refe.id,
                                                        token: token,
                                                        channelName:
                                                            channelname,
                                                        role: ClientRole
                                                            .Broadcaster,
                                                        myid: FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        hisid:
                                                            value['incomingid'],
                                                      ),
                                                    ),
                                                  );
                                                  timer.cancel();
                                                }
                                              }
                                            });
                                          });
                                        } else {
                                          print("helllo");
                                          for (int i = 0;
                                              i < value.docs.length;
                                              i++) {
                                            if (await FirebaseAuth.instance
                                                    .currentUser!.uid ==
                                                value.docs[i]
                                                    .data()['outgoingid']) {
                                              continue;
                                            }
                                            String reference = "";
                                            String incomingid = "";
                                            final refe = FirebaseFirestore
                                                .instance
                                                .collection('Rooms')
                                                .doc(
                                                    value.docs[i].data()['id']);
                                            print(value.docs[i].data()['id']);
                                            print(
                                                value.docs[i].data()['Token']);
                                            print(value.docs[i]
                                                .data()['channel name']);
                                            setState(() {
                                              reference =
                                                  value.docs[i].data()['id'];
                                              token =
                                                  value.docs[i].data()['Token'];
                                              channelname = value.docs[i]
                                                  .data()['channel name'];
                                              incomingid = value.docs[i]
                                                  .data()['outgoingid'];
                                            });

                                            print(refe);
                                            refe.update({
                                              'incomingid': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'isfull': "Yes",
                                            });
                                            print(
                                                value.docs[i].data()['isfull']);
                                            print("..........................");
                                            print(token);
                                            print(channelname);
                                            print("..........................");
                                            setState(() {
                                              isSearching = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CallPage(
                                                  reference: reference,
                                                  channelName: channelname,
                                                  token: token,
                                                  role: ClientRole.Broadcaster,
                                                  myid: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  hisid: incomingid,
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                        }
                                      });
                                    });
                                  });
                                  /*if (totalQuoin < 5) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          popupDailigBox(
                                        context,
                                        "You don't have sufficient quoins, \nDo you want to buy more quoins",
                                      ),
                                    );
                                    print("hello");
                                  } else {
                                    setState(() {
                                      isSearching = true;
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 1000),
                                        () async {
                                      await _handleCameraAndMic(
                                          Permission.camera);
                                      await _handleCameraAndMic(
                                          Permission.microphone);
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      final ref = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .collection('Status')
                                          .doc(user.uid);
                                      ref.set({
                                        'id': ref.id,
                                        'isproffesional': false,
                                        'isonline': true,
                                      });
                                      FirebaseFirestore.instance
                                          .collection('Rooms')
                                          .where('isfull', isEqualTo: 'no')
                                          .where('isproffesional',
                                              isEqualTo: false)
                                          .get()
                                          .then((value) async {
                                        print("1");
                                        if (value.docs.isEmpty) {
                                          print("not there");
                                          getRandomString(5);
                                          await getToken();

                                          print('token:');
                                          print(token);
                                          print('channelname:');
                                          print(channelname);

                                          final refe = FirebaseFirestore
                                              .instance
                                              .collection('Rooms')
                                              .doc();
                                          /*    String  */
                                          refe.set({
                                            'id': refe.id,
                                            'Token': token,
                                            'isproffesional': false,
                                            'channel name': channelname,
                                            'isfull': 'no',
                                          });
                                          setState(() {
                                            w = "Waiting for the";
                                          });
                                          var time = const Duration(seconds: 1);
                                          Timer.periodic(time, (timer) {
                                            print('asdfhsd');
                                            final refee = FirebaseFirestore
                                                .instance
                                                .collection('Rooms')
                                                .doc(refe.id)
                                                .get()
                                                .then((DocumentSnapshot value) {
                                              if (value.exists) {
                                                if (value['isfull'] == 'Yes') {
                                                  print(token);
                                                  print(
                                                      "Coalljoiningchannelname====>$channelname");
                                                  setState(() {
                                                    isSearching = false;
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CallPage(
                                                        reference: refe.id,
                                                        token: token,
                                                        channelName:
                                                            channelname,
                                                        role: ClientRole
                                                            .Broadcaster,
                                                      ),
                                                    ),
                                                  );
                                                  timer.cancel();
                                                }
                                              }
                                            });
                                          });
                                        } else {
                                          print("helllo");
                                          for (int i = 0;
                                              i < value.docs.length;
                                              i++) {
                                            print(
                                                value.docs[i].data()['isfull']);
                                            String reference = "";
                                            final refe = FirebaseFirestore
                                                .instance
                                                .collection('Rooms')
                                                .doc(
                                                    value.docs[i].data()['id']);
                                            print(value.docs[i].data()['id']);
                                            print(
                                                value.docs[i].data()['Token']);
                                            print(value.docs[i]
                                                .data()['channel name']);
                                            setState(() {
                                              reference =
                                                  value.docs[i].data()['id'];
                                              token =
                                                  value.docs[i].data()['Token'];
                                              channelname = value.docs[i]
                                                  .data()['channel name'];
                                            });

                                            print(refe);
                                            refe.update({
                                              'isfull': "Yes",
                                            });
                                            print(
                                                value.docs[i].data()['isfull']);
                                            print("..........................");
                                            print(token);
                                            print(channelname);
                                            print("..........................");
                                            setState(() {
                                              isSearching = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CallPage(
                                                  reference: reference,
                                                  channelName: channelname,
                                                  token: token,
                                                  role: ClientRole.Broadcaster,
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                        }
                                      });
                                    });
                                  }*/
                                },
                                child: "start searching"
                                    .text
                                    .textStyle(TextStyle(fontSize: 14))
                                    .white
                                    .make(),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.44,
                              child: Image.asset(
                                  "assets/images/animations/map_animation.gif"),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        10, -9), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: LinearProgressIndicator(
                                        minHeight: 10,
                                        value: controller.value,
                                        color: Colors.deepOrange,
                                        backgroundColor: Colors.white,
                                        semanticsLabel:
                                            'Linear progress indicator',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.phone_solid,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily:
                                                        GoogleFonts.openSans()
                                                            .fontFamily),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: '$w ',
                                                      style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black)),
                                                  new TextSpan(
                                                      text: 'best...',
                                                      style: new TextStyle(
                                                          color:
                                                              Colors.orange)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isSearching = false;
                                              });
                                              setState(() {
                                                flag = true;
                                              });
                                              flag = true;
                                            },
                                            child: "Cancel"
                                                .text
                                                .textStyle(TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 16))
                                                .bold
                                                .fontFamily(
                                                    GoogleFonts.openSans()
                                                        .fontFamily!)
                                                .make())
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                    ],
                                  ),
                                  /*  SizedBox(
                                    height: 50,
                                  ), */
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              !isSearchingp
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Professional Connect",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            "connect on a 5-min call with people from Professional industry"
                                .text
                                .center
                                .fontFamily(GoogleFonts.openSans().fontFamily!)
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
                                      isSearchingp = true;
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 1000),
                                        () async {
                                      await _handleCameraAndMic(
                                          Permission.camera);
                                      await _handleCameraAndMic(
                                          Permission.microphone);
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      final ref = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .collection('Status')
                                          .doc(user.uid);
                                      ref.set({
                                        'id': ref.id,
                                        'isproffesional': true,
                                        'isonline': true,
                                      });

                                      FirebaseFirestore.instance
                                          .collection('Rooms')
                                          .where('isfull', isEqualTo: 'no')
                                          .where('isproffesional',
                                              isEqualTo: true)
                                          .get()
                                          .then((value) async {
                                        print("1");
                                        if (value.docs.isEmpty) {
                                          print("not there");
                                          getRandomString(5);
                                          await getToken();

                                          print('token:');
                                          print(token);
                                          print('channelname:');
                                          print(channelname);

                                          final refe = FirebaseFirestore
                                              .instance
                                              .collection('Rooms')
                                              .doc();

                                          refe.set({
                                            'id': refe.id,
                                            'Token': token,
                                            'isproffesional': true,
                                            'channel name': channelname,
                                            'isfull': 'no',
                                          });
                                          setState(() {
                                            w = "Waiting for the";
                                          });
                                          var time = const Duration(seconds: 1);
                                          Timer.periodic(time, (timer) {
                                            print('asdfhsd');
                                            final refee = FirebaseFirestore
                                                .instance
                                                .collection('Rooms')
                                                .doc(refe.id)
                                                .get()
                                                .then((DocumentSnapshot value) {
                                              if (value.exists) {
                                                if (value['isfull'] == 'Yes') {
                                                  print(token);
                                                  print(channelname);
                                                  setState(() {
                                                    isSearchingp = false;
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CallPage(
                                                        reference: refe.id,
                                                        token: token,
                                                        channelName:
                                                            channelname,
                                                        role: ClientRole
                                                            .Broadcaster,
                                                      ),
                                                    ),
                                                  );
                                                  timer.cancel();
                                                }
                                              }
                                            });
                                          });
                                        } else {
                                          for (int i = 0;
                                              i < value.docs.length;
                                              i++) {
                                            print(
                                                value.docs[i].data()['isfull']);
                                            String reference = "";
                                            final refe = FirebaseFirestore
                                                .instance
                                                .collection('Rooms')
                                                .doc(
                                                    value.docs[i].data()['id']);
                                            print(value.docs[i].data()['id']);
                                            print(
                                                value.docs[i].data()['Token']);
                                            print(value.docs[i]
                                                .data()['channel name']);
                                            setState(() {
                                              reference =
                                                  value.docs[i].data()['id'];
                                              token =
                                                  value.docs[i].data()['Token'];
                                              channelname = value.docs[i]
                                                  .data()['channel name'];
                                            });

                                            print(refe);
                                            refe.update({
                                              'isfull': "Yes",
                                            });
                                            print(
                                                value.docs[i].data()['isfull']);
                                            print("..........................");
                                            print(token);
                                            print(channelname);
                                            print("..........................");
                                            setState(() {
                                              isSearchingp = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CallPage(
                                                  reference: reference,
                                                  channelName: channelname,
                                                  token: token,
                                                  role: ClientRole.Broadcaster,
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                        }
                                      });
                                    });
                                  },
                                  child: "start searching"
                                      .text
                                      .textStyle(TextStyle(fontSize: 14))
                                      .white
                                      .make()),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.44,
                              child: Image.asset(
                                  "assets/images/animations/map_animation.gif"),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        10, -9), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: LinearProgressIndicator(
                                        minHeight: 10,
                                        value: controller.value,
                                        color: Colors.deepOrange,
                                        backgroundColor: Colors.white,
                                        semanticsLabel:
                                            'Linear progress indicator',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.phone_solid,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily:
                                                        GoogleFonts.openSans()
                                                            .fontFamily),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: '$w ',
                                                      style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black)),
                                                  new TextSpan(
                                                      text: 'best...',
                                                      style: new TextStyle(
                                                          color:
                                                              Colors.orange)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              final user = FirebaseAuth
                                                  .instance.currentUser;
                                              final ref = FirebaseFirestore
                                                  .instance
                                                  .collection('users')
                                                  .doc(user!.uid)
                                                  .collection('Status')
                                                  .doc(user.uid);
                                              ref.set({
                                                'id': ref.id,
                                                'isproffesional': false,
                                                'isonline': false,
                                              });
                                              setState(() {
                                                isSearchingp = false;
                                              });
                                            },
                                            child: "Cancel"
                                                .text
                                                .textStyle(TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 16))
                                                .bold
                                                .fontFamily(
                                                    GoogleFonts.openSans()
                                                        .fontFamily!)
                                                .make())
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: Image.asset(
                                                      'assets/images/avatars/avatar1.png')
                                                  .image,
                                            ),
                                            onPressed: () {},
                                          ),
                                          "Nick.T".text.black.make(),
                                          "USA"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Color(0xFFAFAFAF)))
                                              .make()
                                        ],
                                      ),
                                    ],
                                  ),
                                  /*  SizedBox(
                                    height: 50,
                                  ), */
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
