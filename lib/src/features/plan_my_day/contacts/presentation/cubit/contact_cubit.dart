import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/src/features/plan_my_day/contacts/data/contact_repository.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact_interaction.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/presentation/cubit/contact_state.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactRepository _repository;
  List<Contact> _contacts = [];

  ContactCubit(this._repository) : super(ContactInitial());

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    emit(ContactLoading());
    try {
      _contacts = await _repository.getContacts();
      if (!isClosed) emit(ContactsLoaded(_contacts));
    } catch (e) {
      if (!isClosed) emit(ContactError(_msg(e)));
    }
  }

  Future<void> loadDetail(String id) async {
    emit(ContactLoading());
    try {
      final results = await Future.wait([
        _repository.getContact(id),
        _repository.getInteractions(id),
        // Linked tasks (People → tasks). Best-effort — a failure here shouldn't
        // block the profile; fall back to an empty list.
        _repository.getTasksForContact(id).catchError((_) => <Task>[]),
      ]);
      if (!isClosed) {
        emit(ContactDetailLoaded(
          results[0] as Contact,
          results[1] as List<ContactInteraction>,
          tasks: results[2] as List<Task>,
        ));
      }
    } catch (e) {
      if (!isClosed) emit(ContactError(_msg(e)));
    }
  }

  Future<void> createContact(Contact contact) async {
    try {
      await _repository.createContact(contact);
      await loadContacts();
    } catch (e) {
      if (!isClosed) emit(ContactError(_msg(e)));
    }
  }

  Future<void> updateContact(String id, Contact contact) async {
    try {
      await _repository.updateContact(id, contact);
      await loadDetail(id);
    } catch (e) {
      if (!isClosed) emit(ContactError(_msg(e)));
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _repository.deleteContact(id);
      await loadContacts();
    } catch (e) {
      if (!isClosed) emit(ContactError(_msg(e)));
    }
  }

  Future<void> logInteraction(String contactId, String type,
      {String? note}) async {
    try {
      await _repository.logInteraction(
        contactId,
        ContactInteraction(
          id: '',
          contactId: contactId,
          userId: '',
          type: type,
          note: note,
          occurredAt: DateTime.now(),
        ),
      );
      await loadDetail(contactId);
    } catch (e) {
      if (!isClosed) emit(ContactError(_msg(e)));
    }
  }

  String _msg(Object e) => e.toString().replaceFirst('Exception: ', '');
}
