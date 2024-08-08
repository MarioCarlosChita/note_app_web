import 'package:flutter/material.dart';

enum NoteStatus {
  working,
  completed,
}

class NoteStatusWidget extends StatelessWidget {
  const NoteStatusWidget({
    required this.noteStatus,
    super.key,
  });

  final NoteStatus noteStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: noteStatus == NoteStatus.completed
            ? Colors.green
            : Colors.grey.withOpacity(0.3),
      ),
      child: Text(
        noteStatus.name,
        style: TextStyle(
          color:
              noteStatus == NoteStatus.completed ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
