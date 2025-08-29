import '../entities/account_balance.dart';
import '../entities/transaction.dart';

abstract class AccountRepository {
  // Account Balance operations
  Future<AccountBalance?> getCurrentBalance();
  Future<AccountBalance> updateBalance(double newBalance, String? note);
  Future<AccountBalance> addToBalance(double amount, String? note);
  
  // Transaction operations
  Future<Transaction> addTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactionHistory({
    DateTime? fromDate,
    DateTime? toDate,
    TransactionType? type,
    int? limit,
  });
  Future<List<Transaction>> getTransactionsByTradeId(int tradeId);
  
  // Trade-related operations
  Future<void> processTradeResult({
    required int tradeId,
    required double pnl,
    required double fees,
    required double balanceBefore,
  });
  
  // Statistics
  Future<double> getTotalDeposits();
  Future<double> getTotalWithdrawals();
  Future<double> getTotalTradePnL();
}
