import 'package:equatable/equatable.dart';
import '../../domain/entities/lock_fund_entity.dart';

abstract class LockFundsState extends Equatable {
  const LockFundsState();

  @override
  List<Object?> get props => [];
}

class LockFundsInitial extends LockFundsState {
  const LockFundsInitial();
}

class LockFundsLoading extends LockFundsState {
  const LockFundsLoading();
}

class LockFundsLoaded extends LockFundsState {
  final List<LockFund> lockFunds;
  final Map<String, dynamic> statistics;

  const LockFundsLoaded({
    required this.lockFunds,
    required this.statistics,
  });

  @override
  List<Object?> get props => [lockFunds, statistics];
}

class LockFundDetailsLoaded extends LockFundsState {
  final LockFund lockFund;
  final List<LockTransaction> transactions;

  const LockFundDetailsLoaded({
    required this.lockFund,
    required this.transactions,
  });

  @override
  List<Object?> get props => [lockFund, transactions];
}

class LockFundCreating extends LockFundsState {
  const LockFundCreating();
}

class LockFundCreated extends LockFundsState {
  final LockFund lockFund;

  const LockFundCreated(this.lockFund);

  @override
  List<Object?> get props => [lockFund];
}

class LockFundUnlocking extends LockFundsState {
  const LockFundUnlocking();
}

class LockFundUnlocked extends LockFundsState {
  final double amountReturned;
  final double penaltyAmount;
  final double interestEarned;

  const LockFundUnlocked({
    required this.amountReturned,
    required this.penaltyAmount,
    required this.interestEarned,
  });

  @override
  List<Object?> get props => [amountReturned, penaltyAmount, interestEarned];
}

class InterestCalculated extends LockFundsState {
  final InterestCalculation calculation;

  const InterestCalculated(this.calculation);

  @override
  List<Object?> get props => [calculation];
}

class LockFundTopUpSuccess extends LockFundsState {
  final LockFund updatedLockFund;
  final double newBalance;
  final String message;

  const LockFundTopUpSuccess({
    required this.updatedLockFund,
    required this.newBalance,
    required this.message,
  });

  @override
  List<Object?> get props => [updatedLockFund, newBalance, message];
}

class PiggyVaultConfigsLoaded extends LockFundsState {
  final List<PiggyVaultConfig> configs;

  const PiggyVaultConfigsLoaded(this.configs);

  @override
  List<Object?> get props => [configs];
}

class AutoSaveLoaded extends LockFundsState {
  final LockFundAutoSaveConfig? autoSave;

  const AutoSaveLoaded(this.autoSave);

  @override
  List<Object?> get props => [autoSave];
}

class AutoSaveCreated extends LockFundsState {
  final LockFundAutoSaveConfig autoSave;

  const AutoSaveCreated(this.autoSave);

  @override
  List<Object?> get props => [autoSave];
}

class LockFundsError extends LockFundsState {
  final String message;

  const LockFundsError(this.message);

  @override
  List<Object?> get props => [message];
}
