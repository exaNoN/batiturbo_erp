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
    required this.description,
    this.offer,
    this.deadline,
    required this.customerId,
    this.turboId,
    this.createdBy,
    this.updatedBy,
    required this.isComplated,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  dynamic id;
  String description;
  dynamic offer;
  dynamic deadline;
  String customerId;
  dynamic turboId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic isComplated;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        description: json["description"],
        offer: json["offer"],
        deadline: DateTime.parse(json["deadline"]),
        customerId: json["customer_id"],
        turboId: json["turbo_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isComplated: json["is_complated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "offer": offer == null ? "0" : offer,
        "deadline": deadline == null ? "2021-10-07T10:10:32.996Z" : deadline,
        "customer_id": customerId,
        "turbo_id": turboId == null ? "1" : turboId,
        "created_by": createdBy == null ? "1" : createdBy,
        "updated_by": updatedBy == null ? "1" : updatedBy,
        "is_complated": isComplated == null ? false : isComplated,
      };
}
