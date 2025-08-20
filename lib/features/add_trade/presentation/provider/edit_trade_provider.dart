import 'package:flutter/material.dart';
import '../../domain/entities/trade.dart';
import '../../domain/usecases/update_trade_usecase.dart';
import '../../domain/usecases/get_trades_usecase.dart';

enum EditTradeStatus { initial, loading, success, error }

class EditTradeProvider extends ChangeNotifier {
  final UpdateTradeUseCase updateTradeUseCase;
  final GetTradesUseCase getTradesUseCase;
  
  EditTradeStatus _status = EditTradeStatus.initial;
  String _errorMessage = '';
  Trade? _tradeToEdit;

  EditTradeProvider({
    required this.updateTradeUseCase,
    required this.getTradesUseCase,
  });

  EditTradeStatus get status => _status;
  String get errorMessage => _errorMessage;
  Trade? get tradeToEdit => _tradeToEdit;

  // Initialize the provider with a trade to edit
  void initializeWithTrade(Trade trade) {
    _tradeToEdit = trade;
    _status = EditTradeStatus.initial;
    _errorMessage = '';
    notifyListeners();
  }

  // Update trade
  Future<void> updateTrade(Trade updatedTrade) async {
    if (_tradeToEdit == null) {
      _setError('No trade selected for editing');
      return;
    }

    _setLoading();

    try {
      final success = await updateTradeUseCase(updatedTrade);
      
      if (success) {
        _setSuccess();
      } else {
        _setError('Failed to update trade');
      }
    } catch (e) {
      _setError(e.toString());
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
