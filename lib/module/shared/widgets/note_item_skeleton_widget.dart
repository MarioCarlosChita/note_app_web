import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../note/presentation/widgets/notes_lists/widget/note_status_widget.dart';

class NoteItemSkeleton extends StatelessWidget {
  const NoteItemSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(
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
                  const Text(
                    "Salsile project brief",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "No, going all project let me show me you images of the project.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const NoteStatusWidget(
                        noteStatus: NoteStatus.completed,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "10-08-2024",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
