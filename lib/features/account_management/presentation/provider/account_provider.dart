import 'package:flutter/material.dart';
import '../../domain/entities/account_balance.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/account_repository.dart';

enum AccountStatus {
  initial,
  loading,
  loaded,
  error,
}

class AccountProvider extends ChangeNotifier {
  final AccountRepository _accountRepository;

  AccountProvider(this._accountRepository);

  AccountStatus _status = AccountStatus.initial;
  AccountBalance? _balance;
  List<Transaction> _transactions = [];
  double _totalDeposits = 0.0;
  double _totalWithdrawals = 0.0;
  double _totalTradePnL = 0.0;
  String? _errorMessage;

  AccountStatus get status => _status;
  AccountBalance? get balance => _balance;
  List<Transaction> get transactions => _transactions;
  double get totalDeposits => _totalDeposits;
  double get totalWithdrawals => _totalWithdrawals;
  double get totalTradePnL => _totalTradePnL;
  String? get errorMessage => _errorMessage;

  Future<void> loadAccountData() async {
    _status = AccountStatus.loading;
    notifyListeners();

    try {
      final balance = await _accountRepository.getCurrentBalance();
      if (balance != null) {
        _balance = balance;
        
        // Load recent transactions
        _transactions = await _accountRepository.getTransactionHistory(limit: 10);
        
        // Load statistics
        _totalDeposits = await _accountRepository.getTotalDeposits();
        _totalWithdrawals = await _accountRepository.getTotalWithdrawals();
        _totalTradePnL = await _accountRepository.getTotalTradePnL();

        _status = AccountStatus.loaded;
        _errorMessage = null;
      } else {
        _status = AccountStatus.error;
        _errorMessage = 'No account balance found';
      }
    } catch (e) {
      _status = AccountStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> addToBalance(double amount, String? note) async {
    try {
      final currentBalance = _balance?.balance ?? 0.0;
      final newBalance = currentBalance + amount;
      
      // Check if withdrawal would result in negative balance
      if (amount < 0 && newBalance < 0) {
        _errorMessage = 'Insufficient funds. Available balance: \$${currentBalance.toStringAsFixed(2)}';
        notifyListeners();
        return;
      }
      
      // Determine transaction type based on amount
      final transactionType = amount > 0 
          ? TransactionType.deposit 
          : TransactionType.withdrawal;
      
      // Create transaction
      final transaction = Transaction(
        type: transactionType,
        amount: amount.abs(),
        note: note ?? (amount > 0 ? 'Deposit' : 'Withdrawal'),
        datetime: DateTime.now(),
        tradeId: null,
        balanceBefore: currentBalance,
        balanceAfter: newBalance,
      );
      
      // Add transaction to database
      await _accountRepository.addTransaction(transaction);
      
      // Update balance
      await _accountRepository.updateBalance(newBalance, note);

      // Reload account data
      await loadAccountData();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      await _accountRepository.deleteTransaction(transactionId);
      await loadAccountData();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
