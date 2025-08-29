import '../../domain/entities/account_balance.dart' as domain;
import '../../../../core/data/database.dart';
import 'package:drift/drift.dart';

class AccountBalanceModel {
  final int? id;
  final double balance;
  final DateTime lastUpdated;
  final String? note;

  const AccountBalanceModel({
    this.id,
    required this.balance,
    required this.lastUpdated,
    this.note,
  });

  // Convert from database entity to domain entity
  factory AccountBalanceModel.fromDatabase(AccountBalanceData balance) {
    return AccountBalanceModel(
      id: balance.id,
      balance: balance.balance,
      lastUpdated: balance.lastUpdated,
      note: balance.note,
    );
  }

  // Convert to domain entity
  domain.AccountBalance toDomain() {
    return domain.AccountBalance(
      id: id,
      balance: balance,
      lastUpdated: lastUpdated,
      note: note,
    );
  }

  // Convert from domain entity to database companion
  AccountBalanceCompanion toDatabaseCompanion() {
    return AccountBalanceCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      balance: Value(balance),
      lastUpdated: Value(lastUpdated),
      note: note != null ? Value(note!) : const Value.absent(),
    );
  }
}
