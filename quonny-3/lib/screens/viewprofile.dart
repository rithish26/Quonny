import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quonny_quonnect/src/pages/call.dart';
import 'package:velocity_x/velocity_x.dart';

class Viewprofile extends StatefulWidget {
  const Viewprofile({Key? key}) : super(key: key);

  @override
  _ViewprofileState createState() => _ViewprofileState();
}

class _ViewprofileState extends State<Viewprofile> {
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
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
              width: MediaQuery.of(context).size.width * 0.22,
            ),
            Text(
              'nick.t',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: new DecorationImage(
                            image: new AssetImage(
                                "assets/images/demoprofile.jpeg"),
                            fit: BoxFit.fill,
                          )),
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Image.asset(
                                    'assets/images/avatars/avatar5.png',
                                    fit: BoxFit.fitWidth,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text('Nikita Biswas',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 2),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 2),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text('San Francisco, USA',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal))),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi dignissim et velit ipsum dolor sit amet, co nsectetur adipiscing elit.',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text('Contact',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text('+91 - 7652038775',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Icon(
                          Icons.mail,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text('nikita.biswas3272@gmail.com',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal))),
                        ),
                      ),
                    ],
                  ),
                ],
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
                    onPressed: () async {
                      await _handleCameraAndMic(Permission.camera);
                      await _handleCameraAndMic(Permission.microphone);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallPage(
                            channelName: 'Test',
                            role: ClientRole.Broadcaster,
                          ),
                        ),
                      );
                    },
                    child: "START VIDEO CALL".text.xl.make(),
                  ).p(20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
