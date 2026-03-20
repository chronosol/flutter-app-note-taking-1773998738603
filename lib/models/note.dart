class Note {
  final String id;
  final String title;
  final String content;
  final DateTime lastEdited;

  Note({
    required this.title,
    required this.content,
    required this.lastEdited,
    String? id,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();
}
