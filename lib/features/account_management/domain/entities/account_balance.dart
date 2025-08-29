import 'package:equatable/equatable.dart';

class AccountBalance extends Equatable {
  final int? id;
  final double balance;
  final DateTime lastUpdated;
  final String? note;

  const AccountBalance({
    this.id,
    required this.balance,
    required this.lastUpdated,
    this.note,
  });

  @override
  List<Object?> get props => [id, balance, lastUpdated, note];

  AccountBalance copyWith({
    int? id,
    double? balance,
    DateTime? lastUpdated,
    String? note,
  }) {
    return AccountBalance(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      note: note ?? this.note,
    );
  }
}
