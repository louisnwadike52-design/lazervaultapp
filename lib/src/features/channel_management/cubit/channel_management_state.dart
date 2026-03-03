import 'package:equatable/equatable.dart';
import '../domain/entities/channel_registration.dart';
import '../domain/entities/channel_pin_status.dart';

abstract class ChannelManagementState extends Equatable {
  const ChannelManagementState();

  @override
  List<Object?> get props => [];
}

class ChannelManagementInitial extends ChannelManagementState {
  const ChannelManagementInitial();
}

class ChannelManagementLoading extends ChannelManagementState {
  const ChannelManagementLoading();
}

class ChannelManagementLoaded extends ChannelManagementState {
  final List<ChannelRegistration> registrations;
  final List<ChannelPinStatus> pinStatuses;

  const ChannelManagementLoaded({
    required this.registrations,
    required this.pinStatuses,
  });

  ChannelRegistration? getRegistration(String channelType) {
    try {
      return registrations.firstWhere((r) => r.channelType == channelType);
    } catch (_) {
      return null;
    }
  }

  ChannelPinStatus? getPinStatus(String channelType) {
    try {
      return pinStatuses.firstWhere((p) => p.channelType == channelType);
    } catch (_) {
      return null;
    }
  }

  @override
  List<Object?> get props => [registrations, pinStatuses];
}

class ChannelManagementError extends ChannelManagementState {
  final String message;

  const ChannelManagementError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChannelOtpSent extends ChannelManagementState {
  final String channelType;
  final String maskedPhone;

  const ChannelOtpSent({
    required this.channelType,
    required this.maskedPhone,
  });

  @override
  List<Object?> get props => [channelType, maskedPhone];
}

class ChannelActivated extends ChannelManagementState {
  final ChannelRegistration registration;

  const ChannelActivated(this.registration);

  @override
  List<Object?> get props => [registration];
}

class ChannelDeactivated extends ChannelManagementState {
  final String channelType;

  const ChannelDeactivated(this.channelType);

  @override
  List<Object?> get props => [channelType];
}

class ChannelPinCreated extends ChannelManagementState {
  final String channelType;

  const ChannelPinCreated(this.channelType);

  @override
  List<Object?> get props => [channelType];
}

class ChannelPinChanged extends ChannelManagementState {
  final String channelType;

  const ChannelPinChanged(this.channelType);

  @override
  List<Object?> get props => [channelType];
}
