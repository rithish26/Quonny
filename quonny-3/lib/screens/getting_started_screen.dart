// ignore_for_file: unrelated_type_equality_checks

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quonny_quonnect/cons/string_constant.dart';
import 'package:quonny_quonnect/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  PageController controller = PageController(initialPage: 0, keepPage: true);
  TextEditingController loc = TextEditingController();

  var selectedPage = 0;
  var numberOfQuestions = 3;
  String buttonLabel = "CONTINUE";
  int wordsLeft = 100;
  String avatar_src = 'assets/images/camera.png';
  bool is_avatar_selected = false;
  final TextEditingController ph_controller = TextEditingController();
  final TextEditingController abt = TextEditingController();
  final TextEditingController raffralCodeCntrl = TextEditingController();
  String initialCountry = 'IN';
  bool isSelected = false;
  String referral_code = "";
  bool isApplyReferal = true;
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  final user = FirebaseAuth.instance.currentUser;

  //add other_referral_id filed in user
  addOtherReferFiled() {
    final ref = FirebaseFirestore.instance.collection('users').doc(user!.uid);
    ref.update({"other_referral_code": referalcode});
  }

  //check referal code in flutter
  checkRefer() {
    var datareferl = FirebaseFirestore.instance
        .collection('users')
        .where(
          'referral_code',
          isEqualTo: referalcode,
        )
        .get();
    datareferl.then((value) {
      if (value.docs.isNotEmpty) {
        addOtherReferFiled();
        var sss = value.docs;
        sss.forEach((element) async {
          String userId = element.id;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .update({
            "total_quoin": FieldValue.increment(25),
          });
          savePaymentDetailsGetReward(userId);
          Fluttertoast.showToast(msg: "Rererral apply");
        });
      } else {
        Fluttertoast.showToast(msg: "Rererral code not apply");
      }
    });
  }

  //save payment in transection history
  void savePaymentDetailsGetReward(String userId) {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transaction_history')
        .doc();
    ref.set({
      'id': ref.id,
      'quoins': 25,
      'created_date': new DateTime.now(),
      'amount': 0,
      'currancy': 'Inr',
      'modified_date': null,
      'other_user_id': null,
      'type': strConst.referral,
      'transection_id': null,
      'message': strConst.msgReferralCode,
      'transection_type': strConst.credit
    });
  }

  Widget _buildPopupDialog(BuildContext context, String text) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
      ),
      title: Text('Error',
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
                    '$text',
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

  List<String> avatar_list = [
    "assets/images/avatars/avatar1.png",
    "assets/images/avatars/avatar2.png",
    "assets/images/avatars/avatar3.png",
    "assets/images/avatars/avatar4.png",
    "assets/images/avatars/avatar5.png"
  ];
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
  late int x;
  String name = "";
  String nickname = "";
  String about = "";
  String numberiso = "";
  String location = "";
  String referalcode = "";
  String numbere = "";
  int i = 0;
  bool _validate = false;
  bool valid = false;
  late List<String> selected;
  String address = "";
  String country = "";
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      loc.text = '${place.subLocality}, ${place.locality}, ${place.country}';
      country = '${place.country}';
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String selectedChoice = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          if (selectedPage > 0) {
            selectedPage = selectedPage - 1;
            controller.jumpToPage(selectedPage);
          } else if (selectedPage == 0) {
            Navigator.pop(context);
            /*  Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DemoScreens()),
              (Route<dynamic> route) => false,
            ); */
          }
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
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
                            x = index;
                            selectedPage = index;
                            if (index + 1 < numberOfQuestions) {
                              buttonLabel = "CONTINUE";
                            } else {
                              buttonLabel = "CREATE PROFILE";
                            }
                          });
                        },
                        children: <Widget>[
                          SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "Hey, There"
                                          .text
                                          .semiBold
                                          .fontWeight(FontWeight.w900)
                                          .black
                                          .xl3
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make(),
                                      "${selectedPage + 1} / ${numberOfQuestions}"
                                          .text
                                          .textStyle(
                                              TextStyle(color: Colors.orange))
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make()
                                    ],
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: "Let's get you started"
                                          .text
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .textStyle(TextStyle(
                                            color: Color(0xFF505050),
                                          ))
                                          .xl
                                          .make()
                                          .pLTRB(0, 10, 0, 0)),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: GoogleFonts.openSans()
                                              .fontFamily),
                                      children: <TextSpan>[
                                        new TextSpan(text: 'What is your '),
                                        new TextSpan(
                                            text: 'real',
                                            style: new TextStyle(
                                                color: Colors.orange)),
                                        new TextSpan(text: ' name ?'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 12, bottom: 24),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Color(0xFFAFAFAF),
                                          ),
                                          hintText: "Please enter name here",
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Name is required !";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          name = value;
                                        });
                                      },
                                    ),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: GoogleFonts.openSans()
                                              .fontFamily),
                                      children: <TextSpan>[
                                        new TextSpan(text: 'What is your '),
                                        new TextSpan(
                                          text: 'nick',
                                        ),
                                        new TextSpan(text: ' name ?'),
                                      ],
                                    ),
                                  ),
                                  /*  "Write a nick name ?"
                                      .text
                                      .black
                                      .fontFamily(GoogleFonts.openSans()
                                          .fontFamily!)
                                      .textStyle(TextStyle(fontSize: 18))
                                      .make(), */
                                  Container(
                                    margin: EdgeInsets.only(top: 12, bottom: 8),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Color(0xFFAFAFAF),
                                          ),
                                          hintText:
                                              "Please enter nick name here",
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Nick Name is required !";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        // name = value;
                                        setState(() {
                                          nickname = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child:
                                        "nick name will be displayed to others"
                                            .text
                                            .bold
                                            .italic
                                            .textStyle(TextStyle(
                                                color: Color(0xFF919191)))
                                            .make(),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "About You"
                                          .text
                                          .black
                                          .textStyle(TextStyle(fontSize: 18))
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make(),
                                      "${wordsLeft} charecters"
                                          .text
                                          .textStyle(
                                            TextStyle(color: Colors.deepOrange),
                                          )
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make()
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      controller: abt,
                                      validator: (text) {
                                        if (text!.split(' ').length > 1000) {
                                          return 'Reached max words';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          errorText: _validate
                                              ? 'You have entered more than 100 words'
                                              : null,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Color(0xFFAFAFAF),
                                          ),
                                          hintText:
                                              "Share your education, job, hobbies...",
                                          contentPadding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 20)),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 10,
                                      maxLength: 100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "Some More..."
                                          .text
                                          .fontWeight(FontWeight.w900)
                                          .black
                                          .xl3
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make(),
                                      "${selectedPage + 1} / ${numberOfQuestions}"
                                          .text
                                          .textStyle(
                                              TextStyle(color: Colors.orange))
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make()
                                    ],
                                  ),
                                  "Upload photos and location"
                                      .text
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(
                                        color: Color(0xFF505050),
                                      ))
                                      .xl
                                      .make()
                                      .pLTRB(0, 10, 0, 0),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              backgroundColor: Colors.white,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20.0)),
                                                    color: Colors.white,
                                                    /* boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset: Offset(
                                                            0.0, 1.0), //(x,y)
                                                        blurRadius: 5.0,
                                                      ),
                                                    ], */
                                                  ),
                                                  height: 300,
                                                  child: GridView.count(
                                                    crossAxisCount: 5,
                                                    // Generate 100 widgets that display their index in the List.
                                                    children: List.generate(15,
                                                        (index) {
                                                      return IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              avatar_src =
                                                                  avatar_list[
                                                                      index %
                                                                          5];
                                                              is_avatar_selected =
                                                                  true;
                                                            });
                                                          },
                                                          icon: Image.asset(
                                                              avatar_list[
                                                                  index % 5]));
                                                    }),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: is_avatar_selected
                                              ? Image.asset(
                                                  avatar_src,
                                                  fit: BoxFit.fitWidth,
                                                  width: 60,
                                                  height: 60,
                                                )
                                              : Image.asset(
                                                  avatar_src,
                                                  fit: BoxFit.fitWidth,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                CircleBorder()),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(90, 90)),
                                            // padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                                            backgroundColor:
                                                MaterialStateProperty.all(Color(
                                                    0xFFF5F5F5)), // <-- Button color
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>((states) {
                                              if (states.contains(
                                                  MaterialState.pressed))
                                                return Color(
                                                    0xFFF0F0F0); // <-- Splash color
                                            }),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        "Choose Avatar"
                                            .text
                                            .black
                                            .fontFamily(GoogleFonts.openSans()
                                                .fontFamily!)
                                            .textStyle(TextStyle(fontSize: 14))
                                            .make(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  "Add your mobile number"
                                      .text
                                      .black
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(fontSize: 18))
                                      .make(),
                                  Container(
                                    margin: EdgeInsets.only(top: 12, bottom: 8),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: InternationalPhoneNumberInput(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      inputDecoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Color(0xFFAFAFAF),
                                        ),
                                        hintText: "Please enter number",
                                      ),
                                      onInputChanged: (PhoneNumber number) {
                                        setState(() {
                                          numbere = number.phoneNumber!;
                                          numberiso = number.isoCode!;
                                        });
                                        print(numbere);
                                        print(numberiso);
                                      },
                                      onInputValidated: (bool value) {
                                        setState(() {
                                          valid = value;
                                        });
                                        print(value);
                                      },
                                      selectorConfig: SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.DIALOG,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      selectorTextStyle:
                                          TextStyle(color: Colors.black),
                                      initialValue: number,
                                      textFieldController: ph_controller,
                                      formatInput: false,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      onSaved: (PhoneNumber number) {
                                        print('On Saved: $number');
                                        numberiso = number.isoCode!;
                                        numbere = number.phoneNumber!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                    child:
                                        "mobile will not be shared with anyone"
                                            .text
                                            .bold
                                            .italic
                                            .textStyle(TextStyle(
                                                color: Color(0xFF919191)))
                                            .make(),
                                  ),
                                  "Where do you live ?"
                                      .text
                                      .black
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(fontSize: 18))
                                      .make(),
                                  Container(
                                    margin: EdgeInsets.only(top: 12, bottom: 8),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      enableInteractiveSelection: false,
                                      onChanged: (value) async {
                                        Position position =
                                            await _determinePosition();
                                        GetAddressFromLatLong(position);
                                      },
                                      controller: loc,
                                      decoration: InputDecoration(
                                          icon: Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    15), // add padding to adjust icon
                                            child: IconButton(
                                              icon: Icon(CupertinoIcons
                                                  .location_solid),
                                              onPressed: () async {
                                                Position position =
                                                    await _determinePosition();
                                                GetAddressFromLatLong(position);
                                              },
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Color(0xFFAFAFAF),
                                          ),
                                          hintText:
                                              "Please enter location here",
                                          contentPadding:
                                              EdgeInsets.only(right: 20)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Location is required !";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                    child:
                                        "location will help us find better match for you"
                                            .text
                                            .bold
                                            .italic
                                            .textStyle(TextStyle(
                                                color: Color(0xFF919191)))
                                            .make(),
                                  ),
                                  "Add referral code"
                                      .text
                                      .black
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(fontSize: 18))
                                      .make(),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 12, bottom: 8),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFFAFAFAF),
                                                  ),
                                                  hintText:
                                                      "Please enter referral code here",
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          right: 20)),
                                              initialValue: referral_code,
                                              // controller: raffralCodeCntrl,
                                              onChanged: (value) {
                                                // name = value;
                                                setState(() {
                                                  referalcode = value;
                                                  debugPrint(
                                                      "referral===>$referalcode");
                                                });
                                              },
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // setState(() {
                                              //   isApplyReferal =
                                              //       !isApplyReferal;
                                              //   debugPrint(
                                              //       "jsbcjbs$isApplyReferal");
                                              // });
                                              // if (referalcode.length == 6) {
                                              checkRefer();
                                              // }
                                            },
                                            style: ButtonStyle(),
                                            child: "Apply"
                                                .text
                                                .fontFamily(
                                                    GoogleFonts.openSans()
                                                        .fontFamily!)
                                                .textStyle(TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.deepOrange))
                                                .make(),
                                          )
                                        ],
                                      )),
                                  /*  "Successful!! Your 100 Quoins will be added to your wallet"
                                      .text
                                      .green500
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .make()
                                      .pLTRB(0, 10, 0, 0), */
                                  /* Container(
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
                          SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "Choose Industry"
                                          .text
                                          .semiBold
                                          .fontWeight(FontWeight.w900)
                                          .black
                                          .xl3
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make(),
                                      "${selectedPage + 1} / ${numberOfQuestions}"
                                          .text
                                          .textStyle(
                                              TextStyle(color: Colors.orange))
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .make()
                                    ],
                                  ),
                                  "Select industries from where people will connect"
                                      .text
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(
                                        color: Color(0xFF505050),
                                      ))
                                      .xl
                                      .make()
                                      .pLTRB(0, 10, 0, 0),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "Casual"
                                          .text
                                          .semiBold
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .textStyle(TextStyle(
                                              fontSize: 20,
                                              color: Colors.black))
                                          .make(),
                                      "choose 2"
                                          .text
                                          .italic
                                          .bold
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .textStyle(TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFAFAFAF)))
                                          .make(),
                                    ],
                                  ),
                                  /*  MultiSelectChipDisplay(
                                    items: casual_chips
                                        .map((e) => MultiSelectItem(e, e))
                                        .toList(),
                                    onTap: (value) {
                                      setState(() {
                                        i++;
                                        selected.add(value.toString());
                                        print(selected);
                                      });
                                    },
                                  ), */

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
                                            casual_chips[index],
                                          ),
                                          labelStyle: TextStyle(
                                              color: _value == index
                                                  ? Colors.white
                                                  : Color(0xFF919191),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.openSans()
                                                  .fontFamily),
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
                                    height: 30,
                                  ),
                                  "Gender"
                                      .text
                                      .semiBold
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .textStyle(TextStyle(
                                          fontSize: 20, color: Colors.black))
                                      .make(),
                                  /*   Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "Professional"
                                          .text
                                          .semiBold
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .textStyle(TextStyle(
                                              fontSize: 20,
                                              color: Colors.black))
                                          .make(),
                                      "choose 2"
                                          .text
                                          .italic
                                          .bold
                                          .fontFamily(GoogleFonts.openSans()
                                              .fontFamily!)
                                          .textStyle(TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFAFAFAF)))
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
                                                color: Color(0xFFCECECE),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Color(0xFFF5F5F5),
                                          selectedColor: Colors.deepOrange,
                                          label: Text(
                                            casual_chips[index],
                                          ),
                                          labelStyle: TextStyle(
                                              color: _value2 == index
                                                  ? Colors.white
                                                  : Color(0xFF919191),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.openSans()
                                                  .fontFamily),
                                          selected: _value2 == index,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _value2 = selected ? index : null;
                                            });
                                          },
                                        );
                                      },
                                    ).toList(),
                                  ), */
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
                        ],
                      ))
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
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
                      setState(() async {
                        if (selectedPage < numberOfQuestions - 1) {
                          selectedPage = selectedPage + 1;
                          controller.jumpToPage(selectedPage);
                        } else if (selectedPage == numberOfQuestions - 1) {
                          if (name == "") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(
                                      context, "Name feild is empty"),
                            );
                          } else if (nickname == "") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(
                                      context, "Nickname feild is empty"),
                            );
                          } else if (abt == "") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(
                                      context, "About you feild is empty"),
                            );
                          } else if (avatar_src == "assets/images/camera.png") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context,
                                      "Avatar Not selected feild is empty"),
                            );
                          } else if (numbere == "") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(
                                      context, "Phone number feild is empty"),
                            );
                          } else if (valid == false) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context,
                                      "Please enter valid Phone number"),
                            );
                          } else if (loc.text == "") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(
                                      context, "Location feild is empty"),
                            );
                          } else {
                            print(name);

                            final user = FirebaseAuth.instance.currentUser;
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .update({
                              'name': name,
                              'nickname': nickname,
                              'about': abt.text,
                              'avatar': avatar_src,
                              'phonecode': numberiso,
                              'phonenumber': numbere,
                              'locationstring': loc.text,
                              'country': country,
                              'notification': true,
                              'datecreated': DateTime.now(),
                              'datemodified': null,
                            });

                            Position position = await _determinePosition();
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .update({
                              'position': GeoPoint(
                                  position.latitude, position.longitude),
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .collection('userdata')
                                .doc(user.uid)
                                .set({
                              'position': GeoPoint(
                                  position.latitude, position.longitude),
                              'name': name,
                              'nickname': nickname,
                              'about': abt.text,
                              'avatar': avatar_src,
                              'phonecode': numberiso,
                              'phonenumber': numbere,
                              'locationstring': loc.text,
                              'country': country,
                              'notification': true,
                              'datecreated': DateTime.now(),
                              'datemodified': null,
                            });
                            print("userLogin====>$user");

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: Wrap(
                                          children: [
                                            Center(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/animations/onboard.gif",
                                                    height: 200,
                                                    width: 200,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  "Welcoming you Onboard"
                                                      .text
                                                      .xl
                                                      .bold
                                                      .fontFamily(
                                                          GoogleFonts.openSans()
                                                              .fontFamily!)
                                                      .black
                                                      .make()
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                });
                            Future.delayed(const Duration(milliseconds: 3000),
                                () async {
                              Navigator.pushNamed(
                                  context, MyRoutes.questionaire);
                            });
                          }
                        }
                      });
                    },
                    child: buttonLabel.text.xl.make(),
                  ).p(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
