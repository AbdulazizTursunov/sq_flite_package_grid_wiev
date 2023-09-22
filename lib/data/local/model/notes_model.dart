import 'package:flutter/cupertino.dart';

class NoteFields {

  static const List<String> value = [id,isImportant,number,title,description,time];
  static const String id = "_id";
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';

  static const String tableName = "notes";
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  Note({
    required this.title,
    this.id,
    required this.number,
    required this.description,
    required this.createdTime,
    required this.isImportant,
  });

  factory Note.fromJson(Map<String, dynamic> json){
    debugPrint("fromJson ok");
    return Note(
      title: json [NoteFields.title] as String ? ?? "",
      number: json [NoteFields.number] as int? ?? 0,
      description: json [NoteFields.description] as String ? ?? "",
      createdTime: DateTime.parse(json[NoteFields.time] as String),
      isImportant: json [NoteFields.isImportant] == 1,
    );
  }



Map<String, dynamic> toJson() =>
    {
      NoteFields.id: id,
      NoteFields.title: title,
      NoteFields.isImportant: isImportant ? 1 : 0,
      NoteFields.number: number,
      NoteFields.description: description,
      NoteFields.time: createdTime.toIso8601String(),
    };


Note copyWith({
  int? id,
  bool? isImportant,
  int? number,
  String? title,
  String? description,
  DateTime? createdTime,
}) =>
    Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime
    );}
