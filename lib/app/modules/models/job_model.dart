// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

List<Job> jobFromJson(String str) =>
    List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));

String jobToJson(List<Job> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
  Job({
    this.id,
    this.tanim1,
    required this.musteri,
    this.tanim2,
    this.teklif,
    this.photourl,
    this.turbo,
    this.createdBy,
    this.createdAt,
  });

  dynamic id;
  dynamic tanim1;
  dynamic tanim2;
  dynamic musteri;
  dynamic teklif;
  dynamic photourl;
  dynamic turbo;
  dynamic createdBy;
  dynamic createdAt;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        tanim1: json["tanim1"],
        musteri: json["musteri"],
        tanim2: json["tanim2"],
        teklif: json["teklif"],
        photourl: json["photourl"],
        turbo: json["turbo"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanim1": tanim1,
        "musteri": musteri,
        "tanim2": tanim2,
        "teklif": teklif,
        "photourl": photourl,
        "turbo": turbo,
        "created_by": createdBy,
        "created_at": createdAt,
      };
}
