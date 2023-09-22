import 'package:flutter/material.dart';
import 'package:sq_flite_package_grid_wiev/data/local/local_sqflite.dart';
import '../data/local/model/notes_model.dart';
import 'edit_note_page.dart';


class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({Key? key, required this.noteId}) : super(key: key);
  final int noteId;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    note = await LocalDatabase.instance.readNote(widget.noteId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [editButton(),deleteButton()],),

    );
  }




  Widget editButton() => IconButton(
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));
        refreshNote();
      },
      icon: const Icon(Icons.edit));

  Widget deleteButton() => IconButton(
      onPressed: () async {
        await LocalDatabase.instance.delete(widget.noteId);
        refreshNote();
      },
      icon: const Icon(Icons.delete));
}
