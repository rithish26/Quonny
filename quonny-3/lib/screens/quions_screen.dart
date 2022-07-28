import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quonny_quonnect/model/colors_model.dart';
import 'package:quonny_quonnect/screens/order_detail_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class QuoinsQuoinScreen extends StatefulWidget {
  final Function(bool status) callback;
  const QuoinsQuoinScreen({Key? key, required this.callback}) : super(key: key);

  @override
  State<QuoinsQuoinScreen> createState() => _QuoinsQuoinScreenState();
}

class _QuoinsQuoinScreenState extends State<QuoinsQuoinScreen> {
  final List<MyColor> quonnyCoins = MyColor.QuonnyCoinsData();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              'Quonny Quoins',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.77,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 10 / 16,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: quonnyCoins.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          OrderDetailsScreen(
                            totalCoins: quonnyCoins[index].quoins ?? "",
                            totalCost: quonnyCoins[index].prices ?? 0,
                            callback: widget.callback,
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: quonnyCoins[index].color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Image.asset(
                                    "assets/images/quoin_images.png",
                                  ),
                                ),
                              ),
                              Text(
                                "${quonnyCoins[index].quoins} Quoins",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(40),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      child: Text(
                                        "Buy For",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.openSans().fontFamily,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Rs. ${quonnyCoins[index].prices}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            fontFamily: GoogleFonts.openSans()
                                                .fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
