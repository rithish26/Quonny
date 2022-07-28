import 'package:flutter/material.dart';

class MyColor {
  MyColor(
    this.color,
    this.quoins,
    this.prices,
  );

  Color? color;
  String? quoins;
  int? prices;

  static List<MyColor> QuonnyCoinsData() {
    var quoinPurchesList = <MyColor>[];
    quoinPurchesList.add(new MyColor(Color.fromRGBO(255, 138, 95, 1), "1", 1));
    quoinPurchesList
        .add(new MyColor(Color.fromRGBO(95, 100, 255, 1), "50", 50));
    quoinPurchesList
        .add(new MyColor(Color.fromRGBO(159, 95, 255, 1), "100", 100));
    quoinPurchesList
        .add(new MyColor(Color.fromRGBO(255, 95, 95, 1), "500", 450));
    quoinPurchesList
        .add(new MyColor(Color.fromRGBO(184, 112, 14, 1), "1000", 750));
    return quoinPurchesList;
  }
}
