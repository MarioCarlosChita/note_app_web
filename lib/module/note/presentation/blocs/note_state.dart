import 'package:equatable/equatable.dart';

import '../../domain/entities/note_entity.dart';

abstract class NoteState extends Equatable {}

class AddAndEditLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteFailed extends NoteState {
  NoteFailed({
    required this.message,
  });

  final String message;
  @override
  List<String> get props => [message];
}

class EditNoteSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}

class AddNoteSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}

class LoadedNotesSuccess extends NoteState {
  LoadedNotesSuccess({
    required this.notes,
  });

  final List<NoteEntity> notes;

  @override
  List<Object?> get props => [
        notes,
      ];
}

class RemoveNoteSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}

class RemoveNoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class StatusNoteSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}

class StatusNoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}
