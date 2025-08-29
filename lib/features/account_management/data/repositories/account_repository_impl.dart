import '../../../../core/error/failures.dart';
import '../../domain/entities/account_balance.dart' as domain;
import '../../domain/entities/transaction.dart' as domain_entity;
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_local_datasource.dart';
import '../datasources/transaction_local_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDataSource accountLocalDataSource;
  final TransactionLocalDataSource transactionLocalDataSource;

  AccountRepositoryImpl({
    required this.accountLocalDataSource,
    required this.transactionLocalDataSource,
  });

  @override
  Future<domain.AccountBalance?> getCurrentBalance() async {
    try {
      final balance = await accountLocalDataSource.getCurrentBalance();
      if (balance != null) {
        return balance.toDomain();
      } else {
        // Initialize with zero balance if no record exists
        final newBalance = await accountLocalDataSource.updateBalance(0.0, 'Initial balance');
        return newBalance.toDomain();
      }
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<domain.AccountBalance> updateBalance(double newBalance, String? note) async {
    try {
      final balance = await accountLocalDataSource.updateBalance(newBalance, note);
      return balance.toDomain();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<domain.AccountBalance> addToBalance(double amount, String? note) async {
    try {
      final balance = await accountLocalDataSource.addToBalance(amount, note);
      return balance.toDomain();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<domain_entity.Transaction> addTransaction(domain_entity.Transaction transaction) async {
    try {
      final transactionModel = await transactionLocalDataSource.addTransaction(transaction);
      return transactionModel.toDomain();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<List<domain_entity.Transaction>> getTransactionHistory({
    DateTime? fromDate,
    DateTime? toDate,
    domain_entity.TransactionType? type,
    int? limit,
  }) async {
    try {
      final transactions = await transactionLocalDataSource.getTransactionHistory(
        fromDate: fromDate,
        toDate: toDate,
        type: type,
        limit: limit,
      );
      return transactions.map((t) => t.toDomain()).toList();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<List<domain_entity.Transaction>> getTransactionsByTradeId(int tradeId) async {
    try {
      final transactions = await transactionLocalDataSource.getTransactionsByTradeId(tradeId);
      return transactions.map((t) => t.toDomain()).toList();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> processTradeResult({
    required int tradeId,
    required double pnl,
    required double fees,
    required double balanceBefore,
  }) async {
    try {
      // Get current balance
      final currentBalance = await getCurrentBalance();
      if (currentBalance == null) {
        throw DatabaseFailure('No account balance found');
      }
      
      double newBalance = currentBalance.balance;
      
      // Process PnL
      if (pnl != 0) {
        final pnlTransaction = domain_entity.Transaction(
          type: pnl > 0 ? domain_entity.TransactionType.tradeProfit : domain_entity.TransactionType.tradeLoss,
          amount: pnl.abs(),
          note: 'Trade PnL',
          datetime: DateTime.now(),
          tradeId: tradeId,
          balanceBefore: newBalance,
          balanceAfter: newBalance + pnl,
        );
        
        await addTransaction(pnlTransaction);
        newBalance += pnl;
      }
      
      // Process fees
      if (fees > 0) {
        final feeTransaction = domain_entity.Transaction(
          type: domain_entity.TransactionType.tradeFee,
          amount: -fees, // Negative because fees reduce balance
          note: 'Trade fees',
          datetime: DateTime.now(),
          tradeId: tradeId,
          balanceBefore: newBalance,
          balanceAfter: newBalance - fees,
        );
        
        await addTransaction(feeTransaction);
        newBalance -= fees;
      }
      
      // Update final balance
      await updateBalance(newBalance, 'Trade result processed');
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<double> getTotalDeposits() async {
    try {
      final total = await transactionLocalDataSource.getTotalDeposits();
      return total;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<double> getTotalWithdrawals() async {
    try {
      final total = await transactionLocalDataSource.getTotalWithdrawals();
      return total;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<double> getTotalTradePnL() async {
    try {
      final total = await transactionLocalDataSource.getTotalTradePnL();
      return total;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }
}
