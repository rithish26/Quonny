import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';

class Changeindustry extends StatefulWidget {
  const Changeindustry({Key? key}) : super(key: key);

  @override
  _ChangeindustryState createState() => _ChangeindustryState();
}

class _ChangeindustryState extends State<Changeindustry> {
  List<String> casual_chips = [
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
  int? _value = 1;
  int? _value2 = 1;

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
              width: MediaQuery.of(context).size.width * 0.14,
            ),
            Text(
              'change industry',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Casual"
                            .text
                            .semiBold
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(
                                TextStyle(fontSize: 20, color: Colors.black))
                            .make(),
                        "choose 2"
                            .text
                            .italic
                            .bold
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(
                                fontSize: 16, color: Color(0xFFAFAFAF)))
                            .make(),
                      ],
                    ),
                    Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(
                        10,
                        (int index) {
                          return ChoiceChip(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xFFCECECE), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color(0xFFF5F5F5),
                            selectedColor: Colors.deepOrange,
                            label: Text(
                              casual_chips[index],
                            ),
                            labelStyle: TextStyle(
                                color: _value == index
                                    ? Colors.white
                                    : Color(0xFF919191),
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.openSans().fontFamily),
                            selected: _value == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? index : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Professional"
                            .text
                            .semiBold
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(
                                TextStyle(fontSize: 20, color: Colors.black))
                            .make(),
                        "choose 2"
                            .text
                            .italic
                            .bold
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(
                                fontSize: 16, color: Color(0xFFAFAFAF)))
                            .make(),
                      ],
                    ),
                    Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(
                        10,
                        (int index) {
                          return ChoiceChip(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xFFCECECE), width: 1),
                              borderRadius: BorderRadius.circular(10),
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
                                fontFamily: GoogleFonts.openSans().fontFamily),
                            selected: _value2 == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value2 = selected ? index : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                    /* SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                          minimumSize:
                                              MaterialStateProperty.all(Size(
                                                  double.infinity,
                                                  double.infinity)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.deepOrange),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (selectedPage <
                                                numberOfQuestions - 1) {
                                              selectedPage = selectedPage + 1;
                                              controller
                                                  .jumpToPage(selectedPage);
                                            } else if (selectedPage ==
                                                numberOfQuestions - 1) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                      elevation: 16,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Wrap(
                                                            children: [
                                                              Center(
                                                                child: Column(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/images/animations/onboard.gif",
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          200,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    "Welcoming you Onboard"
                                                                        .text
                                                                        .xl
                                                                        .bold
                                                                        .fontFamily(
                                                                            GoogleFonts.openSans().fontFamily!)
                                                                        .black
                                                                        .make()
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    );
                                                  });
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                Navigator.pushNamed(context,
                                                    MyRoutes.questionaire);
                                              });
                                            }
                                          });
                                        },
                                        child: buttonLabel.text.xl.make(),
                                      ).p(20),
                                    ),
                                  ), */
                  ],
                ),
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
                    onPressed: () {},
                    child: "UPDATE".text.xl.make(),
                  ).p(20),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
