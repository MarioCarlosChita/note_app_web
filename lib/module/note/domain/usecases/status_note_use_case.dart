import '../../../../core/usecase/usecases.dart';
import '../../../../core/utils/typedefs.dart';
import '../repository/note_repository.dart';

class NoteStatusParam {
  NoteStatusParam({
    required this.id,
    required this.noteStatus,
  });

  final bool noteStatus;
  final int id;
}

class StatusNoteUseCase extends UseCaseWithParams<bool, NoteStatusParam> {
  StatusNoteUseCase({
    required this.noteRepository,
  });
  final NoteRepository noteRepository;

  @override
  ResultFuture<bool> call(NoteStatusParam params) => noteRepository.statusNote(
        params.noteStatus,
        params.id,
      );
}
