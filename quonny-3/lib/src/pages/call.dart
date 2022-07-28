// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quonny_quonnect/cons/string_constant.dart';
import 'package:quonny_quonnect/utils/routes.dart';

import '../utils/settings.dart';

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName;
  final String? token;
  final String? reference;
  final String? myid;
  final String? hisid;

  /// non-modifiable client role of the page
  final ClientRole? role;

  /// Creates a call page with given channel name.
  const CallPage({
    Key? key,
    this.token,
    this.channelName,
    this.role,
    this.reference,
    this.myid,
    this.hisid,
  }) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  late RtcEngine _engine;
  Timer? timer;
  bool blur = true;
  String text = "";
  String totalQuoin = "";
  Duration duration = Duration();
  String tim = "";
  int flag = 1;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    // clear users

    _users.clear();
    // destroy sdk

    _engine.leaveChannel();
    _engine.destroy();
    timer?.cancel();
    super.dispose();
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      print("final second====>$seconds");

      duration = Duration(seconds: seconds);
      print("duration=-=-=-=->$duration");
    });
  }

  Future<void> dicreaseCoinsForConnectCall(int coins) async {
    print("addcoins");
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "total_quoin": FieldValue.increment(coins),
      'created': new DateTime.now()
    });
    savePaymentDetails();
  }

  void savePaymentDetails() {
    print("savePayments");
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('transaction_history')
        .doc();
    ref.set({
      'id': ref.id,
      'quoins': 5,
      'created_date': new DateTime.now(),
      'amount': 0,
      'currancy': 'Inr',
      'modified_date': null,
      'other_user_id': null,
      'type': strConst.call,
      'transection_id': null,
      'message': strConst.msgCall,
      'transection_type': strConst.debit
    });
  }

  startTimer() {
    print("timer start");
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());

    dicreaseCoinsForConnectCall(-5);
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    Future.delayed(const Duration(minutes: 5), () async {
      _onCallEnd(context);
    });
    startTimer();
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token, widget.channelName!, null, 0);
    print("channel name=-=-=-=->${widget.channelName}");
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      print("userJoined successfully");
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
        print("call joining info=-=-=-=->${info}");
        print("infostring====>$_infoStrings");
      });
    }, leaveChannel: (stats) {
      print("leave channel");
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      print("userJoined");
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
        print("userjoined====>$_users");
        print("join user id===>$info");
      });
    }, userOffline: (uid, elapsed) {
      print("userOffline");
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      print("first remote video call");
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(
          uid: uid,
          channelId: '',
        )));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  List<Widget> getrender() {
    return _getRenderViews();
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      /* case 1:
        return Container(
            child: Column(
          children: <Widget>[
            _videoView(views[0]),
          ],
        )); */
      case 2:
        setState(() {
          flag = 2;
        });
        final wrappedViews = views.map<Widget>(_videoView).toList();
        /* return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]]),
          ],
        )); */
        return Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Center(child: views[1]),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.66,
                left: MediaQuery.of(context).size.width * 0.07,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 110,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: views[0],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      /* child: Column(
          children: <Widget>[

            _videoView([views[0]]),
            _videoView([views[1]]),
          ],
        ) */

      /* default:
        Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        )); */
    }
    if (flag == 2) {
      _onCallEnd(context);
    }
    return Container(
        child: Column(
      children: <Widget>[_videoView(views[0])],
    ));
  }

  /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.white,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 30.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.white,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.black,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Text(
                    "null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onCallEnd(BuildContext context) async {
    FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.reference)
        .delete();
    timer?.cancel();
    if (flag == 2 || flag == 3) {
      final user = FirebaseAuth.instance.currentUser;
      final t = FirebaseFirestore.instance.collection('Calls').doc();
      String name = "";
      String country = "";
      String avatar = "";
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.hisid)
          .get()
          .then((DocumentSnapshot value) {
        if (value.exists) {
          setState(() {
            name = value['nickname'];
            country = value['country'];
            avatar = value['avatar'];
          });
          print(country);
        }
      });
      await t.set({
        'hisid': widget.hisid,
        'myid': widget.myid,
        'duration': tim,
        'dateCreated': DateTime.now(),
        'id': t.id,
        'hisname': name,
        'hiscountry': country,
        'avatar': avatar,
      });
    }
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    setState(() {
      tim = '$minutes min : $seconds sec';
    });
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  '$minutes:$seconds',
                  style: TextStyle(
                      fontSize: 30,
                      backgroundColor: Colors.deepOrange,
                      color: Colors.white),
                ),
              ),
            ),
            /*  _panel(), */
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
