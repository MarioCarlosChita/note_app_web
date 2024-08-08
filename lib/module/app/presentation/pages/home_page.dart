import 'package:flutter/material.dart';

import '../../../note/domain/entities/note_entity.dart';
import '../../../note/presentation/widgets/add_and_edit/add_and_edit_note_widget.dart';
import '../../../note/presentation/widgets/notes_lists/notes_list_widget.dart';
import '../widgets/app_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NoteEntity? _selectedNote;

  final TextEditingController noteDescriptionTextController =
      TextEditingController();
  final TextEditingController noteTitleTextController = TextEditingController();

  void _onSelectedNote(NoteEntity note) {
    setState(() {
      _selectedNote = note;
    });
  }

  void _onResetSelectedNote() {
    setState(() {
      _selectedNote = null;
    });
    noteDescriptionTextController.clear();
    noteTitleTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Column(
        children: [
          const AppBarWidget(),
          const SizedBox(
            height: 64,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
            ),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotesListWidget(
                  onResetSelectedNote: _onResetSelectedNote,
                  onSelectedNote: _onSelectedNote,
                  selectedNote: _selectedNote,
                ),
                const SizedBox(
                  width: 32,
                ),
                AddAndEditNoteWidget(
                  selectedNote: _selectedNote,
                  onResetSelectedNote: _onResetSelectedNote,
                  noteDescriptionTextController: noteDescriptionTextController,
                  noteTitleTextController: noteTitleTextController,
                  key: UniqueKey(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    noteDescriptionTextController.dispose();
    noteTitleTextController.dispose();
    super.dispose();
  }
}
