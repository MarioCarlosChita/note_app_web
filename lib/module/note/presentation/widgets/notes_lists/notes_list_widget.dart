import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../../core/enums/sort_type_note_enum.dart';
import '../../../../../core/services/snackbar_service.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../shared/widgets/list_note_loading_widget.dart';
import '../../../domain/entities/note_entity.dart';
import '../../../domain/usecases/status_note_use_case.dart';
import '../../blocs/note_bloc.dart';
import '../../blocs/note_event.dart';
import '../../blocs/note_state.dart';
import 'widget/note_item_widget.dart';

class NotesListWidget extends StatefulWidget {
  const NotesListWidget({
    required this.selectedNote,
    required this.onResetSelectedNote,
    required this.onSelectedNote,
    super.key,
  });

  final ValueSetter<NoteEntity> onSelectedNote;
  final VoidCallback onResetSelectedNote;
  final NoteEntity? selectedNote;

  @override
  State<NotesListWidget> createState() => _NotesListWidgetState();
}

class _NotesListWidgetState extends State<NotesListWidget> {
  final ValueNotifier<bool> _sortTypeWorking = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _sortTypeCompleted = ValueNotifier<bool>(false);
  final ValueNotifier<SortTypeNote> _sortTypeCompletedOrWorking =
      ValueNotifier(SortTypeNote.none);

  List<NoteEntity> _notes = [];
  int get _amountNotes => _notes.length;

  void _onLoadNotes() {
    context.read<NoteBloc>().add(NotesRequested());
  }

  void _onConfirmButtonIconPressed() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      onCancelBtnTap: () => context.pop(),
      onConfirmBtnTap: () {
        context.pop();
        _onConfirmNoteStatusBtnTap();
      },
    );
  }

  void _onRemoveButtonIconPressed() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      onCancelBtnTap: () => context.pop(),
      onConfirmBtnTap: () {
        context.pop();
        _onRemoveConfirmBtnTap();
      },
    );
  }

  void _onRemoveConfirmBtnTap() {
    context.read<NoteBloc>().add(
          RemoveNoteRequested(
            id: widget.selectedNote?.id ?? 0,
          ),
        );
    QuickAlert.show(
      context: context,
      barrierDismissible: false,
      type: QuickAlertType.loading,
    );
  }

  void _onConfirmNoteStatusBtnTap() {
    context.read<NoteBloc>().add(
          NoteStatusRequested(
            param: NoteStatusParam(
              id: widget.selectedNote?.id ?? 0,
              noteStatus: !(widget.selectedNote?.isCompleted ?? false),
            ),
          ),
        );

    QuickAlert.show(
      context: context,
      barrierDismissible: false,
      type: QuickAlertType.loading,
    );
  }

  void _onSortNotesTypeListen() {
    context.read<NoteBloc>().add(
          SortNoteRequested(
            isCompletedOrder:
                _sortTypeCompletedOrWorking.value == SortTypeNote.completed,
            notes: _notes,
          ),
        );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _onLoadNotes();
      },
    );
    _sortTypeCompletedOrWorking.addListener(_onSortNotesTypeListen);
  }

  @override
  Widget build(BuildContext context) {
    Size kDeviceSize = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocConsumer<NoteBloc, NoteState>(
          listener: (BuildContext context, NoteState state) {
            if (state is NoteFailed) {
              SnackBarService.showSnackBar(
                context: context,
                message: state.message,
              );
              context.pop();
            }

            if (state is EditNoteSuccess) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
              );
              widget.onResetSelectedNote();
              _onLoadNotes();
            }

            if (state is RemoveNoteSuccess || state is StatusNoteSuccess) {
              widget.onResetSelectedNote();
              _onLoadNotes();
              context.pop();
            }
            if (state is LoadedNotesSuccess) {
              setState(() {
                _notes = state.notes;
              });
            }
          },
          builder: (BuildContext context, NoteState state) {
            return Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.edit_document,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      allNotes,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: _amountNotes.toString(),
                        style: const TextStyle(color: Colors.blueAccent),
                        children: const [
                          TextSpan(
                            text: " $notes",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      offset: const Offset(0, 10),
                      elevation: 5.0,
                      color: Colors.white,
                      child: const Icon(
                        EvaIcons.options2Outline,
                        size: 24,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListenableBuilder(
                              listenable: _sortTypeWorking,
                              builder: (BuildContext context, Widget? child) {
                                return CheckboxListTile(
                                  value: _sortTypeWorking.value,
                                  activeColor: Colors.blueAccent,
                                  onChanged: (value) {
                                    if (!_sortTypeWorking.value) {
                                      _sortTypeWorking.value = true;
                                      _sortTypeCompleted.value = false;
                                    }
                                    // Sort  all notes ,first working notes and after completed;
                                    _sortTypeCompletedOrWorking.value =
                                        SortTypeNote.working;
                                  },
                                  title: const Text(working),
                                );
                              }),
                        ),
                        PopupMenuItem(
                          child: ListenableBuilder(
                              listenable: _sortTypeCompleted,
                              builder: (BuildContext context, Widget? child) {
                                return CheckboxListTile(
                                  value: _sortTypeCompleted.value,
                                  activeColor: Colors.blueAccent,
                                  onChanged: (value) {
                                    if (!_sortTypeCompleted.value) {
                                      _sortTypeCompleted.value = true;
                                      _sortTypeWorking.value = false;
                                    }
                                    // Sort   all notes , first completed notes and after working ;
                                    _sortTypeCompletedOrWorking.value =
                                        SortTypeNote.completed;
                                  },
                                  title: const Text(completed),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if (state is NoteLoading ||
                    state is RemoveNoteLoading ||
                    state is StatusNoteLoading)
                  const ListNoteLoadingWidget(),
                if (_notes.isEmpty && state is LoadedNotesSuccess)
                  const Center(
                    child: Text(emptyNotesList),
                  )
                else if (state is LoadedNotesSuccess)
                  LimitedBox(
                    maxHeight: kDeviceSize.height - kToolbarHeight - 5 * 64,
                    child: ListView.separated(
                      itemCount: _notes.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          index + 1 == _notes.length
                              ? const SizedBox.shrink()
                              : Divider(
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.23),
                                ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            widget.onSelectedNote(_notes[index]);
                          },
                          child: NoteItemWidget(
                            isSelected: _notes[index] == widget.selectedNote,
                            note: _notes[index],
                            onConfirmButtonPressed: _onConfirmButtonIconPressed,
                            onRemoveButtonPressed: _onRemoveButtonIconPressed,
                          ),
                        );
                      },
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sortTypeWorking.dispose();
    _sortTypeCompleted.dispose();
    _sortTypeCompletedOrWorking.removeListener(_onSortNotesTypeListen);
    _sortTypeCompletedOrWorking.dispose();
    super.dispose();
  }
}
