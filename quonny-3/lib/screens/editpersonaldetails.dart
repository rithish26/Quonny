import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:velocity_x/velocity_x.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  String avatar_src = 'assets/images/avatars/avatar5.png';
  bool is_avatar_selected = false;
  int? _value2 = 1;
  String location = "";
  final TextEditingController ph_controller = TextEditingController();
  final TextEditingController abt = TextEditingController();
  final TextEditingController locationstring = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  List<String> avatar_list = [
    "assets/images/avatars/avatar1.png",
    "assets/images/avatars/avatar2.png",
    "assets/imaavatar3.png",
    "assets/images/avatars/avatar4.png",
    "assets/images/avatars/avatar5.png"
  ];
  int wordsLeft = 0;
  String name = "";
  String nickname = "";
  String numbere = "";
  String numberiso = "";
  bool valid = false;
  @override
  void initState() {
    // TODO: implement initState
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
          nickname = value['nickname'];
          avatar_src = value['avatar'];
          abt.text = value['about'];
          number = PhoneNumber(
              isoCode: value['phonecode'], phoneNumber: value['phonenumber']);
          location = value['locationstring'];
          locationstring.text = value['locationstring'];
        });
      }
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
              'personal details',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
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
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20.0)),
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
                                          children: List.generate(15, (index) {
                                            return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    avatar_src =
                                                        avatar_list[index % 5];
                                                    is_avatar_selected = true;
                                                  });
                                                },
                                                icon: Image.asset(
                                                    avatar_list[index % 5]));
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
                                        width: 60,
                                        height: 60,
                                      ),
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(90, 90)),
                                  // padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFF5F5F5)), // <-- Button color
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Color(
                                          0xFFF0F0F0); // <-- Splash color
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              "$name"
                                  .text
                                  .black
                                  .bold
                                  .fontFamily(
                                      GoogleFonts.openSans().fontFamily!)
                                  .textStyle(TextStyle(fontSize: 14))
                                  .make(),
                              "$nickname"
                                  .text
                                  .color(Colors.black.withOpacity(0.3))
                                  .fontFamily(
                                      GoogleFonts.openSans().fontFamily!)
                                  .textStyle(TextStyle(fontSize: 14))
                                  .make(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "About You"
                                  .text
                                  .black
                                  .textStyle(TextStyle(fontSize: 18))
                                  .fontFamily(
                                      GoogleFonts.openSans().fontFamily!)
                                  .make(),
                              /*  "${wordsLeft} words"
                                  .text
                                  .textStyle(
                                    TextStyle(color: Colors.deepOrange),
                                  )
                                  .fontFamily(GoogleFonts.openSans().fontFamily!)
                                  .make() */
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextFormField(
                              controller: abt,
                              decoration: InputDecoration(
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
                              maxLines: 6,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: "Change mob. number"
                              .text
                              .black
                              .fontFamily(GoogleFonts.openSans().fontFamily!)
                              .textStyle(TextStyle(fontSize: 18))
                              .make(),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 12, bottom: 8),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8)),
                            child: InternationalPhoneNumberInput(
                              textAlignVertical: TextAlignVertical.center,
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
                                selectorType: PhoneInputSelectorType.DIALOG,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: ph_controller,
                              formatInput: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                                numberiso = number.isoCode!;
                                numbere = number.phoneNumber!;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
                          child: "mobile will not be shared with anyone"
                              .text
                              .bold
                              .italic
                              .textStyle(TextStyle(color: Color(0xFF919191)))
                              .make(),
                        ),
                        "Change location"
                            .text
                            .black
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(fontSize: 18))
                            .make(),
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 8),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            controller: locationstring,
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  CupertinoIcons.location_solid,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(0xFFAFAFAF),
                                ),
                                hintText: "Please enter location here",
                                contentPadding: EdgeInsets.only(
                                    right: 20, left: 20, top: 20, bottom: 20)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Location is required !";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // name = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child:
                              "location will help us find better match for you"
                                  .text
                                  .bold
                                  .italic
                                  .textStyle(
                                      TextStyle(color: Color(0xFF919191)))
                                  .make(),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
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
                    onPressed: () async {
                      if (abt == "") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, "About you feild is empty"),
                        );
                      } else if (avatar_src == "assets/images/camera.png") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, "Avatar Not selected feild is empty"),
                        );
                      } else if (numbere == "") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, "Phone number feild is empty"),
                        );
                      } else if (valid == false) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, "Please enter valid Phone number"),
                        );
                      } else if (locationstring.text == "") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, "Location feild is empty"),
                        );
                      } else {
                        final user = FirebaseAuth.instance.currentUser!.uid;
                        final r = FirebaseFirestore.instance
                            .collection('users')
                            .doc(user);

                        r.update({
                          'id': r.id,
                          'about': abt.text,
                          'locationstring': locationstring.text,
                          'date_modified': new DateTime.now(),
                          'phonecode': numberiso,
                          'avatar': avatar_src,
                          'phonenumber': numbere,
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user)
                            .collection('userdata')
                            .doc(user)
                            .update({
                          'id': r.id,
                          'about': abt.text,
                          'locationstring': locationstring.text,
                          'date_modified': new DateTime.now(),
                          'phonecode': numberiso,
                          'avatar': avatar_src,
                          'phonenumber': numbere,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: "UPDATE".text.xl.make(),
                  ).p(20),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
