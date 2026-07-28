import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact_interaction.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';

sealed class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactsLoaded extends ContactState {
  final List<Contact> contacts;
  ContactsLoaded(this.contacts);
}

class ContactDetailLoaded extends ContactState {
  final Contact contact;
  final List<ContactInteraction> interactions;
  final List<Task> tasks;
  ContactDetailLoaded(this.contact, this.interactions,
      {this.tasks = const []});
}

class ContactError extends ContactState {
  final String message;
  ContactError(this.message);
}
