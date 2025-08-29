import 'package:drift/drift.dart';
import '../../../../core/data/database.dart';
import '../models/account_balance_model.dart';

abstract class AccountLocalDataSource {
  Future<AccountBalanceModel?> getCurrentBalance();
  Future<AccountBalanceModel> updateBalance(double newBalance, String? note);
  Future<AccountBalanceModel> addToBalance(double amount, String? note);
}

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final TradeMateDatabase database;

  AccountLocalDataSourceImpl({required this.database});

  @override
  Future<AccountBalanceModel?> getCurrentBalance() async {
    try {
      final result = await database.select(database.accountBalance).getSingleOrNull();
      if (result != null) {
        return AccountBalanceModel.fromDatabase(result);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current balance: $e');
    }
  }

  @override
  Future<AccountBalanceModel> updateBalance(double newBalance, String? note) async {
    try {
      final now = DateTime.now();
      
      // Check if balance record exists
      final existingBalance = await database.select(database.accountBalance).getSingleOrNull();
      
      if (existingBalance != null) {
        // Update existing record
        await database.update(database.accountBalance).replace(
          AccountBalanceCompanion(
            id: Value(existingBalance.id),
            balance: Value(newBalance),
            lastUpdated: Value(now),
            note: note != null ? Value(note) : const Value.absent(),
          ),
        );
        
        // Force sync to ensure data is written
        await database.ensureDataPersisted();
        
        return AccountBalanceModel(
          id: existingBalance.id,
          balance: newBalance,
          lastUpdated: now,
          note: note,
        );
      } else {
        // Create new record
        final id = await database.into(database.accountBalance).insert(
          AccountBalanceCompanion.insert(
            balance: newBalance,
            lastUpdated: now,
            note: note != null ? Value(note) : const Value.absent(),
          ),
        );
        
        // Force sync to ensure data is written
        await database.ensureDataPersisted();
        
        return AccountBalanceModel(
          id: id,
          balance: newBalance,
          lastUpdated: now,
          note: note,
        );
      }
    } catch (e) {
      throw Exception('Failed to update balance: $e');
    }
  }

  @override
  Future<AccountBalanceModel> addToBalance(double amount, String? note) async {
    try {
      final currentBalance = await getCurrentBalance();
      final currentAmount = currentBalance?.balance ?? 0.0;
      final newBalance = currentAmount + amount;
      
      return await updateBalance(newBalance, note);
    } catch (e) {
      throw Exception('Failed to add to balance: $e');
    }
  }
}
