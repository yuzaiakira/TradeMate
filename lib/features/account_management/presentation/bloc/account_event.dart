import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class LoadAccountBalance extends AccountEvent {
  const LoadAccountBalance();
}

class UpdateAccountBalance extends AccountEvent {
  final double newBalance;
  final String? note;

  const UpdateAccountBalance({required this.newBalance, this.note});

  @override
  List<Object?> get props => [newBalance, note];
}

class AddToBalance extends AccountEvent {
  final double amount;
  final String? note;

  const AddToBalance({required this.amount, this.note});

  @override
  List<Object?> get props => [amount, note];
}

class AddTransaction extends AccountEvent {
  final Transaction transaction;

  const AddTransaction({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class LoadTransactionHistory extends AccountEvent {
  final DateTime? fromDate;
  final DateTime? toDate;
  final TransactionType? type;
  final int? limit;

  const LoadTransactionHistory({
    this.fromDate,
    this.toDate,
    this.type,
    this.limit,
  });

  @override
  List<Object?> get props => [fromDate, toDate, type, limit];
}

class ProcessTradeResult extends AccountEvent {
  final int tradeId;
  final double pnl;
  final double fees;
  final double balanceBefore;

  const ProcessTradeResult({
    required this.tradeId,
    required this.pnl,
    required this.fees,
    required this.balanceBefore,
  });

  @override
  List<Object?> get props => [tradeId, pnl, fees, balanceBefore];
}
