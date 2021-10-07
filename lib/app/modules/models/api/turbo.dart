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
    required this.description,
    this.code,
    this.photoUrl,
    required this.createdBy,
    this.createdAt,
  });

  dynamic id;
  String description;
  dynamic code;
  dynamic photoUrl;
  dynamic createdBy;
  dynamic createdAt;

  factory Turbo.fromJson(Map<String, dynamic> json) => Turbo(
        id: json["id"],
        description: json["description"],
        code: json["code"],
        photoUrl: json["photoUrl"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "code": code == null ? "" : code,
      "photoUrl": photoUrl == null ? "" : photoUrl,
      "created_by": createdBy,
      "created_at": createdAt,
    };
  }
}
