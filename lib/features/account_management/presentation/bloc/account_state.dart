import 'package:equatable/equatable.dart';
import '../../domain/entities/account_balance.dart';
import '../../domain/entities/transaction.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountLoading extends AccountState {
  const AccountLoading();
}

class AccountLoaded extends AccountState {
  final AccountBalance balance;
  final List<Transaction> transactions;
  final double totalDeposits;
  final double totalWithdrawals;
  final double totalTradePnL;

  const AccountLoaded({
    required this.balance,
    required this.transactions,
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.totalTradePnL,
  });

  @override
  List<Object?> get props => [balance, transactions, totalDeposits, totalWithdrawals, totalTradePnL];

  AccountLoaded copyWith({
    AccountBalance? balance,
    List<Transaction>? transactions,
    double? totalDeposits,
    double? totalWithdrawals,
    double? totalTradePnL,
  }) {
    return AccountLoaded(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      totalDeposits: totalDeposits ?? this.totalDeposits,
      totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
      totalTradePnL: totalTradePnL ?? this.totalTradePnL,
    );
  }
}

class AccountError extends AccountState {
  final String message;

  const AccountError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TransactionHistoryLoaded extends AccountState {
  final List<Transaction> transactions;

  const TransactionHistoryLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class TransactionHistoryError extends AccountState {
  final String message;

  const TransactionHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

