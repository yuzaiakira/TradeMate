import '../../../../core/usecases/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';

class AddTransaction implements UseCase<Transaction, Transaction> {
  final AccountRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Transaction> call(Transaction transaction) async {
    return await repository.addTransaction(transaction);
  }
}
