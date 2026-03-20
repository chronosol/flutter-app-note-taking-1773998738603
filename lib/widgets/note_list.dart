import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/note_service.dart';
import '../models/note.dart';
import '../screens/note_editor_screen.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteService>(context).notes;

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];

        return ListTile(
          title: Text(note.title),
          subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditorScreen(note: note),
              ),
            );
          },
        );
      },
    );
  }
}
