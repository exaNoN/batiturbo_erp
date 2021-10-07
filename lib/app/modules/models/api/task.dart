// To parse this JSON data, do
//a
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    this.id,
    required this.description,
    this.paymentId,
    required this.jobId,
    this.createdBy,
    required this.updatedBy,
    this.photoUrl1,
    this.photoUr2,
    this.photoUr3,
    required this.isComplated,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  dynamic id;
  String description;
  dynamic paymentId;
  String jobId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic photoUrl1;
  dynamic photoUr2;
  dynamic photoUr3;
  dynamic isComplated;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        description: json["description"],
        paymentId: json["payment_id"],
        jobId: json["job_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        photoUrl1: json["photoUrl1"],
        photoUr2: json["photoUr2"],
        photoUr3: json["photoUr3"],
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
        "payment_id": paymentId == null ? "0" : paymentId,
        "job_id": jobId,
        "created_by": createdBy == null ? "1" : createdBy,
        "updated_by": updatedBy == null ? "1" : updatedBy,
        "photoUrl1": photoUrl1 == null ? "" : photoUrl1,
        "photoUr2": photoUr2 == null ? "" : photoUr2,
        "photoUr3": photoUr3 == null ? "" : photoUr3,
        "is_complated": isComplated == null ? false : isComplated,
        "createdAt": createdAt == null ? "" : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? "" : updatedAt.toIso8601String(),
        "deletedAt": deletedAt == null ? "" : deletedAt.toIso8601String(),
      };
}
