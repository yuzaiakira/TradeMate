import '../repositories/trade_repository.dart';

class DeleteTradeUseCase {
  final TradeRepository repository;

  DeleteTradeUseCase(this.repository);

  Future<void> call(int tradeId) async {
    await repository.deleteTrade(tradeId);
  }
}
