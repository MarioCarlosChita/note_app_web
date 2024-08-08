import 'package:flutter/material.dart';

import '../../../../../../core/extentions/string_extention.dart';
import '../../../../domain/entities/note_entity.dart';
import 'note_status_widget.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget({
    required this.onConfirmButtonPressed,
    required this.onRemoveButtonPressed,
    this.isSelected = false,
    required this.note,
    super.key,
  });

  final NoteEntity note;
  final bool isSelected;
  final VoidCallback onConfirmButtonPressed;
  final VoidCallback onRemoveButtonPressed;

  String noteDate(DateTime date) {
    return '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blueAccent.withOpacity(0.75)
            : Colors.grey.withOpacity(
                0.06,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  note.description,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 11,
                    fontStyle:
                        note.isItalic ? FontStyle.italic : FontStyle.normal,
                    fontWeight:
                        note.isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    NoteStatusWidget(
                      noteStatus: note.isCompleted
                          ? NoteStatus.completed
                          : NoteStatus.working,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      noteDate(note.createdAt.parseStringToDate()),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.black.withOpacity(0.8),
                        fontSize: 9,
                      ),
                    ),
                    const Spacer(),
                    isSelected
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: onConfirmButtonPressed,
                                icon: Icon(
                                  note.isCompleted
                                      ? Icons.restore_outlined
                                      : Icons.done_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconButton(
                                onPressed: onRemoveButtonPressed,
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
