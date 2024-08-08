import 'package:flutter/material.dart';

import 'note_item_skeleton_widget.dart';

class ListNoteLoadingWidget extends StatelessWidget {
  const ListNoteLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size kDeviceSize = MediaQuery.of(context).size;

    return LimitedBox(
      maxHeight: kDeviceSize.height - kToolbarHeight - 5 * 64,
      child: ListView(
        children: const [
          NoteItemSkeleton(),
          NoteItemSkeleton(),
          NoteItemSkeleton(),
        ],
      ),
    );
  }
}
