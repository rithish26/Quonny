import 'package:flutter/material.dart';

class Revealrequests extends StatefulWidget {
  const Revealrequests({Key? key}) : super(key: key);

  @override
  _RevealrequestsState createState() => _RevealrequestsState();
}

class _RevealrequestsState extends State<Revealrequests> {
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
              width: MediaQuery.of(context).size.width * 0.11,
            ),
            Text(
              'reveal requests',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(right: 10),
              primary: true,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
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
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Image.asset(
                                  'assets/images/avatars/avatar2.png',
                                  fit: BoxFit.fitWidth,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.012,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('miss.darla',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('China',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.3),
                                        )),
                                  ]),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Accepted',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w400)),
                              Text('Status',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(0.3),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
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
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Image.asset(
                                  'assets/images/avatars/avatar2.png',
                                  fit: BoxFit.fitWidth,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.012,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('miss.darla',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('China',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.3),
                                        )),
                                  ]),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pending',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFFC7341),
                                      fontWeight: FontWeight.w400)),
                              Text('Status',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(0.3),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
