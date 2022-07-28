import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quonny_quonnect/controller/wallet_screen_controller.dart';
import 'package:quonny_quonnect/screens/quions_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import 'notifications.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final obj = Get.put(WalletScreenController());

  @override
  Widget build(BuildContext context) {
    // const shimmerGradient = LinearGradient(
    //   colors: [
    //     Color.fromARGB(255, 235, 235, 242),
    //     Color(0xFFF4F4F4),
    //     Color.fromARGB(255, 221, 221, 224),
    //   ],
    //   stops: [
    //     0.1,
    //     0.3,
    //     0.4,
    //   ],
    //   begin: Alignment(-1.0, -0.3),
    //   end: Alignment(1.0, 0.3),
    //   tileMode: TileMode.clamp,
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Wallet"
                              .text
                              .semiBold
                              .fontFamily(GoogleFonts.openSans().fontFamily!)
                              .textStyle(TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900))
                              .make()
                              .pLTRB(20, 20, 20, 0),
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
                                        builder: (context) => Notifications(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.notifications,
                                    color: Color(0xFFAAAAAA),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: "Spending with quonny wallet"
                            .text
                            .fontFamily(GoogleFonts.openSans().fontFamily!)
                            .textStyle(TextStyle(
                              fontSize: 15,
                            ))
                            .make()
                            .p(5),
                      ),
                    ]),
              ),
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoinsQuoinScreen(
                      callback: (bool status) {
                        if (status == true) {
                          obj.getUserData();
                          obj.getTransectionHistory();
                        }
                      },
                    ),
                  ),
                );
                // openCheckout();
                print("card tap");
              },
              child: Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              // child: Image.network(obj.avtar.obs.value.value),
                              child: Image.asset(
                                obj.avtar.obs.value.value,
                                fit: BoxFit.fitWidth,
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(obj.realName.obs.value.value,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('@${obj.nickName.obs.value}',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          Icon(Icons.reply_outlined, color: Colors.white),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/images/chip.png',
                            fit: BoxFit.fitWidth,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Balance',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('${obj.totalCoins} Quoins',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text("",
                                    // "updated${obj.transectionLists.last.FormattedDate()}",
                                    // 'updated ${DateFormat("dd MMM, yy").format(DateTime.parse(obj.transectionLists.last.created_date.toString()))}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffEB7242),
                        Color(0xffEA654E),
                        /*  Color(0xff405DE6),
                    Color(0xff5851DB),
                    Color(0xff833AB4),
                    Color(0xffC13584),
                    Color(0xffE1306C),
                    Color(0xffFD1D1D),
                    Color(0xffF56040),
                    Color(0xffF77737),
                    Color(0xffFCAF45),
                    Color(0xffFFDC80), */
                      ],
                    ),
                    color: Colors.grey[300],
                    boxShadow: [
                      /* BoxShadow(
                            color: Colors.grey,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0), */
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Text('History',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Unicon(
                Unicons.uniCalendarAlt,
                color: Colors.deepOrange,
              ),
            ),
            /* Icon(
                Icons.calendar_today_outlined,
                color: Colors.orange,
                size: 30,
              ) */
          ]),
          Expanded(
              child: Obx(
            () => obj.isrefresh.obs.value == true.obs
                ? Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(252, 115, 65, 1)),
                  )
                // Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Shimmer.fromColors(
                //         baseColor: Colors.grey.shade300,
                //         highlightColor: Colors.grey.shade100,
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             // height: 30,
                //             // width: 30,
                //             color: Colors.red,
                //           ),
                //         )),
                //   )
                : ListView.builder(
                    itemCount: obj.transectionLists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Image.asset(
                                          'assets/images/avatars/avatar3.png',
                                          fit: BoxFit.fitWidth,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  obj.transectionLists[index]
                                                          .message ??
                                                      "",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  obj.transectionLists[index]
                                                      .FormattedDate(),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                  )),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  // "",
                                  "${obj.transectionLists[index].transection_type == "CREDIT" ? "+" : "-"} ${obj.transectionLists[index].quoins} Quoins",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: obj.transectionLists[index]
                                                  .transection_type ==
                                              "CREDIT"
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )),
        ],
      ),
      // ),
    );
  }
}
