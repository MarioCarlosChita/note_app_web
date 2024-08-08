import 'package:note_app_web/core/usecase/usecases.dart';
import 'package:note_app_web/core/utils/typedefs.dart';
import 'package:note_app_web/module/note/domain/entities/note_entity.dart';
import 'package:note_app_web/module/note/domain/repository/note_repository.dart';

class GetNoteUseCase extends UseCaseWithoutParams<List<NoteEntity>> {
  GetNoteUseCase({
    required this.noteRepository,
  });
  final NoteRepository noteRepository;

  @override
  ResultFuture<List<NoteEntity>> call() async => noteRepository.getNotes();
}
