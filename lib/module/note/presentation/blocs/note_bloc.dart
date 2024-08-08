import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/add_note_use_case.dart';
import '../../domain/usecases/edit_note_use_case.dart';
import '../../domain/usecases/get_note_use_case.dart';
import '../../domain/usecases/remove_note_use_case.dart';
import '../../domain/usecases/status_note_use_case.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({
    required this.getNoteUseCase,
    required this.addNoteUseCase,
    required this.editNoteUseCase,
    required this.removeNoteUseCase,
    required this.statusNoteUseCase,
  }) : super(NoteInitial()) {
    on<NotesRequested>(_onNotesRequested);
    on<AddNoteRequested>(_onAddNoteRequested);
    on<EditNoteRequested>(_onEditNoteRequested);
    on<RemoveNoteRequested>(_onRemoveNoteRequested);
    on<NoteStatusRequested>(_onNoteStatusRequested);
    on<SortNoteRequested>(_onSortNoteRequested);
  }

  final GetNoteUseCase getNoteUseCase;
  final EditNoteUseCase editNoteUseCase;
  final AddNoteUseCase addNoteUseCase;
  final RemoveNoteUseCase removeNoteUseCase;
  final StatusNoteUseCase statusNoteUseCase;

  Future<void> _onSortNoteRequested(
    SortNoteRequested event,
    Emitter<NoteState> emit,
  ) async {
    List<NoteEntity> notes = event.notes;
    _sortByIsCompleted(
      ascending: event.isCompletedOrder,
      notes: notes,
    );

    emit(
      LoadedNotesSuccess(
        notes: notes,
      ),
    );
  }

  Future<void> _onNoteStatusRequested(
    NoteStatusRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(StatusNoteLoading());
    final result = await statusNoteUseCase(event.param);
    result.fold(
      (Failure failure) => emit(
        NoteFailed(
          message: failure.message,
        ),
      ),
      (bool data) => emit(
        StatusNoteSuccess(),
      ),
    );
  }

  Future<void> _onRemoveNoteRequested(
    RemoveNoteRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(RemoveNoteLoading());
    final result = await removeNoteUseCase(event.id);
    result.fold(
      (Failure failure) => emit(
        NoteFailed(
          message: failure.message,
        ),
      ),
      (bool data) => emit(
        RemoveNoteSuccess(),
      ),
    );
  }

  Future<void> _onEditNoteRequested(
    EditNoteRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(AddAndEditLoading());

    final result = await editNoteUseCase(
      event.param,
    );

    result.fold(
      (Failure failure) => emit(
        NoteFailed(
          message: 'Error to edit a note.please try again.',
        ),
      ),
      (bool status) => emit(
        EditNoteSuccess(),
      ),
    );
  }

  Future<void> _onAddNoteRequested(
    AddNoteRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(AddAndEditLoading());

    debugPrint(event.param.toJson().toString());

    final result = await addNoteUseCase(
      event.param,
    );

    result.fold(
      (Failure failure) => emit(
        NoteFailed(
          message: 'Error to add a note. please try again.',
        ),
      ),
      (bool status) => emit(
        AddNoteSuccess(),
      ),
    );
  }

  Future<void> _onNotesRequested(
    NotesRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(NoteLoading());

    final resultData = await getNoteUseCase(event.userId);

    resultData.fold(
      (Failure failure) => emit(
        NoteFailed(
          message: failure.message,
        ),
      ),
      (List<NoteEntity> data) => emit(
        LoadedNotesSuccess(notes: data),
      ),
    );
  }

  void _sortByIsCompleted({
    bool ascending = true,
    required List<NoteEntity> notes,
  }) {
    notes.sort((a, b) {
      if (a.isCompleted == b.isCompleted) return 0;
      return ascending ? (a.isCompleted ? -1 : 1) : (a.isCompleted ? 1 : -1);
    });
  }
}
