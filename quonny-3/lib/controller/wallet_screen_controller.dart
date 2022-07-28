import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quonny_quonnect/model/transection_history_response_model.dart';

class WalletScreenController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  var totalCoins = 0.obs;
  var isrefresh = false.obs;
  DateTime updateDate = DateTime.now();
  var finalDates = ''.obs;
  var realName = ''.obs;
  var nickName = ''.obs;
  var avtar = ''.obs;
  var transectionLists = <TransectionHostory>[].obs;
  // var transectionList = [].obs;
  // TransectionHostory? transectionData;
  // List<TransectionHostory> transection = [];
  // var transectionList = [TransectionHostory].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
    getTransectionHistory();
    // getTransectionHistory();
  }

  // get user data
  getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        avtar.value = value['avatar'];
        realName.value = value['Realname'];
        nickName.value = value['nickname'];
        totalCoins.value = value['total_quoin'];
      }
    });
  }

  getTransectionHistory() async {
    isrefresh.value = true;
    final user = FirebaseAuth.instance.currentUser!;
    transectionLists.value = [];
    final fff = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transaction_history')
        .get()
        .then((value) {
      var docsss = value.docs;
      docsss.forEach((element) {
        isrefresh.value = false;
        var temp = element.data();
        transectionLists.add(TransectionHostory.fromJson(temp));
      });
    });
  }
}
