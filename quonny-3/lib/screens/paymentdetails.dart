import 'package:flutter/material.dart';

class Paymentdetails extends StatefulWidget {
  const Paymentdetails({Key? key}) : super(key: key);

  @override
  _PaymentdetailsState createState() => _PaymentdetailsState();
}

class _PaymentdetailsState extends State<Paymentdetails> {
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
                width: MediaQuery.of(context).size.width * 0.12,
              ),
              Text(
                'payment details',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return Container();
            })
                /*ListView(
                padding: EdgeInsets.only(right: 10),
                primary: true,
                shrinkWrap: true,
                children: [
                  Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          Text('Payed to view profile',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '-50 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
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
                                          Text('Added to wallet',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '+100 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
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
                                          Text('Reward Recieved',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '+200 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/avatars/avatar1.png',
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
                                          Text('Payed to Extend Call',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '-20 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          Text('Payed to view profile',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '-50 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
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
                                          Text('Added to wallet',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '+100 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/quonnyLogo.png',
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
                                          Text('Reward Recieved',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '+200 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/images/avatars/avatar1.png',
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
                                          Text('Payed to Extend Call',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text('13 Mar\'21',
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
                            Text(
                              '-20 coins',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/
                ),
          ],
        ));
  }
}
