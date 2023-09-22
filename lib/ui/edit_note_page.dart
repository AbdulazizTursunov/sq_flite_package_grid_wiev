import 'package:flutter/material.dart';
import 'package:sq_flite_package_grid_wiev/data/local/local_sqflite.dart';

import '../data/local/model/notes_model.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNot();
      }
    }
    Navigator.of(context).pop();
  }

  Future updateNote() async {
    final note = widget.note.copyWith(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description);
    await LocalDatabase.instance.update(note);
  }

  Future addNot() async {
    final note = Note(
        title: title,
        number: number,
        description: description,
        createdTime: DateTime.now(),
        isImportant: true);
    await LocalDatabase.instance.create(note);

  }
}
