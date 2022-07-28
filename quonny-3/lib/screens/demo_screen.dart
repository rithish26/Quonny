import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quonny_quonnect/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

import 'getting_started_screen.dart';

class DemoScreens extends StatefulWidget {
  @override
  _DemoScreensState createState() => _DemoScreensState();
}

class _DemoScreensState extends State<DemoScreens> {
  PageController controller = PageController(initialPage: 0, keepPage: true);
  var selectedPage = 0;
  var numberOfQuestions = 3;
  String message = "";

  @override
  Widget build(BuildContext context) {
    message = ((selectedPage + 1).toString() + " of $numberOfQuestions");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Column(children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.65),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      pageSnapping: true,
                      onPageChanged: (index) {
                        setState(() {
                          selectedPage = index;
                        });
                      },
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 40),
                                  Image.asset(
                                    "assets/images/demo_image1.png",
                                  ),
                                  SizedBox(height: 20),
                                  "Random Connects"
                                      .text
                                      .extraBold
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(fontSize: 24))
                                      .fontWeight(FontWeight.w900)
                                      .black
                                      .make(),
                                  "Connect with random people of you same interests over video call"
                                      .text
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .center
                                      .textStyle(TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF505050)))
                                      .make()
                                      .pLTRB(20, 10, 20, 0)
                                ],
                              )),
                        ),
                        SingleChildScrollView(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 40),
                                  Image.asset(
                                    "assets/images/demo_image2.png",
                                  ),
                                  SizedBox(height: 20),
                                  "Global Connectivity"
                                      .text
                                      .extraBold
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(fontSize: 24))
                                      .fontWeight(FontWeight.w900)
                                      .black
                                      .make(),
                                  "Connect with random people of you same interests over video call"
                                      .text
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .center
                                      .textStyle(TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF505050)))
                                      .make()
                                      .pLTRB(20, 10, 20, 0)
                                ],
                              )),
                        ),
                        SingleChildScrollView(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 40),
                                  Image.asset(
                                    "assets/images/demo_image3.png",
                                  ),
                                  SizedBox(height: 20),
                                  "Date in 5 Minutes"
                                      .text
                                      .extraBold
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(fontSize: 24))
                                      .fontWeight(FontWeight.w900)
                                      .black
                                      .make(),
                                  "Connect with random people of you same interests over video call"
                                      .text
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .center
                                      .textStyle(TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF505050)))
                                      .make()
                                      .pLTRB(20, 10, 20, 0)
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.arrow_left),
                        onPressed: () {
                          setState(() {
                            if (selectedPage > 0) {
                              selectedPage = selectedPage - 1;
                              controller.jumpToPage(selectedPage);
                            }
                          });
                        },
                      ),
                      message.text.xl.bold.center.make(),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          setState(() {
                            if (selectedPage < numberOfQuestions - 1) {
                              selectedPage = selectedPage + 1;
                              controller.jumpToPage(selectedPage);
                            } else if (selectedPage == numberOfQuestions - 1) {
                              Navigator.pushNamed(
                                  context, MyRoutes.gettingStartedRoute);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                              // shape: MaterialStateProperty.all(StadiumBorder()),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black),
                              // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.gettingStartedRoute);
                            },
                            child: "Skip"
                                .text
                                .extraBold
                                .fontFamily(GoogleFonts.poppins().fontFamily!)
                                .center
                                .xl
                                .orange500
                                .make()),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black),
                              // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (selectedPage < numberOfQuestions - 1) {
                                  selectedPage = selectedPage + 1;
                                  controller.jumpToPage(selectedPage);
                                } else if (selectedPage ==
                                    numberOfQuestions - 1) {
                                  Navigator.pushNamed(
                                      context, MyRoutes.gettingStartedRoute);
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "Next"
                                    .text
                                    .extraBold
                                    .fontFamily(
                                        GoogleFonts.poppins().fontFamily!)
                                    .center
                                    .xl
                                    .white
                                    .make(),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
