import 'package:note_app_web/core/usecase/usecases.dart';
import 'package:note_app_web/core/utils/typedefs.dart';
import 'package:note_app_web/module/note/domain/repository/note_repository.dart';
import 'package:note_app_web/module/shared/dtos/note_dto.dart';

class EditNoteUseCase extends UseCaseWithParams<bool, NoteDto> {
  EditNoteUseCase({
    required this.noteRepository,
  });

  final NoteRepository noteRepository;

  @override
  ResultFuture<bool> call(
    NoteDto params,
  ) async =>
      noteRepository.editNote(param: params);
}
