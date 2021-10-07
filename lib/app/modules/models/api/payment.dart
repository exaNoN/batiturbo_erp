// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  Payment({
    this.id,
    required this.amount,
    required this.paymentMethod,
    required this.taskId,
    required this.createdBy,
    this.createdAt,
  });

  dynamic id;
  String amount;
  String paymentMethod;
  String taskId;
  String createdBy;
  dynamic createdAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        taskId: json["task_id"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "payment_method": paymentMethod == null ? "nakit" : paymentMethod,
        "task_id": taskId,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
      };
}
