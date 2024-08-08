import '../../../../core/utils/typedefs.dart';
import '../../../shared/dtos/note_dto.dart';
import '../entities/note_entity.dart';

abstract class NoteRepository {
  ResultFuture<List<NoteEntity>> getNotes();

  ResultFuture<bool> addNote({
    required NoteDto param,
  });

  ResultFuture<bool> editNote({
    required NoteDto param,
  });

  ResultFuture<bool> removeNote(int id);

  ResultFuture<bool> statusNote(
    bool noteStatus,
    int id,
  );
}
