import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quonny_quonnect/screens/Calander.dart';
import 'package:quonny_quonnect/screens/profile.dart';
import 'package:quonny_quonnect/screens/wallet.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class QuonnectScreen extends StatefulWidget {
  @override
  _QuonnectScreenState createState() => _QuonnectScreenState();
}

class _QuonnectScreenState extends State<QuonnectScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  int currenti = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isSearching = false;
  _onTapped(int index) {
    setState(() {
      print(index);
      currenti = index;
    });
  }

  final screens = [
    Homepage(),
    Calander(),
    Wallet(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currenti],
      bottomNavigationBar: Container(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            /* Color(0xFFFFFFFF), */
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Color(0xFFAAAAAA),
            selectedFontSize: 0,
            currentIndex: currenti,
            unselectedFontSize: 0,
            elevation: 2,
            onTap: (value) {
              _onTapped(value);
            },
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.calendar_today,
                  size: 28,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: CircleAvatar(
                  radius: 16,
                  backgroundImage: Image.asset(
                    "assets/images/avatars/avatar1.png",
                    fit: BoxFit.fill,
                  ).image,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /*  DefaultTabController(
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
                                .fontFamily(GoogleFonts.openSans().fontFamily!)
                                .textStyle(TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900))
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
                                    onPressed: () {},
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
        ), */
    //body: screens[currenti],
    /* TabBarView(
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
                                fontSize: 30,
                                fontFamily: GoogleFonts.openSans().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                          "connect on a 5-min call with people from casual industry"
                              .text
                              .center
                              .fontFamily(GoogleFonts.openSans().fontFamily!)
                              .textStyle(TextStyle(fontSize: 18))
                              .make()
                              .pLTRB(40, 20, 40, 20),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepOrange)),
                              onPressed: () {
                                setState(() {
                                  isSearching = true;
                                });
                              },
                              child: "start searching"
                                  .text
                                  .textStyle(TextStyle(fontSize: 20))
                                  .white
                                  .make())
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                              "assets/images/animations/map_animation.gif"),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                                  padding: EdgeInsets.all(20),
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
                                                    text: 'Calling the '),
                                                new TextSpan(
                                                    text: 'best...',
                                                    style: new TextStyle(
                                                        color: Colors.orange)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isSearching = false;
                                            });
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.orange)),
                                          child: "Cancel"
                                              .text
                                              .textStyle(TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                              .bold
                                              .fontFamily(GoogleFonts.openSans()
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
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            Container(
              height: 200,
              child: Center(
                child: Text(
                  "Professional",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ), */
    /*  bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFFFFFFF),
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Color(0xFFAAAAAA),
          selectedFontSize: 14,
          currentIndex: currenti,
          unselectedFontSize: 14,
          onTap: (value) {
            _onTapped(value);
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Calendar'),
              icon: Icon(Icons.calendar_today),
            ),
            BottomNavigationBarItem(
              title: Text('Wallet'),
              icon: Icon(Icons.account_balance_wallet_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Profile'),
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: Image.asset(
                  "assets/images/avatars/avatar1.png",
                  fit: BoxFit.fill,
                ).image,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    ); */
  }
}
