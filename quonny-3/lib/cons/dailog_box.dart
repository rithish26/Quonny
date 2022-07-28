import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quonny_quonnect/screens/confirmrequest.dart';
import 'package:quonny_quonnect/screens/quions_screen.dart';

popupDailigBox(BuildContext context, String msg) {
  return AlertDialog(
    insetPadding: EdgeInsets.all(25),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
    ),
    title: Text('Quonny Quoins',
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height * 0.09;
        var width = MediaQuery.of(context).size.width * 2;
        return Container(
          // height: height,
          // width: width,
          child: Text(
            msg,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.openSans().fontFamily!,
            ),
          ),
        );
      },
    ),
    actions: <Widget>[
      Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuoinsQuoinScreen(
                            callback: (bool status) {},
                          )),
                );
              },
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    border: Border.all(
                      color: Colors.deepOrange,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text('Yes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Align(
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
        ],
      ),
    ],
  );
}

Future transection(
    BuildContext context, int totalQuoin, Function isStatus) async {
  if (totalQuoin < 5) {
    showDialog(
      context: context,
      builder: (BuildContext context) => popupDailigBox(
        context,
        "You don't have sufficient quoins, \nDo you want to buy more quoins",
      ),
    );
  } else {
    isStatus();
  }
}
