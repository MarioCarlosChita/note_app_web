class NoteDto {
  NoteDto({
    this.id,
    required this.description,
    this.isBold = false,
    this.isCompleted = false,
    this.isItalic = false,
    required this.title,
    required this.userId,
  });

  final int? id;
  final String title;
  final String description;
  final bool isBold;
  final bool isCompleted;
  final bool isItalic;
  final String userId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'title': title,
      'description': description,
      'isBold': isBold,
      'isCompleted': isCompleted,
      'isItalic': isItalic,
      'userId': userId,
    };
    return data;
  }
}
