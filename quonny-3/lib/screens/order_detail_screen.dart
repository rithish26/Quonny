import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quonny_quonnect/cons/string_constant.dart';
import 'package:quonny_quonnect/controller/order_details_screen_controller.dart';
import 'package:quonny_quonnect/screens/quions_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String totalCoins;
  final int totalCost;
  final Function(bool status) callback;
  const OrderDetailsScreen(
      {Key? key,
      required this.totalCoins,
      required this.totalCost,
      required this.callback})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Razorpay razorpay;
  final user = FirebaseAuth.instance.currentUser;
  final quonnyQuoinCntrl = Get.put(OrderDetailsScreenController());
  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  //Mark: payment
  void openCheckout(int amount) async {
    print("rezorpayamount=====>$amount");
    var options = {
      'key': 'rzp_test_BN1AtxY6xN9i5T',
      'amount': amount * 100,
      'name': 'Quonny',
      'description': 'Testing',
      'prefill': {'contact': 'Test User', 'email': 'Testing@gmail.com'},
      'method': {
        'upi': true,
        'card': true,
        'netbanking': true,
        'wallet': true,
        'emi': true
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print("razor pay open");
      razorpay.open(options);
    } catch (e) {
      print("razorPay Catch=-=-=>$e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        "Success=---=>${response.paymentId} ${response.orderId} ${response.signature}");

    savePaymentDetails(response.paymentId ?? "");
    Fluttertoast.showToast(msg: "Payment Success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Error: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Razorpay External Wallet=-=->${response.walletName}");
    Fluttertoast.showToast(msg: "External Wallet: ${response.walletName}");
  }

  //paymentdata Store in firebase transection history table
  void savePaymentDetails(String transectionId) {
    print("savePayments");
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('transaction_history')
        .doc();
    ref.set({
      'id': ref.id,
      'quoins': int.parse(widget.totalCoins),
      'created_date': new DateTime.now(),
      'amount': widget.totalCost,
      'currancy': 'Inr',
      'modified_date': null,
      'other_user_id': null,
      'type': strConst.wallet,
      'transection_id': transectionId,
      'message': strConst.msgWallet,
      'transection_type': strConst.credit
    });
    increaseTotalCoins(int.parse(widget.totalCoins));
  }

  Future<void> increaseTotalCoins(int coins) async {
    print("addcoins");
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "total_quoin": FieldValue.increment(coins),
      'created': new DateTime.now()
    });
    widget.callback(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Order Details',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Quoin",
                  style: TextStyle(
                    color: Color.fromRGBO(137, 137, 137, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                ),
                Text(
                  "${widget.totalCoins}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Cost",
                  style: TextStyle(
                    color: Color.fromRGBO(137, 137, 137, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                ),
                Text(
                  "Rs. ${widget.totalCost}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: TextStyle(
                    color: Color.fromRGBO(137, 137, 137, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                ),
                Text(
                  "-",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 115, 65, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("amount==-=->${widget.totalCost}");
                      openCheckout(widget.totalCost);
                      // print(
                      //     "${quonnyQuoinCntrl.selectedAmount.obs.value.value}");
                      // quonnyQuoinCntrl.amount.value =
                      //     quonnyQuoinCntrl.selectedAmount.obs.value.value;
                      // quonnyQuoinCntrl.coin.value =
                      //     quonnyQuoinCntrl.selectedCoins.obs.value.value;
                      // print(
                      //     "selectedCoinsStoreDatabse===>${quonnyQuoinCntrl.coin.value}");
                      // print(
                      //     "selectedamountStoreDatabse===>${quonnyQuoinCntrl.amount.obs.value}");
                      // print(
                      //     "onTap==>${quonnyQuoinCntrl.selectedAmount.obs.value.value}");
                    },
                    child: Center(
                      child: Text(
                        "PROCEED TO PAY",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: GoogleFonts.openSans().fontFamily),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
