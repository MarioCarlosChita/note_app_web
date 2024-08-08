import 'package:equatable/equatable.dart';

import '../../../shared/dtos/note_dto.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/status_note_use_case.dart';

abstract class NoteEvent extends Equatable {}

class NotesRequested extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class AddNoteRequested extends NoteEvent {
  AddNoteRequested({
    required this.param,
  });

  final NoteDto param;
  @override
  List<NoteDto> get props => [
        param,
      ];
}

class EditNoteRequested extends NoteEvent {
  EditNoteRequested({
    required this.param,
  });

  final NoteDto param;

  @override
  List<NoteDto> get props => [
        param,
      ];
}

class RemoveNoteRequested extends NoteEvent {
  RemoveNoteRequested({
    required this.id,
  });

  final int id;
  @override
  List<Object> get props => [
        id,
      ];
}

class NoteStatusRequested extends NoteEvent {
  NoteStatusRequested({
    required this.param,
  });

  final NoteStatusParam param;

  @override
  List<NoteStatusParam> get props => [
        param,
      ];
}

class SortNoteRequested extends NoteEvent {
  SortNoteRequested({
    required this.isCompletedOrder,
    required this.notes,
  });

  final bool isCompletedOrder;
  final List<NoteEntity> notes;

  @override
  List<dynamic> get props => [
        notes,
        isCompletedOrder,
      ];
}
