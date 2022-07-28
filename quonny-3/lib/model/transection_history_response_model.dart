// ignore_for_file: non_constant_identifier_names
import 'package:intl/intl.dart';

class TransectionHostory {
  TransectionHostory(
      {this.id,
      this.amount,
      this.quoins,
      this.other_user_id,
      this.transection_type,
      this.created_date,
      this.modified_date,
      this.type,
      this.message,
      this.transection_id,
      this.currancy});
  String? id;
  int? amount;
  int? quoins;
  String? other_user_id;
  String? transection_type;
  DateTime? created_date;
  String? modified_date;
  String? type;
  String? message;
  String? transection_id;
  String? currancy;

  factory TransectionHostory.fromJson(Map<String, dynamic> json) =>
      TransectionHostory(
        id: json["id"],
        amount: json["amount"],
        quoins: json["quoins"],
        other_user_id: json["other_user_id"],
        transection_type: json["transection_type"],
        created_date: DateTime.parse(json["created_date"].toDate().toString()),
        modified_date: json["modified_date"],
        type: json["type"],
        message: json["message"],
        transection_id: json["transection_id"],
        currancy: json["currancy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "quoins": quoins,
        "other_user_id": other_user_id,
        "transection_type": transection_type,
        // "created_date": created_date,
        // "created_date":
        //     "${created_date?.year.toString().padLeft(4, '0')}-${created_date?.month.toString().padLeft(2, '0')}-${created_date?.day.toString().padLeft(2, '0')}",
        "modified_date": modified_date,
        "type": type,
        "message": message,
        "transection_id": transection_id,
        "currancy": currancy,
      };

  String FormattedDate() {
    var finaldate = "";
    if (created_date != null) {
      finaldate = DateFormat('dd MMM, yyyy hh:mm a')
          .format(DateTime.parse(created_date.toString()));
    } else {
      finaldate = "";
    }
    return finaldate;
  }
}
