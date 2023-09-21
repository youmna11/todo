import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String description;
  int date;
  String userId;
  bool isDone;

  TaskModel(
      {this.id = "",
        required this.title,
        required this.description,
        required this.date,
        required this.userId,
        this.isDone=false
      });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(

      id: json["id"],
      title: json["title"],
      description: json["description"],
      date: json["date"],
      userId: json["userId"],
      isDone: json["isDone"]
  );

  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "title":title,
      "description":description,
      "date":date,
      "userId":userId,
      "isDone":isDone
    };

  }
}
