import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/guard_route_service.dart';
import '../../../../../core/services/snackbar_service.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../shared/dtos/note_dto.dart';
import '../../../domain/entities/note_entity.dart';
import '../../blocs/note_bloc.dart';
import '../../blocs/note_event.dart';
import '../../blocs/note_state.dart';

class AddAndEditNoteWidget extends StatefulWidget {
  const AddAndEditNoteWidget({
    required this.noteDescriptionTextController,
    required this.noteTitleTextController,
    required this.onResetSelectedNote,
    required this.selectedNote,
    super.key,
  });

  final NoteEntity? selectedNote;
  final VoidCallback onResetSelectedNote;
  final TextEditingController noteDescriptionTextController;
  final TextEditingController noteTitleTextController;

  @override
  State<AddAndEditNoteWidget> createState() => _AddAndEditNoteWidgetState();
}

class _AddAndEditNoteWidgetState extends State<AddAndEditNoteWidget> {
  bool _isBoldText = false;
  bool _isItalic = false;
  bool _isDescriptionEmpty = false;
  bool _isTitleEmpty = false;

  void _onLoadNotes() {
    context.read<NoteBloc>().add(NotesRequested(
          userId: GuardRouteService.currentUser?.id ?? '',
        ));
  }

  void _onResetTextToBoldAndItalic() {
    setState(() {
      _isBoldText = false;
      _isItalic = false;
      _isDescriptionEmpty = false;
      _isTitleEmpty = false;
    });
    _onResetTextController();
  }

  void _onResetTextController() {
    widget.noteDescriptionTextController.clear();
    widget.noteTitleTextController.clear();
  }

  bool _isSumittedButtonValid() {
    return (_isTitleEmpty && _isDescriptionEmpty) ||
        (widget.noteDescriptionTextController.text.isNotEmpty &&
            widget.noteTitleTextController.text.isNotEmpty);
  }

  void _onAddOrEditNote() async {
    if (widget.selectedNote == null) {
      context.read<NoteBloc>().add(
            AddNoteRequested(
              param: NoteDto(
                  description: widget.noteDescriptionTextController.text,
                  title: widget.noteTitleTextController.text,
                  isBold: _isBoldText,
                  isItalic: _isItalic,
                  userId: GuardRouteService.currentUser?.id.toString() ?? ''),
            ),
          );
    } else {
      context.read<NoteBloc>().add(
            EditNoteRequested(
              param: NoteDto(
                description: widget.noteDescriptionTextController.text,
                title: widget.noteTitleTextController.text,
                isBold: _isBoldText,
                isItalic: _isItalic,
                isCompleted: widget.selectedNote?.isCompleted ?? false,
                userId: GuardRouteService.currentUser?.id.toString() ?? '',
                id: widget.selectedNote?.id,
              ),
            ),
          );
    }
  }

  void _onChangeTextToBold() {
    setState(() {
      _isBoldText = !_isBoldText;
    });
  }

  void _onChangeTextToItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  void _onShowSnackBar(
    BuildContext context,
    String message,
  ) {
    SnackBarService.showSnackBar(
      context: context,
      message: message,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedNote != null) {
      setState(() {
        widget.noteDescriptionTextController.text =
            widget.selectedNote?.description ?? '';
        widget.noteTitleTextController.text = widget.selectedNote?.title ?? '';
        _isBoldText = widget.selectedNote?.isBold ?? false;
        _isItalic = widget.selectedNote?.isItalic ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (BuildContext context, NoteState state) {
        if (state is NoteFailed) {
          _onShowSnackBar(context, state.message);
        }
        if (state is EditNoteSuccess || state is AddNoteSuccess) {
          _onLoadNotes();
          _onResetTextToBoldAndItalic();
        }
      },
      builder: (BuildContext context, NoteState state) {
        return Flexible(
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.08),
                    border: const Border(
                        bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.2,
                    )),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: const Text(
                    addNewNote,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    controller: widget.noteTitleTextController,
                    onChanged: (String? value) {
                      setState(() {
                        _isTitleEmpty = (value ?? '').isNotEmpty;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      hintText: addtitle,
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: SizedBox(
                    height: 120,
                    child: TextFormField(
                      minLines: 120,
                      maxLines: null,
                      onChanged: (String? value) {
                        setState(() {
                          _isDescriptionEmpty = (value ?? '').isNotEmpty;
                        });
                      },
                      controller: widget.noteDescriptionTextController,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontWeight:
                            _isBoldText ? FontWeight.bold : FontWeight.normal,
                        fontStyle:
                            _isItalic ? FontStyle.italic : FontStyle.normal,
                      ),
                      decoration: const InputDecoration(
                        hintText: addDescription,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        padding: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _onChangeTextToItalic,
                              icon: Icon(
                                Icons.format_italic,
                                color: _isItalic
                                    ? Colors.blueAccent
                                    : Colors.black,
                                size: 16,
                              ),
                            ),
                            IconButton(
                              onPressed: _onChangeTextToBold,
                              icon: Icon(
                                Icons.format_bold,
                                size: 16,
                                color: _isBoldText
                                    ? Colors.blueAccent
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      widget.selectedNote != null
                          ? Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    widget.onResetSelectedNote();
                                    _onResetTextController();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    cancel,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      MaterialButton(
                        onPressed:
                            _isSumittedButtonValid() ? _onAddOrEditNote : null,
                        disabledColor: Colors.blueAccent.withOpacity(
                          0.3,
                        ),
                        height: 42,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.blueAccent,
                        child: state is AddAndEditLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : const Text(
                                save,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
