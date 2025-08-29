import '../../../../core/usecases/usecase.dart';
import '../repositories/account_repository.dart';

class DeleteTransaction implements UseCase<void, int> {
  final AccountRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<void> call(int transactionId) async {
    return await repository.deleteTransaction(transactionId);
  }
}
