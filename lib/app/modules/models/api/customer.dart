// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.id,
    required this.name,
    required this.phone,
    this.email,
    this.vkn,
    this.debt,
    this.createdBy,
    this.createdAt,
    this.isComplated,
  });

  dynamic id;
  String name;
  String phone;
  dynamic email;
  dynamic vkn;
  dynamic debt;
  dynamic createdBy;
  dynamic createdAt;
  dynamic isComplated;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        vkn: json["vkn"],
        debt: json["debt"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        isComplated: json["is_complated"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email == null ? "" : email,
        "vkn": vkn == null ? "" : vkn,
        "debt": debt == null ? "0" : debt,
        "created_by": createdBy == null ? "1" : createdBy,
        "is_complated": isComplated == null ? false : isComplated,
      };
}
