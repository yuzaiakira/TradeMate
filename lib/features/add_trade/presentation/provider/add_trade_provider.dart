import 'package:flutter/foundation.dart';
import '../../domain/entities/trade.dart' as domain;
import '../../domain/usecases/add_trade_usecase.dart';
import '../../../../core/data/database.dart';

enum AddTradeStatus { initial, loading, success, error }

class AddTradeProvider with ChangeNotifier {
  final AddTradeUseCase addTradeUseCase;
  final TradeMateDatabase database;
  VoidCallback? _onTradeAdded;
  VoidCallback? _onBalanceUpdated;

  AddTradeProvider(this.addTradeUseCase, this.database);

  // Set callback to be called when a trade is successfully added
  void setOnTradeAddedCallback(VoidCallback callback) {
    _onTradeAdded = callback;
  }

  // Set callback to be called when balance is updated
  void setOnBalanceUpdatedCallback(VoidCallback callback) {
    _onBalanceUpdated = callback;
  }

  AddTradeStatus _status = AddTradeStatus.initial;
  String _errorMessage = '';
  domain.Trade? _currentTrade;

  AddTradeStatus get status => _status;
  String get errorMessage => _errorMessage;
  domain.Trade? get currentTrade => _currentTrade;

  // Trade Transfers
  String _tag = '';
  DateTime? _datetime;
  String? _exchanges;
  domain.EntryType? _entryType;
  String _symbol = '';
  String? _strategies;
  domain.Side? _side;
  double _entryPrice = 0.0;
  double? _positionMargin;
  double? _leverage;
  domain.OrderType? _orderType;
  String? _timeFrame;
  double? _entryFeeRate;
  String? _entryMentalStates;
  String? _entryScreenshot;
  
  // Checklist
  List<String>? _checklist;
  
  // Trade Management
  double? _stopLossPrice;
  double? _takeProfitPrice;
  
  // Trade Exit
  double? _actualExitPrice;
  double? _marginClosedPercent;
  domain.ExitType? _exitType;
  double? _exitFeeRate;
  DateTime? _exitDatetime;
  String? _exitMentalStates;
  String? _exitScreenshot;
  
  // Memo
  int? _rating;
  String _memo = '';
  
  // Trackings
  String? _trackings;
  String? _mistakes;
  
  // Transfers
  double? _transferAmount;
  String? _transferScreenshot;
  
  // Legacy fields (keeping for backward compatibility)
  domain.TradeType _type = domain.TradeType.buy;
  domain.TradeStatus _tradeStatus = domain.TradeStatus.open;
  double? _exitPrice;
  double _quantity = 0.0;
  double? _stopLoss;
  double? _takeProfit;
  double? _pnl;
  double? _pnlPercent;
  double? _riskRewardRatio;
  DateTime _entryDate = DateTime.now();
  DateTime? _exitDate;
  String _notes = '';
  String? _screenshotPath;
  double _accountBalance = 0.0;
  double? _riskAmount;
  double? _achievedR;
  int? _tradeDuration;

  // Getters
  String get tag => _tag;
  DateTime? get datetime => _datetime;
  String? get exchanges => _exchanges;
  domain.EntryType? get entryType => _entryType;
  String get symbol => _symbol;
  String? get strategies => _strategies;
  domain.Side? get side => _side;
  double get entryPrice => _entryPrice;
  double? get positionMargin => _positionMargin;
  double? get leverage => _leverage;
  domain.OrderType? get orderType => _orderType;
  String? get timeFrame => _timeFrame;
  double? get entryFeeRate => _entryFeeRate;
  String? get entryMentalStates => _entryMentalStates;
  String? get entryScreenshot => _entryScreenshot;
  List<String>? get checklist => _checklist;
  double? get stopLossPrice => _stopLossPrice;
  double? get takeProfitPrice => _takeProfitPrice;
  double? get actualExitPrice => _actualExitPrice;
  double? get marginClosedPercent => _marginClosedPercent;
  domain.ExitType? get exitType => _exitType;
  double? get exitFeeRate => _exitFeeRate;
  DateTime? get exitDatetime => _exitDatetime;
  String? get exitMentalStates => _exitMentalStates;
  String? get exitScreenshot => _exitScreenshot;
  int? get rating => _rating;
  String get memo => _memo;
  String? get trackings => _trackings;
  String? get mistakes => _mistakes;
  double? get transferAmount => _transferAmount;
  String? get transferScreenshot => _transferScreenshot;
  domain.TradeType get type => _type;
  domain.TradeStatus get tradeStatus => _tradeStatus;
  double? get exitPrice => _exitPrice;
  double get quantity => _quantity;
  double? get stopLoss => _stopLoss;
  double? get takeProfit => _takeProfit;
  double? get pnl => _pnl;
  double? get pnlPercent => _pnlPercent;
  double? get riskRewardRatio => _riskRewardRatio;
  DateTime get entryDate => _entryDate;
  DateTime? get exitDate => _exitDate;
  String get notes => _notes;
  String? get screenshotPath => _screenshotPath;
  double get accountBalance => _accountBalance;
  double? get riskAmount => _riskAmount;
  double? get achievedR => _achievedR;
  int? get tradeDuration => _tradeDuration;

  // Update methods for new fields
  void updateTag(String value) {
    _tag = value;
    notifyListeners();
  }

  void updateDatetime(DateTime value) {
    _datetime = value;
    notifyListeners();
  }

  void updateExchanges(String? value) {
    _exchanges = value;
    notifyListeners();
  }

  void updateEntryType(domain.EntryType? value) {
    _entryType = value;
    notifyListeners();
  }

  void updateSymbol(String value) {
    _symbol = value;
    notifyListeners();
  }

  void updateStrategies(String? value) {
    _strategies = value;
    notifyListeners();
  }

  void updateSide(domain.Side? value) {
    _side = value;
    notifyListeners();
  }

  void updateEntryPrice(double value) {
    _entryPrice = value;
    notifyListeners();
  }

  void updatePositionMargin(double? value) {
    _positionMargin = value;
    notifyListeners();
  }

  void updateLeverage(double? value) {
    _leverage = value;
    notifyListeners();
  }

  void updateOrderType(domain.OrderType? value) {
    _orderType = value;
    notifyListeners();
  }

  void updateTimeFrame(String? value) {
    _timeFrame = value;
    notifyListeners();
  }

  void updateEntryFeeRate(double? value) {
    _entryFeeRate = value;
    notifyListeners();
  }

  void updateEntryMentalStates(String? value) {
    _entryMentalStates = value;
    notifyListeners();
  }

  void updateEntryScreenshot(String? value) {
    _entryScreenshot = value;
    notifyListeners();
  }

  void updateChecklist(List<String>? value) {
    _checklist = value;
    notifyListeners();
  }

  void updateStopLossPrice(double? value) {
    _stopLossPrice = value;
    notifyListeners();
  }

  void updateTakeProfitPrice(double? value) {
    _takeProfitPrice = value;
    notifyListeners();
  }

  void updateActualExitPrice(double? value) {
    _actualExitPrice = value;
    notifyListeners();
  }

  void updateMarginClosedPercent(double? value) {
    _marginClosedPercent = value;
    notifyListeners();
  }

  void updateExitType(domain.ExitType? value) {
    _exitType = value;
    notifyListeners();
  }

  void updateExitFeeRate(double? value) {
    _exitFeeRate = value;
    notifyListeners();
  }

  void updateExitDatetime(DateTime? value) {
    _exitDatetime = value;
    notifyListeners();
  }

  void updateExitMentalStates(String? value) {
    _exitMentalStates = value;
    notifyListeners();
  }

  void updateExitScreenshot(String? value) {
    _exitScreenshot = value;
    notifyListeners();
  }

  void updateRating(int? value) {
    _rating = value;
    notifyListeners();
  }

  void updateMemo(String value) {
    _memo = value;
    notifyListeners();
  }

  void updateTrackings(String? value) {
    _trackings = value;
    notifyListeners();
  }

  void updateMistakes(String? value) {
    _mistakes = value;
    notifyListeners();
  }

  void updateTransferAmount(double? value) {
    _transferAmount = value;
    notifyListeners();
  }

  void updateTransferScreenshot(String? value) {
    _transferScreenshot = value;
    notifyListeners();
  }

  // Legacy update methods
  void updateType(domain.TradeType value) {
    _type = value;
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

  Future<void> loadCurrentAccountBalance() async {
    try {
      final currentBalance = await database.getCurrentAccountBalance();
      _accountBalance = currentBalance;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading current account balance: $e');
      // Keep the current balance if loading fails
    }
  }

  // Calculate risk amount
  double? get calculatedRiskAmount {
    if (_stopLossPrice == null) return null;
    final riskPerUnit = (_entryPrice - _stopLossPrice!).abs();
    return riskPerUnit * _quantity;
  }

  // Calculate risk/reward ratio
  double? get calculatedRiskRewardRatio {
    if (_stopLossPrice == null || _takeProfitPrice == null) return null;
    final risk = (_entryPrice - _stopLossPrice!).abs();
    final reward = (_takeProfitPrice! - _entryPrice).abs();
    if (risk == 0) return null;
    return reward / risk;
  }

  // Validate form
  bool get isFormValid {
    // Check if we have the basic required fields
    if (_symbol.isEmpty || _entryPrice <= 0 || _datetime == null || _side == null) {
      return false;
    }
    
    // Check if we have either quantity or positionMargin
    if (_quantity <= 0 && (_positionMargin == null || _positionMargin! <= 0)) {
      return false;
    }
    
    return true;
  }

  // Build trade from current form data
  domain.Trade buildTrade() {
    // Calculate quantity from positionMargin if available
    double calculatedQuantity = _quantity;
    if (_quantity <= 0 && _positionMargin != null && _positionMargin! > 0 && _entryPrice > 0) {
      calculatedQuantity = _positionMargin! / _entryPrice;
    }

    // Determine trade status based on exit information
    domain.TradeStatus determinedStatus = _tradeStatus;
    if (_actualExitPrice != null || _exitDatetime != null) {
      determinedStatus = domain.TradeStatus.closed;
    }

    return domain.Trade(
      // Trade Transfers
      tag: _tag.isEmpty ? null : _tag,
      datetime: _datetime ?? DateTime.now(),
      exchanges: _exchanges,
      entryType: _entryType,
      symbol: _symbol,
      strategies: _strategies,
      side: _side,
      entryPrice: _entryPrice,
      positionMargin: _positionMargin,
      leverage: _leverage,
      orderType: _orderType,
      timeFrame: _timeFrame,
      entryFeeRate: _entryFeeRate,
      entryMentalStates: _entryMentalStates,
      entryScreenshot: _entryScreenshot,
      // Checklist
      checklist: _checklist,
      // Trade Management
      stopLossPrice: _stopLossPrice,
      takeProfitPrice: _takeProfitPrice,
      // Trade Exit
      actualExitPrice: _actualExitPrice,
      marginClosedPercent: _marginClosedPercent,
      exitType: _exitType,
      exitFeeRate: _exitFeeRate,
      exitDatetime: _exitDatetime,
      exitMentalStates: _exitMentalStates,
      exitScreenshot: _exitScreenshot,
      // Memo
      rating: _rating,
      memo: _memo.isEmpty ? null : _memo,
      // Trackings
      trackings: _trackings,
      mistakes: _mistakes,
      // Transfers
      transferAmount: _transferAmount,
      transferScreenshot: _transferScreenshot,
      // Legacy fields
      type: _type,
      status: determinedStatus,
      exitPrice: _actualExitPrice,
      quantity: calculatedQuantity,
      stopLoss: _stopLossPrice,
      takeProfit: _takeProfitPrice,
      pnl: _pnl,
      pnlPercent: _pnlPercent,
      riskRewardRatio: _riskRewardRatio,
      entryDate: _entryDate,
      exitDate: _exitDatetime,
      notes: _notes.isEmpty ? null : _notes,
      screenshotPath: _screenshotPath,
      accountBalance: _accountBalance,
      riskAmount: _riskAmount,
      achievedR: _achievedR,
      tradeDuration: _tradeDuration,
    );
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

      final trade = buildTrade();
      
      // Debug: Print trade data
      debugPrint('Building trade with symbol: ${trade.symbol}, entryPrice: ${trade.entryPrice}, datetime: ${trade.datetime}');

      // Simulate a small delay to show loading state
      await Future.delayed(const Duration(milliseconds: 800));

      // Add timeout to prevent hanging
      final tradeId = await addTradeUseCase(trade).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Database operation timed out. Please try again.');
        },
      );
      
      debugPrint('Trade saved successfully with ID: $tradeId');
      
      _currentTrade = trade.copyWith(id: tradeId);
      _status = AddTradeStatus.success;
      _errorMessage = '';
      
      // Refresh account balance after trade is added
      await loadCurrentAccountBalance();
      
      // Notify balance updated callback
      _onBalanceUpdated?.call();
      
      // Don't reset form immediately - let the UI show success state first
      // _resetForm();
      
      notifyListeners();
      _onTradeAdded?.call(); // Notify the callback
    } catch (e) {
      debugPrint('Error adding trade: $e');
      _status = AddTradeStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void _resetForm() {
    // Trade Transfers
    _tag = '';
    _datetime = null;
    _exchanges = null;
    _entryType = null;
    _symbol = '';
    _strategies = null;
    _side = domain.Side.long; // Reset to default side instead of null
    _entryPrice = 0.0; // Keep as 0.0 for numeric field
    _positionMargin = null;
    _leverage = null;
    _orderType = null;
    _timeFrame = null;
    _entryFeeRate = null;
    _entryMentalStates = null;
    _entryScreenshot = null;
    
    // Checklist
    _checklist = null;
    
    // Trade Management
    _stopLossPrice = null;
    _takeProfitPrice = null;
    
    // Trade Exit
    _actualExitPrice = null;
    _marginClosedPercent = null;
    _exitType = null;
    _exitFeeRate = null;
    _exitDatetime = null;
    _exitMentalStates = null;
    _exitScreenshot = null;
    
    // Memo
    _rating = null;
    _memo = '';
    
    // Trackings
    _trackings = null;
    _mistakes = null;
    
    // Transfers
    _transferAmount = null;
    _transferScreenshot = null;
    
    // Legacy fields
    _type = domain.TradeType.buy; // Keep default for legacy compatibility
    _tradeStatus = domain.TradeStatus.open; // Keep default for legacy compatibility
    _exitPrice = null;
    _quantity = 0.0; // Keep as 0.0 for numeric field
    _stopLoss = null;
    _takeProfit = null;
    _pnl = null;
    _pnlPercent = null;
    _riskRewardRatio = null;
    _entryDate = DateTime.now(); // Keep current date for legacy compatibility
    _exitDate = null;
    _notes = '';
    _screenshotPath = null;
    // Don't reset account balance as it's usually constant
    _riskAmount = null;
    _achievedR = null;
    _tradeDuration = null;
  }

  void reset() {
    _status = AddTradeStatus.initial;
    _errorMessage = '';
    _currentTrade = null;
    _resetForm();
    notifyListeners();
  }

  void resetAfterSuccess() {
    _status = AddTradeStatus.initial;
    _errorMessage = '';
    _currentTrade = null;
    _resetForm();
    notifyListeners();
  }
}
