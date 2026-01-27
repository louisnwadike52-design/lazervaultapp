import 'package:equatable/equatable.dart';
import '../domain/entities/whatsapp_user.dart';
import '../domain/entities/security_settings.dart';

abstract class WhatsAppBankingState extends Equatable {
  const WhatsAppBankingState();

  @override
  List<Object?> get props => [];
}

class WhatsAppBankingInitial extends WhatsAppBankingState {
  const WhatsAppBankingInitial();
}

class WhatsAppBankingLoading extends WhatsAppBankingState {
  const WhatsAppBankingLoading();
}

class WhatsAppBankingLoaded extends WhatsAppBankingState {
  final WhatsAppUser? user;
  final SecuritySettings? settings;

  const WhatsAppBankingLoaded({this.user, this.settings});

  bool get isLinked => user != null && user!.isLinked;

  @override
  List<Object?> get props => [user, settings];
}

class WhatsAppBankingError extends WhatsAppBankingState {
  final String message;

  const WhatsAppBankingError(this.message);

  @override
  List<Object?> get props => [message];
}

class WhatsAppBankingOtpSent extends WhatsAppBankingState {
  final String otpReference;
  final String phoneNumber;

  const WhatsAppBankingOtpSent(
      {required this.otpReference, required this.phoneNumber});

  @override
  List<Object?> get props => [otpReference, phoneNumber];
}

class WhatsAppBankingLinkingSuccess extends WhatsAppBankingState {
  final WhatsAppUser user;

  const WhatsAppBankingLinkingSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class WhatsAppBankingUnlinkSuccess extends WhatsAppBankingState {
  const WhatsAppBankingUnlinkSuccess();
}

class WhatsAppBankingSettingsUpdated extends WhatsAppBankingState {
  final SecuritySettings settings;

  const WhatsAppBankingSettingsUpdated(this.settings);

  @override
  List<Object?> get props => [settings];
}
