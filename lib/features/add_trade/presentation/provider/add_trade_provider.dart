import 'package:flutter/foundation.dart';
import '../../domain/entities/trade.dart';
import '../../domain/usecases/add_trade_usecase.dart';

enum AddTradeStatus { initial, loading, success, error }

class AddTradeProvider with ChangeNotifier {
  final AddTradeUseCase addTradeUseCase;

  AddTradeProvider(this.addTradeUseCase);

  AddTradeStatus _status = AddTradeStatus.initial;
  String _errorMessage = '';
  Trade? _currentTrade;

  AddTradeStatus get status => _status;
  String get errorMessage => _errorMessage;
  Trade? get currentTrade => _currentTrade;

  // Form fields
  String _symbol = '';
  TradeType _type = TradeType.buy;
  double _entryPrice = 0.0;
  double _quantity = 0.0;
  double? _stopLoss;
  double? _takeProfit;
  String _notes = '';
  double _accountBalance = 0.0;

  String get symbol => _symbol;
  TradeType get type => _type;
  double get entryPrice => _entryPrice;
  double get quantity => _quantity;
  double? get stopLoss => _stopLoss;
  double? get takeProfit => _takeProfit;
  String get notes => _notes;
  double get accountBalance => _accountBalance;

  void updateSymbol(String value) {
    _symbol = value;
    notifyListeners();
  }

  void updateType(TradeType value) {
    _type = value;
    notifyListeners();
  }

  void updateEntryPrice(double value) {
    _entryPrice = value;
    notifyListeners();
  }

  void updateQuantity(double value) {
    _quantity = value;
    notifyListeners();
  }

  void updateStopLoss(double? value) {
    _stopLoss = value;
    notifyListeners();
  }

  void updateTakeProfit(double? value) {
    _takeProfit = value;
    notifyListeners();
  }

  void updateNotes(String value) {
    _notes = value;
    notifyListeners();
  }

  void updateAccountBalance(double value) {
    _accountBalance = value;
    notifyListeners();
  }

  // Calculate risk amount
  double? get riskAmount {
    if (_stopLoss == null) return null;
    final riskPerUnit = (_entryPrice - _stopLoss!).abs();
    return riskPerUnit * _quantity;
  }

  // Calculate risk/reward ratio
  double? get riskRewardRatio {
    if (_stopLoss == null || _takeProfit == null) return null;
    final risk = (_entryPrice - _stopLoss!).abs();
    final reward = (_takeProfit! - _entryPrice).abs();
    if (risk == 0) return null;
    return reward / risk;
  }

  // Validate form
  bool get isFormValid {
    return _symbol.isNotEmpty && 
           _entryPrice > 0 && 
           _quantity > 0 && 
           _accountBalance > 0;
  }

  Future<void> addTrade() async {
    if (!isFormValid) {
      _status = AddTradeStatus.error;
      _errorMessage = 'Please fill in all required fields';
      notifyListeners();
      return;
    }

    try {
      _status = AddTradeStatus.loading;
      notifyListeners();

      final trade = Trade(
        symbol: _symbol,
        type: _type,
        status: TradeStatus.open,
        entryPrice: _entryPrice,
        quantity: _quantity,
        stopLoss: _stopLoss,
        takeProfit: _takeProfit,
        entryDate: DateTime.now(),
        notes: _notes.isEmpty ? null : _notes,
        accountBalance: _accountBalance,
        riskAmount: riskAmount,
        riskRewardRatio: riskRewardRatio,
      );

      final tradeId = await addTradeUseCase(trade);
      
      _currentTrade = trade.copyWith(id: tradeId);
      _status = AddTradeStatus.success;
      _errorMessage = '';
      
      // Reset form
      _resetForm();
      
      notifyListeners();
    } catch (e) {
      _status = AddTradeStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void _resetForm() {
    _symbol = '';
    _type = TradeType.buy;
    _entryPrice = 0.0;
    _quantity = 0.0;
    _stopLoss = null;
    _takeProfit = null;
    _notes = '';
    // Don't reset account balance as it's usually constant
  }

  void reset() {
    _status = AddTradeStatus.initial;
    _errorMessage = '';
    _currentTrade = null;
    _resetForm();
    notifyListeners();
  }
}
