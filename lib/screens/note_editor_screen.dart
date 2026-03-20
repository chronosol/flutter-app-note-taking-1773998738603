import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rich_text_editor/flutter_rich_text_editor.dart';
import '../services/note_service.dart';
import '../models/note.dart';

class NoteEditorScreen extends StatelessWidget {
  final Note? note;
  final TextEditingController _titleController = TextEditingController();
  final RichTextController _contentController = RichTextController();

  NoteEditorScreen({this.note}) {
    if (note != null) {
      _titleController.text = note!.title;
      _contentController.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteService = Provider.of<NoteService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
                final newNote = Note(
                  title: _titleController.text,
                  content: _contentController.text,
                  lastEdited: DateTime.now(),
                );
                note == null ? noteService.addNote(newNote) : noteService.updateNote(note!.id, newNote);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(height: 10),
            RichTextEditor(
              controller: _contentController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }
}
