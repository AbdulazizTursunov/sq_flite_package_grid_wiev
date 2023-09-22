import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sq_flite_package_grid_wiev/data/local/local_sqflite.dart';
import 'package:sq_flite_package_grid_wiev/ui/edit_note_page.dart';


import '../data/local/model/notes_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Note> note;
  late Note notes;
  bool isLoading = false;

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    LocalDatabase.instance.close();
    super.dispose();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    note = await LocalDatabase.instance.readAll();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Page"),
        actions: [Icon(Icons.search)],
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : note.isEmpty
              ? Center(child: Text("data not found"))
              : StaggeredGrid.count(crossAxisCount: 4,

          )),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: notes),));
        refreshNote();
      }),
    );
  }

  Widget buildNotes() {
  return Text('data');}
}

