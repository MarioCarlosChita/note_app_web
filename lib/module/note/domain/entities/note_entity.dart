import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  const NoteEntity({
    required this.id,
    required this.description,
    required this.isBold,
    required this.isCompleted,
    required this.isItalic,
    required this.title,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String description;
  final bool isBold;
  final bool isCompleted;
  final bool isItalic;
  final String createdAt;

  @override
  List<dynamic> get props => <dynamic>[
        id,
        title,
        description,
        isBold,
        isCompleted,
        isItalic,
        createdAt,
      ];
}
