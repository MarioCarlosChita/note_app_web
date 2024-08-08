import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../shared/dtos/note_dto.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repository/note_repository.dart';
import '../data_remote_source/note_remote_data_source.dart';

class NoteRepositoryImpl extends NoteRepository {
  NoteRepositoryImpl({
    required this.noteRemoteDataSource,
  });

  final NoteRemoteDataSource noteRemoteDataSource;

  @override
  ResultFuture<List<NoteEntity>> getNotes() async {
    try {
      final List<NoteEntity> responseData =
          await noteRemoteDataSource.getNotes();
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'getNotes',
      );
    }
  }

  @override
  ResultFuture<bool> addNote({required NoteDto param}) async {
    try {
      final bool responseData = await noteRemoteDataSource.addNote(param);
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'addNote',
      );
    }
  }

  @override
  ResultFuture<bool> editNote({required NoteDto param}) async {
    try {
      final bool responseData = await noteRemoteDataSource.editNote(param);
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'editNote',
      );
    }
  }

  @override
  ResultFuture<bool> removeNote(int id) async {
    try {
      final bool responseData = await noteRemoteDataSource.removeNote(id);
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'removeNote',
      );
    }
  }

  @override
  ResultFuture<bool> statusNote(bool noteStatus, int id) async {
    try {
      final bool responseData = await noteRemoteDataSource.statusNote(
        noteStatus,
        id,
      );
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'statusNote',
      );
    }
  }
}
