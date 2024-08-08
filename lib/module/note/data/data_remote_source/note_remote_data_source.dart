import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/app_supabase_client.dart';
import '../../../shared/dtos/note_dto.dart';
import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes();

  Future<bool> addNote(NoteDto param);

  Future<bool> editNote(NoteDto param);

  Future<bool> removeNote(int id);

  Future<bool> statusNote(bool noteStatus, int id);
}

class NoteRemoteDataSourceImpl extends NoteRemoteDataSource {
  NoteRemoteDataSourceImpl({
    required this.appSupabaseClient,
  });
  final AppSupabaseClient appSupabaseClient;

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      List<Map<String, dynamic>> responseData =
          await appSupabaseClient.supabase.from('note_tb').select();

      List<NoteModel> notesData =
          List.from(responseData.map((note) => NoteModel.fromJson(note)));

      return notesData;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'getNotes',
      );
    }
  }

  @override
  Future<bool> addNote(
    NoteDto param,
  ) async {
    try {
      await appSupabaseClient.supabase.from('note_tb').insert(param.toJson());
      return true;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'getNotes',
      );
    }
  }

  @override
  Future<bool> editNote(
    NoteDto param,
  ) async {
    try {
      await appSupabaseClient.supabase
          .from('note_tb')
          .update(param.toJson())
          .eq('id', param.id ?? 0);
      return true;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'editNote',
      );
    }
  }

  @override
  Future<bool> removeNote(int id) async {
    try {
      await appSupabaseClient.supabase.from('note_tb').delete().eq('id', id);
      return true;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'editNote',
      );
    }
  }

  @override
  Future<bool> statusNote(bool noteStatus, int id) async {
    try {
      await appSupabaseClient.supabase.from('note_tb').update({
        'isCompleted': noteStatus,
      }).eq('id', id);
      return true;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'statusNote',
      );
    }
  }
}
