import '../../../../core/usecases/usecase.dart';
import '../entities/account_balance.dart';
import '../repositories/account_repository.dart';

class UpdateBalanceParams {
  final double newBalance;
  final String? note;

  UpdateBalanceParams({required this.newBalance, this.note});
}

class UpdateBalance implements UseCase<AccountBalance, UpdateBalanceParams> {
  final AccountRepository repository;

  UpdateBalance(this.repository);

  @override
  Future<AccountBalance> call(UpdateBalanceParams params) async {
    return await repository.updateBalance(params.newBalance, params.note);
  }
}
