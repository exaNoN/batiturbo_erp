// To parse this JSON data, do
//
//     final turbo = turboFromJson(jsonString);

import 'dart:convert';

List<Turbo> turboFromJson(String str) =>
    List<Turbo>.from(json.decode(str).map((x) => Turbo.fromJson(x)));

String turboToJson(List<Turbo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Turbo {
  Turbo({
    this.id,
    this.name,
    this.code,
    this.tanim1,
    this.tanim2,
    this.photourl,
    this.createdBy,
  });

  dynamic id;
  dynamic name;
  dynamic code;
  dynamic tanim1;
  dynamic tanim2;
  dynamic photourl;
  dynamic createdBy;

  factory Turbo.fromJson(Map<String, dynamic> json) => Turbo(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        tanim1: json["tanim1"],
        tanim2: json["tanim2"],
        photourl: json["photourl"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "tanim1": tanim1,
        "tanim2": tanim2,
        "photourl": photourl,
        "created_by": createdBy,
      };
}
