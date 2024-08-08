import '../../domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.description,
    required super.isBold,
    required super.isCompleted,
    required super.isItalic,
    required super.title,
    required super.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isBold: json['isBold'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isItalic: json['isItalic'] as bool? ?? false,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }
}
