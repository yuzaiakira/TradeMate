import '../../../../core/usecases/usecase.dart';
import '../entities/account_balance.dart';
import '../repositories/account_repository.dart';

class GetAccountBalance implements UseCase<AccountBalance?, NoParams> {
  final AccountRepository repository;

  GetAccountBalance(this.repository);

  @override
  Future<AccountBalance?> call(NoParams params) async {
    return await repository.getCurrentBalance();
  }
}
