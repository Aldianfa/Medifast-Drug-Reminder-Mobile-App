import 'package:flutter/material.dart';

class ReminderInfo {
  int? id;
  String? title;
  DateTime? reminderDateTime;
  bool? isPending;
  int? gradientColorIndex;

  ReminderInfo({
    this.id,
      this.title,
      this.reminderDateTime,
      this.isPending,
      this.gradientColorIndex
  });

  factory ReminderInfo.fromMap(Map<String, dynamic> json) => ReminderInfo(
        id: json["id"],
        title: json["title"],
        reminderDateTime: DateTime.parse(json["reminderDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "reminderDateTime": reminderDateTime!.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}