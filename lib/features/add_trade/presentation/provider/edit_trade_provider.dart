import 'package:flutter/material.dart';
import '../../domain/entities/trade.dart' as domain;
import '../../domain/usecases/update_trade_usecase.dart';
import '../../domain/usecases/get_trades_usecase.dart';
import '../../../../core/data/database.dart';

enum EditTradeStatus { initial, loading, success, error }

class EditTradeProvider extends ChangeNotifier {
  final UpdateTradeUseCase updateTradeUseCase;
  final GetTradesUseCase getTradesUseCase;
  final TradeMateDatabase database;
  VoidCallback? _onTradeUpdated;
  VoidCallback? _onBalanceUpdated;
  
  EditTradeProvider({
    required this.updateTradeUseCase,
    required this.getTradesUseCase,
    required this.database,
  });

  // Set callback to be called when a trade is successfully updated
  void setOnTradeUpdatedCallback(VoidCallback callback) {
    _onTradeUpdated = callback;
  }

  // Set callback to be called when balance is updated
  void setOnBalanceUpdatedCallback(VoidCallback callback) {
    _onBalanceUpdated = callback;
  }

  EditTradeStatus _status = EditTradeStatus.initial;
  String _errorMessage = '';
  domain.Trade? _tradeToEdit;

  EditTradeStatus get status => _status;
  String get errorMessage => _errorMessage;
  domain.Trade? get tradeToEdit => _tradeToEdit;

  // Initialize the provider with a trade to edit
  void initializeWithTrade(domain.Trade trade) {
    _tradeToEdit = trade;
    _status = EditTradeStatus.initial;
    _errorMessage = '';
    notifyListeners();
  }

  // Update trade
  Future<void> updateTrade(domain.Trade updatedTrade) async {
    if (_tradeToEdit == null) {
      _setError('No trade selected for editing');
      return;
    }

    _setLoading();

    try {
      final success = await updateTradeUseCase(updatedTrade);
      
      if (success) {
        _setSuccess();
        _onTradeUpdated?.call(); // Notify the callback if it's set
      } else {
        _setError('Failed to update trade');
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Refresh account balance from database
  Future<void> refreshAccountBalance() async {
    try {
      await database.getCurrentAccountBalance();
      // Notify balance updated callback
      _onBalanceUpdated?.call();
      // Notify listeners that balance has been refreshed
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing account balance: $e');
    }
  }

  void _setLoading() {
    _status = EditTradeStatus.loading;
    _errorMessage = '';
    notifyListeners();
  }

  void _setSuccess() {
    _status = EditTradeStatus.success;
    _errorMessage = '';
    notifyListeners();
  }

  void _setError(String message) {
    _status = EditTradeStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  void reset() {
    _status = EditTradeStatus.initial;
    _errorMessage = '';
    _tradeToEdit = null;
    notifyListeners();
  }
}
