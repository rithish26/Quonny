import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quonny_quonnect/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class Questionaire extends StatefulWidget {
  @override
  _QuestionaireState createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  String name = "";
  @override
  void initState() {
    super.initState();
    String userid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        setState(() {
          name = value['name'];
        });

        print(name);
      }
    });
  }

  List<String> words = [
    "Plonginsty",
    "Jorgenfrond",
    "Havoils",
    "Radickes",
    "Mongilious"
  ];
  String _word_chosen = "";
  List<String> planets = ["Mars", "Neptune", "Venus", "Earth"];
  String _planet_chosen = "";
  List<String> animals = ["Lynx", "Llama", "Havoils", "Radickes", "Mongilious"];
  String _animal_chosen = "";
  List<int> colors = [
    0xFFFF6767,
    0xFFF7DD37,
    0xFF40FF79,
    0xFF3865D0,
    0xFFF461F9,
    0xFFD82CB5,
    0xFFFFA449,
    0xFFA04600
  ];
  int _color_chosen = 0;
  List<IconData> icons = [
    CupertinoIcons.square,
    CupertinoIcons.rectangle,
    CupertinoIcons.hexagon,
    CupertinoIcons.circle,
    CupertinoIcons.triangle
  ];
  int _chosen_icon = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Welcome ${name},"
                            .text
                            .semiBold
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(fontSize: 30))
                            .make()
                            .p(0),
                        SizedBox(
                          height: 30,
                        ),
                        "Questionnaire"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .xl2
                            .black
                            .make()
                            .p(0),
                        SizedBox(
                          height: 10,
                        ),
                        "We would like to know a couple of responses that will help us find the best match for you."
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(
                                color: Color(0xFF505050), fontSize: 16))
                            .make()
                            .p(0),
                        SizedBox(
                          height: 30,
                        ),
                        "1. Pick a Color"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .xl
                            .black
                            .make()
                            .p(0),
                        Scrollbar(
                          child: SingleChildScrollView(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            child: Wrap(
                              spacing: 10,
                              children: List<Widget>.generate(
                                8,
                                (int index) {
                                  return ChoiceChip(
                                    shape: CircleBorder(),
                                    backgroundColor: Colors.transparent,
                                    selectedColor: Color(0xFFCFCFCF),
                                    label: new CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color(colors[index]),
                                        child: Text("")),
                                    // labelStyle: TextStyle(color: _word_chosen == words[index] ? Colors.white : Color(0xFF919191), fontWeight: FontWeight.bold, fontFamily: GoogleFonts.openSans().fontFamily ),

                                    selected: _color_chosen == colors[index],
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _color_chosen =
                                            (selected ? index : null)!;
                                      });
                                      print(_color_chosen);
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        "2. Choose a word"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .xl
                            .black
                            .make(),
                        Wrap(
                          spacing: 10,
                          children: List<Widget>.generate(
                            5,
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
                                  words[index],
                                ),
                                labelStyle: TextStyle(
                                    color: _word_chosen == words[index]
                                        ? Colors.white
                                        : Color(0xFF919191),
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily),
                                selected: _word_chosen == words[index],
                                onSelected: (bool selected) {
                                  setState(() {
                                    _word_chosen =
                                        (selected ? words[index] : null)!;
                                  });
                                },
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        "3. Choose a planet"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .xl
                            .black
                            .make(),
                        Wrap(
                          spacing: 10,
                          children: List<Widget>.generate(
                            4,
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
                                  planets[index],
                                ),
                                labelStyle: TextStyle(
                                    color: _planet_chosen == planets[index]
                                        ? Colors.white
                                        : Color(0xFF919191),
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily),
                                selected: _planet_chosen == planets[index],
                                onSelected: (bool selected) {
                                  setState(() {
                                    _planet_chosen =
                                        (selected ? planets[index] : null)!;
                                  });
                                },
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        "4. Choose an animal"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .xl
                            .black
                            .make(),
                        Wrap(
                          spacing: 10,
                          children: List<Widget>.generate(
                            4,
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
                                  animals[index],
                                ),
                                labelStyle: TextStyle(
                                    color: _animal_chosen == animals[index]
                                        ? Colors.white
                                        : Color(0xFF919191),
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily),
                                selected: _animal_chosen == animals[index],
                                onSelected: (bool selected) {
                                  setState(() {
                                    _animal_chosen =
                                        (selected ? animals[index] : null)!;
                                  });
                                },
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        "5. Choose a figure"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .xl
                            .black
                            .make(),
                        SingleChildScrollView(
                          padding: EdgeInsets.only(top: 10),
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 10,
                            children: List<Widget>.generate(
                              5,
                              (int index) {
                                return ChoiceChip(
                                  padding: EdgeInsets.all(15),
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.transparent,
                                  selectedColor: Color(0xFFCFCFCF),
                                  label: Icon(
                                    icons[index],
                                    size: 70,
                                  ),
                                  // labelStyle: TextStyle(color: _word_chosen == words[index] ? Colors.white : Color(0xFF919191), fontWeight: FontWeight.bold, fontFamily: GoogleFonts.openSans().fontFamily ),

                                  selected: _chosen_icon == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _chosen_icon = (selected ? index : null)!;
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ]),
                )),
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
                      String user = FirebaseAuth.instance.currentUser!.uid;
                      final refid = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user)
                          .collection("Questions")
                          .doc(user);
                      refid.set({
                        'refid': refid.id,
                        'color': _color_chosen,
                        'word': _word_chosen,
                        'planet': _planet_chosen,
                        'animal': _animal_chosen,
                        'Shape': _chosen_icon,
                        'Date_created': new DateTime.now(),
                        'Date_modified': null,
                      });
                      Navigator.pushReplacementNamed(
                          context, MyRoutes.quonnect);
                    },
                    child: "START CALLING".text.xl.make(),
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
