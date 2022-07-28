import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quonny_quonnect/cons/string_constant.dart';
import 'package:quonny_quonnect/provider/hello.dart';
import 'package:quonny_quonnect/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loading = false;
  int rafferalCode = 0;

  //genrate referral
  String genrateReferral() {
    final random = Random();
    const gentareRefer =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    print(
        "xshsauhsdudb=-=-=->${List.generate(6, (index) => gentareRefer[random.nextInt(gentareRefer.length)]).join()}");
    return List.generate(
        6, (index) => gentareRefer[random.nextInt(gentareRefer.length)]).join();
  }

  void _loginwithFacebook(context) async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final FacebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(FacebookAuthCredential);
      var graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me? fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken!.token}'));
      var profile = json.decode(graphResponse.body);

      print(FacebookAuthCredential.accessToken);
      print(FacebookAuthCredential.idToken);
      print(FacebookAuthCredential.rawNonce);
      print(FacebookAuthCredential.secret);
      print(FacebookAuthCredential.token);
      print(FacebookAuthCredential.providerId);
      final user = FirebaseAuth.instance.currentUser!.uid;
      print(user);
      final refid = FirebaseFirestore.instance.collection('users').doc(user);
      await refid.set({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'Realname': userData['name'],
        'id': refid.id,
        'type': 'facebook',
      });
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('image')
          .doc();
      ref.set({
        'id': ref.id,
        'url': userData['picture']['data']['url'],
        'caption': null,
        'note': null,
        'datecreated': new DateTime.now()
      });
      final r = FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .collection('Security')
          .doc(user);
      r.set({
        'id': r.id,
        'mobile': true,
        'email': true,
        'about': true,
        'profile_pic': true,
        'date_created': new DateTime.now(),
        'date_modified': null
      });
      print(refid.id);
      Navigator.pushReplacementNamed(context, MyRoutes.demoPages);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  ///Save Payment data in transection history
  void savePaymentDetails() {
    print("savePayment");
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
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
      'type': strConst.register,
      'transection_id': null,
      'message': strConst.msgRegister,
      'transection_type': strConst.credit
    });
  }

  ////Save data in totalcoin table
  // void saveTotalCoins() {
  //   print("save coin in total coin table");
  //   final user = FirebaseAuth.instance.currentUser;
  //   final reference = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user?.uid)
  //       .collection('totalcoins')
  //       .doc(user?.uid);
  //   reference
  //       .set({'id': reference.id, 'coins': 25, 'created': new DateTime.now()});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: <Color>[
              Color(0xFFFC8A03),
              Color(0xFFFC7440),
              Color(0xFFFF2D4B)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.19,
              ),
              Image.asset(
                "assets/images/quonnyLogo.png",
                fit: BoxFit.cover,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(20),
                transform: Matrix4.translationValues(0, 80, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      "Login to continue"
                          .text
                          .semiBold
                          .black
                          .fontWeight(FontWeight.w900)
                          .fontFamily(GoogleFonts.openSans().fontFamily!)
                          .textStyle(TextStyle(fontSize: 22))
                          .make()
                          .p(10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          /*  if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } */

                          if (snapshot.hasData) {
                            final user = FirebaseAuth.instance.currentUser;
                            final refid = FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid);
                            int flag = 0;
                            print("refId===>$refid");
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .collection('userdata')
                                .doc(user.uid)
                                .get()
                                .then((value) {
                              if (value.exists) {
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.quonnect);

                                flag = 1;
                                print(flag);
                                print("alrady register");
                              } else {
                                // var random = new Random().nextInt(999999);
                                genrateReferral();
                                // print("random genrateno=====>$random");
                                refid.set({
                                  'email': user.email,
                                  'imageUrl': user.photoURL,
                                  'Realname': user.displayName,
                                  'id': refid.id,
                                  'referral_code': genrateReferral(),
                                  // 'other_referral_code': 0,
                                  'total_quoin': 25,
                                  'type': 'Google',
                                });
                                final ref = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .collection('image')
                                    .doc(user.uid);
                                ref.set({
                                  'id': ref.id,
                                  'url': user.photoURL,
                                  'caption': null,
                                  'note': null,
                                  'datecreated': new DateTime.now()
                                });
                                final r = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .collection('Security')
                                    .doc(user.uid);
                                r.set({
                                  'id': r.id,
                                  'mobile': true,
                                  'email': true,
                                  'about': true,
                                  'profile_pic': true,
                                  'date_created': new DateTime.now(),
                                  'date_modified': null
                                });
                                savePaymentDetails();
                                // saveTotalCoins();
                                print("referalId==>${refid.id}");
                                print('yo');

                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.demoPages);
                                print("new register");
                              }
                            });

                            return Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  final provider =
                                      Provider.of<GoogleSignInProvider>(context,
                                          listen: false);
                                  provider.googleLogin();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFECECEC)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(8)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/google.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Expanded(
                                        child: "Continue with Google"
                                            .text
                                            .textStyle(TextStyle(
                                                color: Color(0xFF505050),
                                                fontSize: 14))
                                            .fontFamily(GoogleFonts.openSans()
                                                .fontFamily!)
                                            .center
                                            .make())
                                  ],
                                ),
                              ).h(40),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('something went wrong'),
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  final provider =
                                      Provider.of<GoogleSignInProvider>(context,
                                          listen: false);
                                  provider.googleLogin();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFECECEC)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(8)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/google.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Expanded(
                                        child: "Continue with Google"
                                            .text
                                            .textStyle(TextStyle(
                                                color: Color(0xFF505050),
                                                fontSize: 14))
                                            .fontFamily(GoogleFonts.openSans()
                                                .fontFamily!)
                                            .center
                                            .make())
                                  ],
                                ),
                              ).h(40),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            _loginwithFacebook(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFECECEC)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/facebook.png",
                                fit: BoxFit.fitHeight,
                              ),
                              Expanded(
                                  child: "Continue with Facebook"
                                      .text
                                      .textStyle(TextStyle(
                                          color: Color(0xFF505050),
                                          fontSize: 14))
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .center
                                      .make())
                            ],
                          ),
                        ).h(40),
                      ),
                      /*   SizedBox(
                        height: 20,
                      ), */
                      /*    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.demoPages);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFECECEC)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/apple.png",
                                fit: BoxFit.fitHeight,
                              ),
                              Expanded(
                                  child: "Continue with Apple"
                                      .text
                                      .textStyle(TextStyle(
                                          color: Color(0xFF505050),
                                          fontSize: 14))
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .center
                                      .make())
                            ],
                          ),
                        ).h(40),
                      ), */
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LinkedInUserWidget(
                                  appBar: AppBar(
                                    title: Text('OAuth User'),
                                  ),
                                  destroySession: logoutUser,
                                  redirectUrl: gredirectUrl,
                                  clientId: clientId,
                                  clientSecret: clientSecret,
                                  projection: [
                                    ProjectionParameters.id,
                                    ProjectionParameters.localizedFirstName,
                                    ProjectionParameters.localizedLastName,
                                    ProjectionParameters.firstName,
                                    ProjectionParameters.lastName,
                                    ProjectionParameters.profilePicture,
                                  ],
                                  onError: (UserFailedAction e) {
                                    print('Error: ${e.toString()}');
                                    print('Error: ${e.stackTrace.toString()}');
                                  },
                                  onGetUserProfile:
                                      (UserSucceededAction linkedInUser) {
                                    print(
                                        'Access token ${linkedInUser.user.token.accessToken}');

                                    print(
                                        'User id: ${linkedInUser.user.userId}');

                                    setState(() {
                                      logoutUser = false;
                                    });

                                    Navigator.pop(context);
                                  },
                                ),
                                fullscreenDialog: true,
                              ),
                            ); */
                            Navigator.pushNamed(context, MyRoutes.demoPages);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFECECEC)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/linkedin.png",
                                fit: BoxFit.fitHeight,
                              ),
                              Expanded(
                                  child: "Continue with LinkedIn"
                                      .text
                                      .textStyle(TextStyle(
                                          color: Color(0xFF505050),
                                          fontSize: 14))
                                      .fontFamily(
                                          GoogleFonts.openSans().fontFamily!)
                                      .center
                                      .make())
                            ],
                          ),
                        ).h(40),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      "By Logging you agree to our"
                          .text
                          .textStyle(
                              TextStyle(color: Color(0xFF505050), fontSize: 11))
                          .black
                          .make(),
                      "terms and conditions"
                          .text
                          .orange500
                          .textStyle(
                              TextStyle(color: Color(0xFF505050), fontSize: 11))
                          .make(),
                    ],
                  ),
                ),
              ))

              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //
              //       color: Colors.white,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(50),
              //         topRight: Radius.circular(50),
              //       ),
              //
              //     ),
              //
              //     child: Column(
              //
              //       children: [
              //         ElevatedButton(
              //           onPressed: (){},
              //           style: ButtonStyle(
              //             backgroundColor: MaterialStateProperty.all(Colors.white),
              //             padding: MaterialStateProperty.all(EdgeInsets.all(5)),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               Image.asset("assets/images/google.png",fit: BoxFit.fitHeight,),
              //               "Continue with Google".text.make()
              //             ],
              //           ),
              //         ).h(40)
              //       ],
              //
              //     ),
              //
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCodeObject {
  AuthCodeObject({required this.code, required this.state});

  String code, state;
}

class UserObject {
  UserObject(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.profileImageUrl});

  String firstName, lastName, email, profileImageUrl;
}
