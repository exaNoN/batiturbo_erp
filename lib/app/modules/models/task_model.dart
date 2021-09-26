// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
    Task({
        required this.id,
        required this.jid,
        required this.tanim1,
        required this.tanim2,
        required this.harcama,
        required this.photourl1,
        required this.photourl2,
        required this.photourl3,
        required this.turbo,
        required this.createdBy,
        required this.createdAt,
        required this.updatedBy,
        required this.updatedAt,
    });

    int id;
    int jid;
    String tanim1;
    String tanim2;
    String harcama;
    String photourl1;
    String photourl2;
    String photourl3;
    String turbo;
    String createdBy;
    DateTime createdAt;
    String updatedBy;
    DateTime updatedAt;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        jid: json["jid"],
        tanim1: json["tanim1"],
        tanim2: json["tanim2"],
        harcama: json["harcama"],
        photourl1: json["photourl1"],
        photourl2: json["photourl2"],
        photourl3: json["photourl3"],
        turbo: json["turbo"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jid": jid,
        "tanim1": tanim1,
        "tanim2": tanim2,
        "harcama": harcama,
        "photourl1": photourl1,
        "photourl2": photourl2,
        "photourl3": photourl3,
        "turbo": turbo,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
    };
}
