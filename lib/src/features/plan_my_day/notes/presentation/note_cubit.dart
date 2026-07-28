import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/src/features/plan_my_day/notes/data/note_repository.dart';
import 'package:lazervault/src/features/plan_my_day/notes/domain/note.dart';

sealed class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NotesLoaded extends NoteState {
  final List<Note> notes;
  NotesLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository _repository;
  NoteCubit(this._repository) : super(NoteInitial());

  Future<void> loadNotes() async {
    emit(NoteLoading());
    try {
      emit(NotesLoaded(await _repository.getNotes()));
    } catch (e) {
      if (!isClosed) emit(NoteError(_msg(e)));
    }
  }

  Future<void> saveNote({String? id, required String title, required String content}) async {
    try {
      final note = Note(id: id ?? '', userId: '', title: title, content: content);
      if (id != null && id.isNotEmpty) {
        await _repository.updateNote(id, note);
      } else {
        await _repository.createNote(note);
      }
      await loadNotes();
    } catch (e) {
      if (!isClosed) emit(NoteError(_msg(e)));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);
      await loadNotes();
    } catch (e) {
      if (!isClosed) emit(NoteError(_msg(e)));
    }
  }

  String _msg(Object e) => e.toString().replaceFirst('Exception: ', '');
}
