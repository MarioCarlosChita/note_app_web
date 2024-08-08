import '../../../../core/usecase/usecases.dart';
import '../../../../core/utils/typedefs.dart';
import '../repository/note_repository.dart';

class RemoveNoteUseCase extends UseCaseWithParams<bool, int> {
  RemoveNoteUseCase({required this.noteRepository});
  final NoteRepository noteRepository;

  @override
  ResultFuture<bool> call(int params) async => noteRepository.removeNote(
        params,
      );
}
