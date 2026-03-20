import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteService with ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void fetchNotes() async {
    final snapshot = await FirebaseFirestore.instance.collection('notes').get();
    _notes.clear();
    for (var document in snapshot.docs) {
      _notes.add(Note(
        id: document.id,
        title: document['title'],
        content: document['content'],
        lastEdited: (document['lastEdited'] as Timestamp).toDate(),
      ));
    }
    notifyListeners();
  }

  void addNote(Note note) async {
    final doc = await FirebaseFirestore.instance.collection('notes').add({
      'title': note.title,
      'content': note.content,
      'lastEdited': note.lastEdited,
    });
    _notes.add(Note(
      id: doc.id,
      title: note.title,
      content: note.content,
      lastEdited: note.lastEdited,
    ));
    notifyListeners();
  }

  void updateNote(String id, Note newNote) async {
    await FirebaseFirestore.instance.collection('notes').doc(id).update({
      'title': newNote.title,
      'content': newNote.content,
      'lastEdited': newNote.lastEdited,
    });
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = newNote;
      notifyListeners();
    }
  }
}
