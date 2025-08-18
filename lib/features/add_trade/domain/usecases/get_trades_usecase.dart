import '../repositories/trade_repository.dart';
import '../entities/trade.dart';

class GetTradesUseCase {
  final TradeRepository repository;

  GetTradesUseCase(this.repository);

  Future<List<Trade>> call() async {
    return await repository.getAllTrades();
  }
}
